import 'package:ThumbSir/common/reg.dart';
import 'package:ThumbSir/dao/add_new_needs_dao.dart';
import 'package:ThumbSir/dao/get_user_detail_by_id_dao.dart';
import 'package:ThumbSir/pages/broker/client/client_detail_page.dart';
import 'package:ThumbSir/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:ThumbSir/model/other_need_model.dart';

class BuyNeedDetailPage extends StatefulWidget {
  final cid;
  final mainNeed;
  final needReason;
  final userName;
  final coreNeedNames;
  final otherMsg;

  BuyNeedDetailPage({Key key,
    this.cid,this.mainNeed,this.needReason,this.userName,this.coreNeedNames,this.otherMsg
  }):super(key:key);
  @override
  _BuyNeedDetailPageState createState() => _BuyNeedDetailPageState();
}


class _BuyNeedDetailPageState extends State<BuyNeedDetailPage> {

  //其它需求类
  OtherNeeds _otherNeeds = new OtherNeeds();

  //默认是所有需求，下面通过对比传来的核心字符，会去除核心需求，最终是非核心需求
  List<BuyRequirement> reqList=new List();
  List<BuyRequirement> allList = new List();
  //核心需求列表
  List<BuyRequirement> coreList=new List();
  //非核心需求列表
  List<BuyRequirement> nonCoreList=new List();

  bool _loading = false;
  String otherChooses;

  final TextEditingController mapController=TextEditingController();
  RegExp mapReg;
  bool mapBool = false;
  final TextEditingController coreController1=TextEditingController();
  RegExp core1Reg;
  bool core1Bool = false;
  final TextEditingController coreController2=TextEditingController();
  RegExp core2Reg;
  bool core2Bool = false;
  final TextEditingController coreController3=TextEditingController();
  RegExp core3Reg;
  bool core3Bool = false;
  final TextEditingController otherController=TextEditingController();
  RegExp otherReg;
  bool otherBool = false;

  String core1choose="";
  String core2choose="";
  String core3choose="";

  List<String> tags = [];
  List idList = [];
  int itemLength = 0;
  List missionContent=new List();
  List<String> area = [];
  List<String> room = [];
  List<String> direction = [];
  List<String> lift =[];
  List<String> floor = [];
  List<String> age = [];
  List<String> finish = [];
  List<String> traffic =[];
  List<String> school = [];
  List<String> hospital = [];
  List<String> park = [];
  List<String> bank = [];
  List<String> manager = [];
  List<String> market = [];
  List<String> tax = [];
  List<String> special = [];

  List<Widget> nonCoreShowList = [];
  List<Widget> noncore = [];

