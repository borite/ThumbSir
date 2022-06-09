class LoginModel {
  final String Phone;
  final String Password;

  LoginModel({required this.Phone,required this.Password});

  factory LoginModel.fromJson(Map<String,dynamic> json){
    return LoginModel(
      Phone: json['Phone'],
      Password: json['Password'],
    );
  }
}