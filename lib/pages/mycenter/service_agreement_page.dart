import 'package:flutter/material.dart';

class ServiceAgreementPage extends StatefulWidget {
  @override
  _ServiceAgreementPageState createState() => _ServiceAgreementPageState();
}

class _ServiceAgreementPageState extends State<ServiceAgreementPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // 背景
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image:AssetImage('images/circle_middle.png'),
            fit: BoxFit.fitWidth,
          ),
        ),
        child: ListView(
          children: <Widget>[
            Column(
                children: <Widget>[
                  // 导航栏
                  Padding(
                      padding: EdgeInsets.all(15),
                      child:Row(
                            children: <Widget>[
                              GestureDetector(
                                onTap: (){
                                  Navigator.pop(context);
                                },
                                child: Image(image: AssetImage('images/back.png'),),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Text('服务协议',style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF0E7AE6),
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),),
                              )
                            ],
                          ),
                  ),
                  // 标题
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Text('服务协议',style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),),
                  ),
                  // 内容
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 30),
                    child: Text('欢迎使用拇指先生服务（以下简称“服务”）！',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('提示：在使用服务之前，您应当认真阅读并遵守《拇指先生服务协议》（以下简称“本协议”），请您务必审慎阅读、充分理解各条款内容，特别是免除或者限制责任的条款、争议解决和法律适用条款。',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('当您按照注册页面提示填写信息、阅读并同意本协议且完成全部注册程序后，或您按照激活页面提示填写信息、阅读并同意本协议且完成全部激活程序后，即表示您已充分阅读、理解并接受本协议的全部内容，本协议即产生法律约束力。您承诺接受并遵守本协议的约定，届时您不应以未阅读本协议的内容或者未获得呼和浩特市波日特科技有限责任公司对您问询的解答等理由，主张本协议无效，或要求撤销本协议。',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('一、缔约主体',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('本协议由通过拇指先生客户端软件及其他方式使用服务的用户（以下简称“用户”或“您”）与呼和浩特市波日特科技有限责任公司（以下简称波日特）共同缔结。',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('二、协议内容和效力',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('1、本协议内容包括本协议正文及所有波日特已经发布或将来可能发布的隐私政策、各项政策、规则、声明、通知、警示、提示、说明（以下简称“规则”）。前述规则为本协议不可分割的组成部分，与协议正文具有同等法律效力。',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('2、有权根据需要不时制订、修改本协议及相关规则，变更后的协议和规则一经公布，立即取代原协议及规则并自动生效。如您不同意相关变更，应当立即停止使用拇指先生服务，如您继续使用服务或进行任何网站活动，即表示您已接受经修订的协议和规则。',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('三、服务内容',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('1、本服务内容包含支持通讯录、任务下达、客户/业主管理维护等技术功能，这些功能服务可能根据用户需求的变化，随着因服务版本不同、或服务提供方的单方判断而被优化或修改，或因定期、不定期的维护而暂缓提供。',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('2、同时，波日特保留在任何时候自行决定对服务或服务任何部分及其相关功能、应用软件变更、升级、修改、转移的权利。您同意，对于上述行为，波日特均不需通知，并且对您和任何第三人不承担任何责任。',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('3、您可以申请管理账号，通过审核后可通过该管理账号上传和管理成员通信录，邀请成员加入，并通过拇指先生服务实现内部成员管理、工作互动等目的。',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('四、注册及账号管理',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('1、您确认，在您完成注册程序或以其他波日特允许的方式实际使用服务时，您应当是具备完全民事权利能力和与所从事的民事行为相适应的行为能力的自然人、法人或其他组织。若您不具备前述主体资格，请勿使用服务，否则您及您的监护人应承担因此而导致的一切后果，且波日特有权注销（永久冻结）您的账户，并向您及您的监护人索偿。如您代表一家公司或其他法律主体进行注册或以其他波日特允许的方式实际使用本服务，则您声明和保证，您有权使该公司或该法律主体受本协议“条款“的约束。',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('2、您注册时应提交真实、准确、完整和反映当前情况的身份及其他相关信息，并在信息发生变化后及时更新，否则波日特有权停止服务并收回账号，因此产生的损失由您自行承担。',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('3、您可以使用您提供或确认的手机号或者波日特允许的其它方式作为账号进行注册，并承诺注册的账号名称、头像和简介等信息中不得出现违法和不良信息，，不得冒充他人进行注册，不得未经许可为他人注册，不得以可能导致其他用户误认的方式注册账号，不得使用可能侵犯他人权益的用户名进行注册（包括但不限于涉嫌商标权、名誉权侵权等），否则波日特有权不予注册或停止服务并收回账号，因此产生的损失由您自行承担。',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('4、您了解并同意，钉钉注册账号（包括客户端账号及服务管理账号）所有权归属于波日特，注册完成后，您仅获得账号使用权。钉钉账号使用权仅归属于初始申请注册人，不得以任何方式转让或被提供予他人使用，否则，波日特有权立即不经通知收回该账号，由此带来的因您使用本服务产生的全部数据、信息等被清空、丢失等的损失，您应自行承担。',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('5、在您成功注册后，波日特将根据账号和密码确认您的身份。您应妥善保管您的终端及账户和密码，并对利用该账户和密码所进行的一切活动（包括但不限于网上点击同意或提交各类规则协议或购买服务、分享资讯或图片、发起电话会议等）负全部责任。您承诺，在密码或账户遭到未获授权的使用，或者发生其他任何安全问题时，将立即通知波日特，且您同意并确认，波日特不对上述情形产生的任何直接或间接的遗失或损害承担责任。除非有法律规定或司法裁定，且征得波日特的同意，否则，您的账户、密码不得以任何方式转让、赠与或继承（与账户相关的财产权益除外）。',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('6、您了解并同意，如您注册钉钉账号后连续超过12个月未登录，波日特为网站优化管理之目的有权回收该账号，相关问题及责任均由您自行承担。',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('7、波日特根据本协议收回或取消账号后，有权自行对账号相关内容及信息以包括但不限于删除等方式进行处理，且无需就此向用户承担任何责任；如果账号为管理员账号，波日特有权取消和删除该管理员账号以及通信录成员基于该企业的一切信息和相关权益，包括但不限于解除与企业之间的服务关系、解散企业通信录、取消通信录成员与该企业相关的权益、删除管理员账号中的所有信息、删除企业通信录成员基于企业的所有信息等。',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('五、服务使用规范',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('1、用户充分了解并同意，波日特仅为用户提供服务平台，您应自行对利用服务从事的所有行为及结果承担责任。相应地，您应了解，使用拇指先生服务可能发生来自他人非法或不当行为（或信息）的风险，您应自行判断及行动，并自行承担相应的风险。',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('2、您应自行承担因使用服务所产生的费用，包括但不限于上网流量费、通信服务费等。',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('3、除非另有说明，本协议项下的服务只能用于非商业用途。您承诺不对本服务任何部分或本服务之使用或获得，进行复制、拷贝、出售、转售或用于包括但不限于广告及任何其它商业目的。',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('4、您承诺不会利用本服务进行任何违法或不当的活动，包括但不限于下列行为：',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('4.1上载、传送或分享含有下列内容之一的信息：',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('(a) 反对宪法所确定的基本原则的；',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('(b) 危害国家安全，泄露国家秘密，颠覆国家政权，破坏国家统一的；',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('(c) 损害国家荣誉和利益的；',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('(d) 煽动民族仇恨、民族歧视、破坏民族团结的；',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('(e) 破坏国家宗教政策，宣扬邪教和封建迷信的；',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('(f) 散布谣言，扰乱社会秩序，破坏社会稳定的；',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('(g) 散布淫秽、色情、赌博、暴力、凶杀、恐怖或者教唆犯罪的；',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('(h) 侮辱或者诽谤他人，侵害他人合法权利的；',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('(i) 含有虚假、诈骗、有害、胁迫、侵害他人隐私、骚扰、侵害、中伤、粗俗、猥亵、或其它道德上令人反感的内容；',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('(j) 含有中国法律、法规、规章、条例以及任何具有法律效力之规范所限制或禁止的其它内容的；',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('4.2 冒充任何人或机构，或以虚伪不实的方式陈述或谎称与任何人或机构有关；',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('4.3 伪造标题或以其他方式操控识别资料，使人误认为该内容为波日特或其关联公司所传送；',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('4.4 将依据任何法律或合约或法定关系（例如由于雇佣关系和依据保密合约所得知或揭露之内部资料、专属及机密资料）知悉但无权传送之任何内容加以上载、传送或分享；',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('4.5 将涉嫌侵害他人权利（包括但不限于著作权、专利权、商标权、商业秘密等知识产权）之内容上载、传送或分享；',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('4.6 跟踪或以其它方式骚扰他人, 或通过本服务向好友或其他用户发送大量信息；',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('4.7 将任何广告、推广信息、促销资料、“垃圾邮件”、“滥发信件”、“连锁信件”、“直销”或其它任何形式的劝诱资料加以上载、传送或分享；供前述目的使用的专用区域或专用功能除外；',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('4.8 因本服务并非为某些特定目的而设计，您不可将本服务用于包括但不限于核设施、军事用途、医疗设施、交通通讯等重要领域。如果因为软件或服务的原因导致上述操作失败而带来的人员伤亡、财产损失和环境破坏等，波日特不承担法律责任；',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('4.9 进行任何超出正常的好友或用户之间内部或外部信息沟通、交流等目的的行为；',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('4.10 违反遵守法律法规、社会主义制度、国家利益、公民合法利益、公共秩序、社会道德风尚和信息真实性等“七条底线”要求的行为；',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('4.11 从事任何违反中国法律、法规、规章、政策及规范性文件的行为。',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('5、您承诺不对本软件和服务从事以下行为：',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('5.1 将有关干扰、破坏或限制任何计算机软件、硬件或通讯设备功能的软件病毒或其他计算机代码、档案和程序之资料，加以上载、张贴、发送电子邮件或以其他方式传送；',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('5.2 干扰或破坏本服务或与本服务相连线之服务器和网络，或违反任何关于本服务连线网络之规定、程序、政策或规范；',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('5.3 通过修改或伪造软件运行中的指令、数据，增加、删减、变动软件的功能或运行效果，或者将用于上述用途的软件、方法进行运营或向公众传播，无论这些行为是否为商业目的；',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('5.4 通过非波日特开发、授权的第三方软件、插件、外挂、系统，登录或使用软件及服务，或制作、发布、传播上述工具；',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('5.5 自行、授权他人或利用第三方软件对本软件及其组件、模块、数据等进行干扰。',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('6、您承诺，使用钉钉服务时您将严格遵守本协议(包括本协议第一条所述规则)。',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('7、您同意并接受波日特无须时时监控您上载、传送或分享的资料及信息，但波日特有权对您使用服务的情况进行审查、监督并采取相应行动，包括但不限于删除信息、中止或终止服务，及向有关机关报告。',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('8、您承诺不以任何形式使用本服务侵犯波日特的商业利益，或从事任何可能对波日特造成损害或不利于波日特的行为。',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('9、您了解并同意，在波日特服务提供过程中，波日特及其关联公司或其授权单位和个人有权以各种方式投放各种商业性广告或其他任何类型的推广信息，同时，您同意接受以电子邮件或其他方式向您发送的上述广告或推广信息。',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('10、如您申请服务管理账号，则应自行通过账号添加和管理成员，并对管理成员的行为自行承担责任，波日特根据您服务管理账号的行为对成员服务的调整亦由您承担后果，因此给波日特或他人造成损失的，您应当予以赔偿。',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('11、您充分了解并同意，您必须为自己注册帐号下的一切行为负责，包括您所发表的任何内容以及由此产生的任何后果。您应对使用本服务时接触到的内容自行加以判断，并承担因使用内容而引起的所有风险，包括因对内容的正确性、完整性或实用性的依赖而产生的风险。波日特无法且不会对您因前述风险而导致的任何损失或损害承担责任。',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('12、如果波日特发现或收到他人举报您有违反本协议约定的，波日特有权不经通知随时对相关内容进行删除、屏蔽，并采取包括但不限于收回账号，限制、暂停、终止您使用部分或全部本服务，追究法律责任等措施。',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('六、服务费用',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('1、本服务的任何免费试用或免费功能和服务不应视为波日特放弃后续收费的权利。波日特有权提前7天以公告形式通知您收费标准，若您继续使用则需按公布的收费标准支付费用。',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('2、所有费用需通过波日特接受的支付方式事先支付。前述使用费不包含其它任何税款、费用或相关汇款等支出，否则您应补足付款或自行支付该费用。',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('3、波日特有权根据实际情况提前7天单方调整费用标准及收费方式，并以公告形式通知您，而无需获得您的事先同意，如您不同意收费应当立即停止服务的使用，否则使用则视为您已同意并应当缴纳费用。',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('4、您应当自行支付使用本服务可能产生的上网费以及其他第三方收取的通讯费、信息费等。',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('七、服务中止或终止',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('1、您同意，鉴于互联网服务的特殊性，波日特有权随时中止、终止或致使中止终止服务或其任何部分；对于免费服务之中止或终止，波日特无需向您发出通知。',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('2、您了解并同意，波日特可能定期或不定期地对提供网络服务的平台设备、设施和软硬件进行维护或检修，如因此类情况而造成收费服务在合理时间内中止，波日特无需承担责任，但应尽可能事先进行通告。',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('3、如存在下列违约情形之一，波日特可立即对用户中止或终止服务，并要求用户赔偿损失：',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('3.1 用户违反第四条之注册义务；',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('3.2 用户使用收费网络服务时未按规定支付相应服务费；',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('3.3 用户违反第五条服务使用规范之规定。',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('八、隐私政策',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('1、您在拇指先生服务注册的账户具有密码保护功能，以确保您基本信息资料的安全，请您妥善保管账户及密码信息。',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('2、波日特努力采取各种合理的物理、电子和管理方面的安全措施来保护您的信息，使您存储在拇指先生的信息和通信内容不会被泄漏、毁损或者丢失，包括但不限于SSL、信息加密存储、数据中心的访问控制。我们对可能接触到信息的员工或外包人员也采取了严格管理，包括但不限于根据岗位的不同采取不同的权限控制，与他们签署保密协议，监控他们的操作情况等措施。波日特会按现有技术提供相应的安全措施来保护您的信息，提供合理的安全保障，波日特将在任何时候尽力做到使您的信息不被泄漏、毁损或丢失， 但同时也请您注意在信息网络上不存在绝对完善的安全措施，请妥善保管好相关信息。',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('3、波日特有权根据实际情况自行决定您在本软件及服务中数据的最长储存期限、服务器中数据的最大存储空间等，您应当保管好终端、账号及密码，并妥善保管相关信息和内容，波日特对您自身原因导致的数据丢失或被盗以及在本软件及服务中相关数据的删除或储存失败不承担责任。',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('九、知识产权',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('1、您了解及同意，除非波日特另行声明，本协议项下服务包含的所有产品、技术、软件、程序、数据及其他信息（包括但不限于文字、图像、图片、照片、音频、视频、图表、色彩、版面设计、电子文档）的所有知识产权（包括但不限于版权、商标权、专利权、商业秘密等）及相关权利均归波日特或其关联公司所有。',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('2、您应保证，除非取得波日特书面授权，对于上述权利您不得（并不得允许任何第三人）实施包括但不限于出租、出借、出售、散布、复制、修改、转载、汇编、发表、出版、还原工程、反向汇编、反向编译，或以其它方式发现原始码等的行为。',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('3、拇指先生服务涉及的Logo、“拇指先生”、等文字、图形及其组成，用户未经波日特书面授权不得以任何方式展示、使用或作其他处理，也不得向他人表明您有权展示、使用、或作其他处理。',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('4、您理解并同意授权波日特在宣传和推广中使用您的名称、商标、标识，但仅限于表明您属于我们的客户或合作伙伴。',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('十、有限责任',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('1、服务将按"现状"和按"可得到"的状态提供。波日特在此明确声明对服务不作任何明示或暗示的保证，包括但不限于对服务的可适用性，没有错误或疏漏，持续性，准确性，可靠性，适用于某一特定用途之类的保证，声明或承诺。',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('2、波日特对服务所涉的技术和信息的有效性，准确性，正确性，可靠性，质量，稳定，完整和及时性均不作承诺和保证。',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('3、不论在何种情况下，波日特均不对由于Internet连接故障，电脑，通讯或其他系统的故障，电力故障，罢工，劳动争议，暴乱，起义，骚乱，生产力或生产资料不足，火灾，洪水，风暴，爆炸，不可抗力，战争，政府行为，国际、国内法院的命令或第三方的不作为而造成的不能服务或延迟服务承担责任。',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('4、不论是否可以预见，不论是源于何种形式的行为，波日特不对由以下原因造成的任何特别的，直接的，间接的，惩罚性的，突发性的或有因果关系的损害或其他任何损害（包括但不限于利润或利息的损失，营业中止，资料灭失）承担责任。',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('4.1 使用或不能使用服务；',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('4.2 通过服务购买或获取任何产品，样品，数据，信息或进行交易等，或其他可替代上述行为的行为而产生的费用；',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('4.3 未经授权的存取或修改数据或数据的传输；',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('4.4 第三方通过服务所作的陈述或行为；',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('4.5 其它与服务相关事件，包括疏忽等，所造成的损害。',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('5、您充分了解并同意，鉴于互联网体制及环境的特殊性，您在服务中分享的信息及个人资料有可能会被他人复制、转载、擅改或做其它非法用途；您在此已充分意识此类风险的存在，并确认此等风险应完全由您自行承担，波日特对此不承担任何责任。',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('6、您了解并同意，在使用服务过程中可能存在来自任何他人的包括威胁性的、诽谤性的、令人反感的或非法的内容或行为或对他人权利的侵犯（包括知识产权）及匿名或冒名的信息的风险，基于服务使用规范所述，该等风险应由您自行承担，波日特对此不承担任何责任。',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('十一、违约责任及赔偿',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('1、如果发现或收到他人举报您有违反本协议约定的，波日特有权不经通知随时对相关内容进行删除、屏蔽，并采取包括但不限于限制、暂停、终止您使用拇指先生账号及服务，限制、暂停、终止您使用部分或全部本服务（包括但不限于解除与团体或成员的所属关系，删除通信录、限制增加成员、限制添加客户/业主等），追究法律责任等措施。',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('2、您同意，由于您通过服务上载、传送或分享之信息、使用本服务其他功能、违反本协议、或您侵害他人任何权利因而衍生或导致任何第三人向波日特及其关联公司提出任何索赔或请求，或波日特及其关联公司因此而发生任何损失，您同意将足额进行赔偿（包括但不限于合理律师费）。',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('十二、有效通知',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('1、波日特向您发出的任何通知，可采用电子邮件、页面公开区域公告、个人网络区域提示、手机短信或常规信件等方式，且该等通知应自发送之日视为已向用户送达或生效。',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('十三、争议解决及其他',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('1、本协议之解释与适用，以及与本协议有关的争议，均应依照中华人民共和国法律予以处理。',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('2、如本协议的任何条款被视作无效或无法执行，则上述条款可被分离，其余部份则仍具有法律效力。',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('3、拇指先生于用户过失或违约时放弃本协议规定的权利的，不得视为其对用户的其他或以后同类之过失或违约行为弃权。',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10),
                    child: Text('4、本协议应取代双方此前就本协议任何事项达成的全部口头和书面协议、安排、谅解和通信。',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: 335,
                    padding: EdgeInsets.only(top: 10,bottom: 50),
                    child: Text('5、波日特有权根据业务调整情况将本协议项下的全部权利义务一并转移给其关联公司，转让将以本协议规定的方式通知，用户承诺对此不持有异议。',style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),textAlign: TextAlign.left,),
                  ),
                ]
            )
          ],
        )
    );
  }
}