  @override
  void initState() {
    mapReg = FeedBackReg;
    otherReg = TextReg;
    core1Reg = TextReg;
    core2Reg = TextReg;
    core3Reg = TextReg;
    area=["50平米以下","50-70平米","70-90平米","90-120平米","120-140平米","140-160平米","160-200平米","200平米以上","无要求"];
    room=["1居室","2居室","3居室","4居室","5居室及以上","无要求"];
    direction = ["东","南","西","北","无要求"];
    lift =["带电梯","无要求"];
    floor =["底层","低楼层","中楼层","高楼层","顶层","无要求"];
    age = ["5年以内","10年以内","15年以内","20年以内","20年以上","无要求"];
    finish = ["精装修","普通装修","毛坯房","无要求"];
    traffic = ["近公交","近地铁","无要求"];
    school = ["优质学区","普通学区","无要求"];
    hospital = ["三甲医院","普通医院","无要求"];
    park = ["有公园","无要求"];
    bank = ["有银行","无要求"];
    manager = ["优质物业","普通物业","无要求"];
    market = ["大型购物商场","大型超市","小区内超市","无要求"];
    tax = ["满五唯一","满两年","无要求"];
    special = ["安静","带车位","带小院","停车方便","绿化率高","容积率低","小区面积大","人车分流","视野好","无要求"];

    reqList.add(new BuyRequirement("面积", "50平米以下,50-70平米,70-90平米,90-120平米,120-140平米,140-160平米,160-200平米,200平米以上,无要求",3));
    reqList.add(new BuyRequirement("居室", "1居室,2居室,3居室,4居室,5居室及以上,无要求",3));
    reqList.add(new BuyRequirement("朝向", "东,南,西,北,无要求",3));
    reqList.add(new BuyRequirement("电梯","有电梯,没电梯,无要求",1));
    reqList.add(new BuyRequirement("楼层", "底层,低楼层,中楼层,高楼层,顶层,无要求",2));
    reqList.add(new BuyRequirement("楼龄", "5年以内,10年以内,15年以内,20年以内,20年以上,无要求",1));
    reqList.add(new BuyRequirement("装修", "精装修,普通装修,毛坯房,无要求",2));
    reqList.add(new BuyRequirement("交通", "近公交,近地铁,无要求",2));
    reqList.add(new BuyRequirement("学区", "优质学区,普通学区,无要求",1));
    reqList.add(new BuyRequirement("医院", "三甲医院,普通医院,无要求",1));
    reqList.add(new BuyRequirement("公园", "有公园,无要求",1));
    reqList.add(new BuyRequirement("银行", "有银行,无要求",1));
    reqList.add(new BuyRequirement("物业", "优质物业,普通物业,无要求",1));
    reqList.add(new BuyRequirement("商场", "大型购物商场,大型超市,小区内超市,无要求",3));
    reqList.add(new BuyRequirement("税费", "满五唯一,满两年,无要求",1));
    reqList.add(new BuyRequirement("特殊要求", "安静,带车位,带小院,停车方便,绿化率高,容积率低,小区面积大,人车分流,视野好,无要求",6));
    reqList.add(new BuyRequirement("其他", "a,b",1));

    //这里把所有的需求都加入,默认都为非核心需求，isCore为false

    //遍历一下需求List，如果有同传过来的一样，则为核心需求,会从reqList去除核心需求项，并加入到coreList里，最终reqList是非核心需求列表
    //coreList是核心需求列表
    reqList.forEach((element) {
      if(element!=null) {
        allList.add(element);
        if (widget.coreNeedNames.contains(element.reqName)) {
          coreList.add(element);
        }else{
          nonCoreList.add(element);
        }
      }
    });

    if(coreList.length>0&& nonCoreList.length>0){
      _addOtherList();
      noncore = nonCoreShowList;
    }

    super.initState();
  }

  _addOtherList(){
    if (nonCoreList.length>0) {

      for (var item in nonCoreList) {
        if(item.reqName!="其他"){
          nonCoreShowList.add(
              Column(
                children: [
                  Container(
                      width: 335,
                      margin: EdgeInsets.only(top: 10),
                      child: Row(
                        children: <Widget>[
                          Text(
                            item.reqName,
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF333333),
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )
                  ),
                  Container(
                      width: 335,
                      child: FormField<List<String>>(
                          initialValue: tags,
                          validator: (value) {
                            if (value.isEmpty) {
                              return '请选择核心任务的名称';
                            }
                            if (value.length > item.maxSelect) {
                              return "选择不可多于"+item.maxSelect.toString()+"项";
                            }
                            return null;
                          },
                          builder: (state) {
                            return Column(
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: ChipsChoice<String>.multiple(
                                      value: state.value,
                                      options:  ChipsChoiceOption.listFrom(
                                          source: item.reqOptions.split(','),
                                          // 存储形式
                                          value:(index,item)=>item,
                                          // 展示形式
                                          label: (index,item)=>item
                                      ),
                                      onChanged: (val) {
                                        state.didChange(val);
                                        //_otherNeeds.decoration="";
                                        String sel="";
                                        val.forEach((element) {
                                          sel+=element+",";
                                          //_otherNeeds.decoration=sel;
                                        });
                                        _CheckSelection(item.reqName, sel.substring(0,sel.lastIndexOf(',')));
                                      },
                                      itemConfig: ChipsChoiceItemConfig(
                                        selectedColor: Color(0xFF5580EB),
                                        selectedBrightness: Brightness.dark,
                                        unselectedColor: Color(0xFF5580EB),
                                        unselectedBorderOpacity: .3,
                                      ),
                                      isWrapped: true,
                                    ),
                                  ),
                                  Container(
                                      padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        state.errorText ?? state.value.length.toString() + '/'+item.maxSelect.toString()+' 可选',
                                        style: TextStyle(
                                            color: state.hasError
                                                ? Colors.redAccent
                                                : Colors.green
                                        ),
                                      )
                                  )
                                ]);}
                      )
                  ),
                ],
              )
          );
        }else{
          nonCoreShowList.add(
              Column(
                children: [
                  // 其他
                  Container(
                      width: 335,
                      margin: EdgeInsets.only(top: 10),
                      child: Row(
                        children: <Widget>[
                          Text(
                            item.reqName,
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF333333),
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )
                  ),
                  Container(
                    height: 50,
                    margin: EdgeInsets.only(top: 10,left: 30,right: 30,bottom: 30),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1,color: Color(0xFF5580EB)),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: TextField(
                      controller: otherController,
                      autofocus: false,
                      keyboardType: TextInputType.multiline,
                      onChanged: _onOtherChanged,
                      maxLines: null,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF999999),
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.none,
                      ),
                      decoration: InputDecoration(
                        hintText:'请填写需求内容，若有多个用逗号隔开，1~30字',
                        contentPadding: EdgeInsets.all(10),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              )
          );
        }
      }
    }
  }

