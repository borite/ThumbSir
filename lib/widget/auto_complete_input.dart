import 'package:ThumbSir/dao/get_company_list_dao.dart';
import 'package:ThumbSir/model/company_list_model.dart';
import 'package:flutter/material.dart';
import 'package:simple_autocomplete_formfield/simple_autocomplete_formfield.dart';

final Future<CompanyList> getCompanyList = GetCompanyListDao.httpGetCompanyList();
final list = <ListItem>[ListItem('Alice'), ListItem('Bob')];

class ListItem {
  ListItem(this.name);
  final String name;
  @override
  String toString() => name;
}

class AutoCompleteInput extends StatefulWidget {
  @override
  _AutoCompleteInputState createState() => _AutoCompleteInputState();
}

class _AutoCompleteInputState extends State<AutoCompleteInput> {
  ListItem selectedItem;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  bool autovalidate = false;

  @override
  Widget build(BuildContext context) => Scaffold(
      key: scaffoldKey,
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          autovalidate: autovalidate,
          child: ListView(children: <Widget>[
            SizedBox(height: 16.0),
            Text('Selected listItem: "$selectedItem"'),
            SizedBox(height: 16.0),
            SimpleAutocompleteFormField<ListItem>(
              decoration: InputDecoration(
                  labelText: 'Person',
                  border: OutlineInputBorder()
              ),
              suggestionsHeight: 80.0,
              itemBuilder: (context, person) => Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          person.name,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ]),
              ),
              onSearch: (search) async => list
                  .where((person) =>
              person.name
                  .toLowerCase()
                  .contains(search.toLowerCase()))
                  .toList(),
              itemFromString: (string) => list.singleWhere(
                      (person) => person.name.toLowerCase() == string.toLowerCase(),
                  orElse: () => null),
              onChanged: (value) => setState(() => selectedItem = value),
              onSaved: (value) => setState(() => selectedItem = value),
              validator: (person) => person == null ? 'Invalid person.' : null,
            ),
            RaisedButton(
                child: Text('Submit'),
                onPressed: () {
                  if (formKey.currentState.validate()) {
                    formKey.currentState.save();
                    scaffoldKey.currentState
                        .showSnackBar(SnackBar(content: Text('Fields valid!')));
                  } else {
                    scaffoldKey.currentState.showSnackBar(
                        SnackBar(content: Text('Fix errors to continue.')));
                    setState(() => autovalidate = true);
                  }
                })
          ]),
        ),
      ));
}