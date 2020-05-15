class SigninModel {
  final String UserName;
  final String Phone;
  final String Password;
  final String yzm;
  final String CompanyID;

  SigninModel({this.UserName,this.Phone,this.Password,this.yzm,this.CompanyID});

  factory SigninModel.fromJson(Map<String,dynamic> json){
    return SigninModel(
      UserName: json['UserName'],
      Phone: json['Phone'],
      Password: json['Password'],
      yzm: json['yzm'],
      CompanyID: json['CompanyID'],
    );
  }
}