  @override
  void dispose(){
    mapController.dispose();
    otherController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ProgressDialog(
            loading: _loading,
            msg:"加载中...",
            child:Container(
              // 背景
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image:AssetImage('images/circle.png'),
                    fit: BoxFit.fitWidth,
                  ),
                ),
                child: ListView(
                  children: <Widget>[
                    Column(
                        children: <Widget>[
                          // 导航栏
                          Padding(
                              padding: EdgeInsets.only(left: 15,top: 15,bottom: 25),
                              child:Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  // 首页和标题
                                  Row(
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: (){
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          width: 28,
                                          padding: EdgeInsets.only(top: 3),
                                          child: Image(image: AssetImage('images/back.png'),),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text(widget.userName+"的"+widget.mainNeed+"需求",style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFF5580EB),
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                        ),),
                                      )
                                    ],
                                  ),
                                ],
                              )
                          ),
                          // 核心需求

                          // Column(
                          //   children: core,
                          // ),

                          // 核心需求1
                          Column(
                            children: [
                              Container(
                                  width: 335,
                                  margin: EdgeInsets.only(top: 10),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        '核心需求：'+coreList[0].reqName,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF333333),
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  )
                              ),
                              coreList[0].reqName != "其他"?
                              Container(
                                  width: 335,
                                  child: FormField<List<String>>(
                                      initialValue: tags,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return '请选择核心任务的名称';
                                        }
                                        if (value.length > coreList[0].maxSelect) {
                                          return "选择不可多于"+coreList[0].maxSelect.toString()+"项";
                                        }
                                        return null;
                                      },
                                      builder: (state) {
                                        return Column(
                                            children: <Widget>[
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                child: ChipsChoice<String>.multiple(
                                                  value: state.value,
                                                  options:  ChipsChoiceOption.listFrom(
                                                      source: coreList[0].reqOptions.split(','),
                                                      // 存储形式
                                                      value:(index,item)=>item,
                                                      // 展示形式
                                                      label: (index,item)=>item
                                                  ),
                                                  onChanged: (val) {
                                                    state.didChange(val);
                                                    missionContent = val;
                                                    core1choose="";
                                                    val.forEach((element) {
                                                      var item=element;
                                                      core1choose+=item+',';
                                                      print(core1choose);
                                                      if(state.value != null){
                                                        setState(() {
                                                          itemLength = state.value.length;
                                                        });
                                                      }
                                                    });
                                                  },
                                                  itemConfig: ChipsChoiceItemConfig(
                                                    selectedColor: Color(0xFF5580EB),
                                                    selectedBrightness: Brightness.dark,
                                                    unselectedColor: Color(0xFF5580EB),
                                                    unselectedBorderOpacity: .3,
                                                  ),
                                                  isWrapped: true,
                                                ),
                                              ),
                                              Container(
                                                  padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(
                                                    state.errorText ?? state.value.length.toString() + '/'+coreList[0].maxSelect.toString()+' 可选',
                                                    style: TextStyle(
                                                        color: state.hasError
                                                            ? Colors.redAccent
                                                            : Colors.green
                                                    ),
                                                  )
                                              )
                                            ]);}
                                  )
                              )
                              :
                              Container(
                                height: 50,
                                margin: EdgeInsets.only(top: 10,left: 30,right: 30,bottom: 30),
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1,color: Color(0xFF5580EB)),
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                ),
                                child: TextField(
                                  controller: otherController,
                                  autofocus: false,
                                  keyboardType: TextInputType.multiline,
                                  onChanged: _onCore1OtherChanged,
                                  maxLines: null,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF999999),
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),
                                  decoration: InputDecoration(
                                    hintText:'请填写需求内容，若有多个用逗号隔开，1~30字',
                                    contentPadding: EdgeInsets.all(10),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              // 对核心需求的描述
                              Container(
                                width: 335,
                                margin: EdgeInsets.only(top: 0),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      '对核心需求-'+coreList[0].reqName+'的描述：',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF333333),
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 100,
                                margin: EdgeInsets.only(top: 10,left: 30,right: 30,bottom: 20),
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1,color: Color(0xFF5580EB)),
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                ),
                                child: TextField(
                                  controller: coreController1,
                                  autofocus: false,
                                  keyboardType: TextInputType.multiline,
                                  onChanged: _onCore1Changed,
                                  maxLines: null,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF999999),
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),
                                  decoration: InputDecoration(
                                    hintText:'请填写此项作为核心需求的原因或备注，5~300字',
                                    contentPadding: EdgeInsets.all(10),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // 核心需求2
                          coreList.length>1?
                          Column(
                            children: [
                              Container(
                                  width: 335,
                                  margin: EdgeInsets.only(top: 10),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        '核心需求：'+coreList[1].reqName,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF333333),
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  )
                              ),
                              coreList[1].reqName != "其他"?
                              Container(
                                  width: 335,
                                  child: FormField<List<String>>(
                                      initialValue: tags,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return '请选择核心任务的名称';
                                        }
                                        if (value.length > coreList[1].maxSelect) {
                                          return "选择不可多于"+coreList[1].maxSelect.toString()+"项";
                                        }
                                        return null;
                                      },
                                      builder: (state) {
                                        return Column(
                                            children: <Widget>[
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                child: ChipsChoice<String>.multiple(
                                                  value: state.value,
                                                  options:  ChipsChoiceOption.listFrom(
                                                      source: coreList[1].reqOptions.split(','),
                                                      // 存储形式
                                                      value:(index,item)=>item,
                                                      // 展示形式
                                                      label: (index,item)=>item
                                                  ),
                                                  onChanged: (val) {
                                                    state.didChange(val);
                                                    missionContent = val;
                                                    core2choose="";
                                                    val.forEach((element) {
                                                      var item=element;
                                                      core2choose+=item+',';
                                                      print(core2choose);
                                                      if(state.value != null){
                                                        setState(() {
                                                          itemLength = state.value.length;
                                                        });
                                                      }
                                                    });
                                                  },
                                                  itemConfig: ChipsChoiceItemConfig(
                                                    selectedColor: Color(0xFF5580EB),
                                                    selectedBrightness: Brightness.dark,
                                                    unselectedColor: Color(0xFF5580EB),
                                                    unselectedBorderOpacity: .3,
                                                  ),
                                                  isWrapped: true,
                                                ),
                                              ),
                                              Container(
                                                  padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(
                                                    state.errorText ?? state.value.length.toString() + '/'+coreList[1].maxSelect.toString()+' 可选',
                                                    style: TextStyle(
                                                        color: state.hasError
                                                            ? Colors.redAccent
                                                            : Colors.green
                                                    ),
                                                  )
                                              )
                                            ]);}
                                  )
                              )
                                  :
                              Container(
                                height: 50,
                                margin: EdgeInsets.only(top: 10,left: 30,right: 30,bottom: 30),
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1,color: Color(0xFF5580EB)),
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                ),
                                child: TextField(
                                  controller: otherController,
                                  autofocus: false,
                                  keyboardType: TextInputType.multiline,
                                  onChanged: _onCore2OtherChanged,
                                  maxLines: null,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF999999),
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),
                                  decoration: InputDecoration(
                                    hintText:'请填写需求内容，若有多个用逗号隔开，1~30字',
                                    contentPadding: EdgeInsets.all(10),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              // 对核心需求的描述
                              Container(
                                width: 335,
                                margin: EdgeInsets.only(top: 0),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      '对核心需求-'+coreList[1].reqName+'的描述：',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF333333),
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 100,
                                margin: EdgeInsets.only(top: 10,left: 30,right: 30,bottom: 20),
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1,color: Color(0xFF5580EB)),
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                ),
                                child: TextField(
                                  controller: coreController2,
                                  autofocus: false,
                                  keyboardType: TextInputType.multiline,
                                  onChanged: _onCore2Changed,
                                  maxLines: null,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF999999),
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),
                                  decoration: InputDecoration(
                                    hintText:'请填写此项作为核心需求的原因或备注，5~300字',
                                    contentPadding: EdgeInsets.all(10),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          )
                          :Container(width: 1,),
                          // 核心需求3
                          coreList.length>2?
                          Column(
                            children: [
                              Container(
                                  width: 335,
                                  margin: EdgeInsets.only(top: 10),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        '核心需求：'+coreList[2].reqName,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF333333),
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  )
                              ),
                              coreList[2].reqName != "其他"?
                              Container(
                                  width: 335,
                                  child: FormField<List<String>>(
                                      initialValue: tags,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return '请选择核心任务的名称';
                                        }
                                        if (value.length > coreList[2].maxSelect) {
                                          return "选择不可多于"+coreList[2].maxSelect.toString()+"项";
                                        }
                                        return null;
                                      },
                                      builder: (state) {
                                        return Column(
                                            children: <Widget>[
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                child: ChipsChoice<String>.multiple(
                                                  value: state.value,
                                                  options:  ChipsChoiceOption.listFrom(
                                                      source: coreList[2].reqOptions.split(','),
                                                      // 存储形式
                                                      value:(index,item)=>item,
                                                      // 展示形式
                                                      label: (index,item)=>item
                                                  ),
                                                  onChanged: (val) {
                                                    state.didChange(val);
                                                    missionContent = val;
                                                    core3choose="";
                                                    val.forEach((element) {
                                                      var item=element;
                                                      core3choose+=item+',';
                                                      print(core3choose);
                                                      if(state.value != null){
                                                        setState(() {
                                                          itemLength = state.value.length;
                                                        });
                                                      }
                                                    });
                                                  },
                                                  itemConfig: ChipsChoiceItemConfig(
                                                    selectedColor: Color(0xFF5580EB),
                                                    selectedBrightness: Brightness.dark,
                                                    unselectedColor: Color(0xFF5580EB),
                                                    unselectedBorderOpacity: .3,
                                                  ),
                                                  isWrapped: true,
                                                ),
                                              ),
                                              Container(
                                                  padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(
                                                    state.errorText ?? state.value.length.toString() + '/'+coreList[2].maxSelect.toString()+' 可选',
                                                    style: TextStyle(
                                                        color: state.hasError
                                                            ? Colors.redAccent
                                                            : Colors.green
                                                    ),
                                                  )
                                              )
                                            ]);}
                                  )
                              )
                                  :
                              Container(
                                height: 50,
                                margin: EdgeInsets.only(top: 10,left: 30,right: 30,bottom: 30),
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1,color: Color(0xFF5580EB)),
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                ),
                                child: TextField(
                                  controller: otherController,
                                  autofocus: false,
                                  keyboardType: TextInputType.multiline,
                                  onChanged: _onCore3OtherChanged,
                                  maxLines: null,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF999999),
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),
                                  decoration: InputDecoration(
                                    hintText:'请填写需求内容，若有多个用逗号隔开，1~30字',
                                    contentPadding: EdgeInsets.all(10),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              // 对核心需求的描述
                              Container(
                                width: 335,
                                margin: EdgeInsets.only(top: 0),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      '对核心需求-'+coreList[2].reqName+'的描述：',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF333333),
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 100,
                                margin: EdgeInsets.only(top: 10,left: 30,right: 30,bottom: 20),
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1,color: Color(0xFF5580EB)),
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                ),
                                child: TextField(
                                  controller: coreController3,
                                  autofocus: false,
                                  keyboardType: TextInputType.multiline,
                                  onChanged: _onCore3Changed,
                                  maxLines: null,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF999999),
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),
                                  decoration: InputDecoration(
                                    hintText:'请填写此项作为核心需求的原因或备注，5~300字',
                                    contentPadding: EdgeInsets.all(10),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          )
                              :Container(width: 1,),

                          // 非核心需求标题

                          Container(
                              width: 335,
                              margin: EdgeInsets.only(top: 10),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    '非核心需求：',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF333333),
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              )
                          ),

                          // 非核心需求
                          Column(
                            children: noncore,
                          ),

                          Container(
                            width: 335,
                            margin: EdgeInsets.only(top: 20),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  '综合描述：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF333333),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 100,
                            margin: EdgeInsets.only(top: 10,left: 30,right: 30),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1,color: Color(0xFF5580EB)),
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            child: TextField(
                              controller: mapController,
                              autofocus: false,
                              keyboardType: TextInputType.multiline,
                              onChanged: _onMapChanged,
                              maxLines: null,
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF999999),
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),
                              decoration: InputDecoration(
                                hintText:'请填写客户需求的综合描述，5~300字',
                                contentPadding: EdgeInsets.all(10),
                                border: InputBorder.none,
                              ),
                            ),
                          ),

                          // 完成
                          GestureDetector(
                            onTap: ()async{

                              if(_otherNeeds.elevator==null) {_otherNeeds.elevator = "无要求";}
                              if(_otherNeeds.floor==null){_otherNeeds.floor = "无要求";}
                              if(_otherNeeds.houseage==null){_otherNeeds.houseage = "无要求";}
                              if(_otherNeeds.bank==null){_otherNeeds.bank = "无要求";}
                              if(_otherNeeds.tax==null){_otherNeeds.tax = "无要求";}
                              if(_otherNeeds.decoration==null){_otherNeeds.decoration = "无要求";}
                              if(_otherNeeds.traffic==null){_otherNeeds.traffic = "无要求";}
                              if(_otherNeeds.school==null){_otherNeeds.school = "无要求";}
                              if(_otherNeeds.hospital==null){_otherNeeds.hospital = "无要求";}
                              if(_otherNeeds.park==null){_otherNeeds.park = "无要求";}
                              if(_otherNeeds.shop==null){_otherNeeds.shop = "无要求";}
                              if(_otherNeeds.property==null){_otherNeeds.property = "无要求";}
                              if(_otherNeeds.special==null){_otherNeeds.special = "无要求";}
                              if(_otherNeeds.area==null){_otherNeeds.area = "无要求";}
                              if(_otherNeeds.room==null){_otherNeeds.room = "无要求";}
                              if(_otherNeeds.direction==null){_otherNeeds.direction = "无要求";}
                              if(_otherNeeds.other==null){_otherNeeds.other = "无要求";}

                              otherChooses=otherNeedsToJson(_otherNeeds);
                              print(otherChooses);
                              _onRefresh();

                                var addResult = await AddNewNeedsDao.addNewNeeds(
                                  widget.cid.toString(),
                                  widget.mainNeed,
                                  widget.needReason,
                                  coreList[0].reqName!="其他"?(coreList[0].reqName+":"+core1choose.substring(0,core1choose.lastIndexOf(','))):(coreList[0].reqName+":"+otherController.text??"无要求"),
                                  coreController1.text,
                                  coreList.length<2?"暂无第二核心需求":coreList.length>1&&coreList[1].reqName!="其他"?(coreList[1].reqName+":"+core2choose.substring(0,core2choose.lastIndexOf(','))):(coreList[1].reqName+":"+otherController.text??"无要求"),
                                  coreController2.text,
                                  coreList.length<3?"暂无第三核心需求":coreList.length>2&&coreList[2].reqName!="其他"?(coreList[2].reqName+":"+core3choose.substring(0,core3choose.lastIndexOf(','))):(coreList[2].reqName+":"+otherController.text??"无要求"),
                                  coreController3.text,
                                  otherChooses+","+widget.otherMsg,
                                  mapController.text??"无",
                                  "2",
                                );
                                if (addResult.code == 200) {
                                  var getItem = await GetUserDetailBByIDDao.getUserDetailBByID(widget.cid.toString());
                                  if(getItem.code == 200){
                                    _onRefresh();
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ClientDetailPage(
                                      item:getItem.data[0],
                                      tabIndex: 0,
                                    )));
                                  }else {
                                    _onRefresh();
                                    _onOverLoadPressed(context);
                                  }
                                } else {
                                  _onRefresh();
                                  _onOverLoadPressed(context);
                                }

                              // }
                              // else{
                              //   // 必填信息不完整的弹窗
                              //   _onMsgPressed(context);
                              // }
                            },
                            child: Container(
                                width: 335,
                                height: 40,
                                padding: EdgeInsets.all(4),
                                margin: EdgeInsets.only(bottom: 50,top: 100),
                                decoration: BoxDecoration(
                                    border: Border.all(width: 1,color: Color(0xFF5580EB)),
                                    borderRadius: BorderRadius.circular(8),
                                    color: Color(0xFF5580EB)
                                ),
                                child: Padding(
                                    padding: EdgeInsets.only(top: 4),
                                    child: Text('完成',style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.none,
                                    ),textAlign: TextAlign.center,),
                                )
                            ),
                          )
                        ]
                    )
                  ],
                )
            )
        )
    );
  }

  _onOverLoadPressed(context) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "提交失败",
      desc: "请检查网络后重试",
      buttons: [
        DialogButton(
          child: Text(
            "确定",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () async {
            Navigator.pop(context);
          },
          color: Color(0xFF5580EB),
        ),
      ],
    ).show();
  }


  // 加载中loading
  Future<Null> _onRefresh() async {
    setState(() {
      _loading = !_loading;
    });
  }

  _CheckSelection(itemName,selOpts){
      switch(itemName){
        case "医院":
          _otherNeeds.hospital=selOpts;
          break;
        case "银行":
          _otherNeeds.bank=selOpts;
          break;
        case "电梯":
          _otherNeeds.elevator=selOpts;
          break;
        case "楼层":
          _otherNeeds.floor=selOpts;
          break;
        case "楼龄":
          _otherNeeds.houseage=selOpts;
          break;
        case "装修":
          _otherNeeds.decoration=selOpts;
          break;
        case "交通":
          _otherNeeds.traffic=selOpts;
          break;
        case "学区":
          _otherNeeds.school=selOpts;
          break;
        case "公园":
          _otherNeeds.park=selOpts;
          break;
        case "商场":
          _otherNeeds.shop=selOpts;
          break;
        case "税费":
          _otherNeeds.tax=selOpts;
          break;
        case "特殊要求":
          _otherNeeds.special=selOpts;
          break;
        case "其他":
          _otherNeeds.other=otherController.text??"无要求";
          break;
        case "面积":
          _otherNeeds.area=selOpts;
          break;
        case "居室":
          _otherNeeds.room=selOpts;
          break;
        case "朝向":
          _otherNeeds.direction=selOpts;
          break;
        case "物业":
          _otherNeeds.property=selOpts;
          break;
        default:
          break;
      }
  }

  _onMapChanged(String text){
    if(text != null){
      setState(() {
        mapBool = mapReg.hasMatch(mapController.text);
      });
    }
  }
  _onCore1Changed(String text){
    if(text != null){
      setState(() {
        core1Bool = core1Reg.hasMatch(coreController1.text);
      });
    }
  }
  _onCore2Changed(String text){
    if(text != null){
      setState(() {
        core2Bool = core2Reg.hasMatch(coreController2.text);
      });
    }
  }
  _onCore3Changed(String text){
    if(text != null){
      setState(() {
        core3Bool = core3Reg.hasMatch(coreController3.text);
      });
    }
  }
  _onOtherChanged(String text){
    if(text != null){
      setState(() {
        otherBool = otherReg.hasMatch(otherController.text);
        _otherNeeds.other=otherController.text==null?"无要求":otherController.text;
      });
    }
  }

  _onCore1OtherChanged(String text){
    if(text != null){
      setState(() {
        otherBool = otherReg.hasMatch(otherController.text);
        core1choose=otherController.text??"无要求";
      });
    }
  }
  _onCore2OtherChanged(String text){
    if(text != null){
      setState(() {
        otherBool = otherReg.hasMatch(otherController.text);
        core2choose=otherController.text??"无要求";
      });
    }
  }
  _onCore3OtherChanged(String text){
    if(text != null){
      setState(() {
        otherBool = otherReg.hasMatch(otherController.text);
        core3choose=otherController.text??"无要求";
      });
    }
  }
}



//所有需求类
class BuyRequirement {
  BuyRequirement(
    this.reqName,
    this.reqOptions,
    this.maxSelect
  );

  String reqName;
  String reqOptions;
  int maxSelect;
}


