import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pend_tech/Controller/WalletController.dart';

import 'package:pend_tech/screen/intro/forget_password.dart';
import 'package:pend_tech/screen/intro/signup.dart';
import 'package:pend_tech/screen/osama/T3_Dashboard.dart';
import 'package:pend_tech/screen/osama/home.dart';
import 'package:pend_tech/screen/setting/themes.dart';
import 'package:pend_tech/component/style.dart';

class login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  WalletController controller = Get.put((WalletController()));
  String? _email, _pass;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Form(
      key: _formKey,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 200.0 + MediaQuery.of(context).padding.top,
                width: MediaQuery.of(context).size.width * 0.5,
                decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/image/logo.png"), fit: BoxFit.scaleDown)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 0.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 53.5,
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        border: Border.all(
                          color: colorStyle.primaryColor,
                          width: 0.15,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 10.0),
                        child: Theme(
                          data: ThemeData(hintColor: Colors.transparent),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: TextFormField(
                              validator: (input) {
                                if (input!.isEmpty) {
                                  return 'Please typle an email';
                                }
                              },
                              onSaved: (input) => _email = input!,
                              style: new TextStyle(color: Colors.white),
                              textAlign: TextAlign.start,
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              autocorrect: false,
                              autofocus: false,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  icon: Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: Icon(Icons.email, color: colorStyle.whiteColor, size: 20),
                                  ),
                                  contentPadding: EdgeInsets.all(0.0),
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  labelText: 'Email',
                                  hintStyle: TextStyle(color: Colors.white),
                                  labelStyle: TextStyle(
                                    color: Colors.white70,
                                  )),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 53.5,
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        //              color: Color(0xFF282E41),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        border: Border.all(
                          color: colorStyle.primaryColor,
                          width: 0.15,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 10.0),
                        child: Theme(
                          data: ThemeData(hintColor: Colors.transparent),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: TextFormField(
                              validator: (input) {
                                if (input!.isEmpty) {
                                  return 'Please typle an password';
                                }
                              },
                              onSaved: (input) => _pass = input!,
                              style: new TextStyle(color: Colors.white),
                              textAlign: TextAlign.start,
                              controller: _passwordController,
                              keyboardType: TextInputType.emailAddress,
                              autocorrect: false,
                              obscureText: true,
                              autofocus: false,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  icon: Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: Icon(Icons.vpn_key, size: 20, color: colorStyle.whiteColor),
                                  ),
                                  contentPadding: EdgeInsets.all(0.0),
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  labelText: 'Password',
                                  hintStyle: TextStyle(color: Colors.white),
                                  labelStyle: TextStyle(
                                    color: Colors.white70,
                                  )),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              ///
              /// forgot password
              ///
              Padding(
                padding: const EdgeInsets.only(right: 23.0, top: 9.0),
                child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacement(PageRouteBuilder(pageBuilder: (_, __, ___) => forgetPassword()));
                    },
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Forget Password ?",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12.0,
                          ),
                        ))),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0),
                child: GestureDetector(
                  onTap: () {
                    controller.ReadWallet(_emailController.text+_passwordController.text,context);

                    //Todo:
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => T3_Dashboard(
                              key: UniqueKey(),
                            )));
                  },
                  child: Container(
                    height: 50.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: colorStyle.blueColor,
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    child: Center(
                      child: Text(
                        "Sign In",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 20.0, letterSpacing: 1.0),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(pageBuilder: (_, __, ___) => new signUp()));
                  },
                  child: Container(
                    height: 50.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      color: colorStyle.blueColor,
                      border: Border.all(
                        width: 0.35,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Create Account",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16.5, letterSpacing: 1.2),
                      ),
                    ),
                  ),
                ),
              ),
//                  Padding(
//                    padding: const EdgeInsets.only(left:20.0,right: 20.0,bottom: 15.0),
//                    child: Container(width: double.infinity,height: 0.15,color: colorStyle.primaryColor,),
//                  ),
//                  Text("Register",style: TextStyle(color: colorStyle.primaryColor,fontSize: 17.0,fontWeight: FontWeight.w800),),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFeild({
    String? hint,
    TextEditingController? controller,
    TextInputType? keyboardType,
    bool? obscure,
    TextAlign? textAlign,
    Widget? widgetIcon,
  }) {
    return Column(
      children: <Widget>[
        Container(
          height: 53.5,
          decoration: BoxDecoration(
            color: Colors.black26,
//              color: Color(0xFF282E41),
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            border: Border.all(
              color: colorStyle.primaryColor,
              width: 0.15,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 10.0),
            child: Theme(
              data: ThemeData(hintColor: Colors.transparent),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: TextFormField(
                  style: new TextStyle(color: Colors.white),
                  textAlign: textAlign!,
                  obscureText: obscure!,
                  controller: controller,
                  keyboardType: keyboardType,
                  autocorrect: false,
                  autofocus: false,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: widgetIcon,
                      ),
                      contentPadding: EdgeInsets.all(0.0),
                      filled: true,
                      fillColor: Colors.transparent,
                      labelText: hint,
                      hintStyle: TextStyle(color: Colors.white),
                      labelStyle: TextStyle(
                        color: Colors.white70,
                      )),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
