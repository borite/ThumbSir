final RegExp userNameReg = new RegExp(r"^[A-Za-z0-9\u4e00-\u9fa5]{2,20}$");
final RegExp telPhoneReg = new RegExp(r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
//final RegExp passwordReg = new RegExp(r"\d{6}$");
final RegExp passwordReg = new RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,18}$"); //6-18位数字、字母组合、字母包含大小写，禁止使用符号
final RegExp verifyCodeReg = new RegExp(r"^\d{6}$"); // 验证码，6位数字
final RegExp invitationCodeReg = new RegExp(r"^\d{7}$");  // 邀请码，7位数字
final RegExp TextReg = new RegExp(r"^[\u4e00-\u9fa5]+$");  // 文本，至少1个汉字
final RegExp CreditCodeReg = new RegExp(r"^[A-Za-z0-9]{18}$");  // 社会统一信用代码
final RegExp FeedBackReg = new RegExp(r"^\S{5,300}$"); // 意见反馈，5~300个汉字、字母或数字,或者包含5~300个汉字
final RegExp taskReg = new RegExp(r"^[A-Za-z0-9\u4e00-\u9fa5]{1,5}$"); // 1~5个字或字母（汉字、字母、数字）