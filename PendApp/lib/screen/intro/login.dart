import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pend_tech/Controller/WalletController.dart';
import 'package:pend_tech/exception/auth_exception.dart';
import 'package:pend_tech/exception/wallet_exception.dart';

import 'package:pend_tech/screen/intro/forget_password.dart';
import 'package:pend_tech/screen/intro/signup.dart';
import 'package:pend_tech/screen/osama/T3_Dashboard.dart';
import 'package:pend_tech/screen/osama/alertSnakBar.dart';
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
  bool _isLoading = false;

  signInFirebase() async {
    ///TODO: remove temporary validation
    if (_emailController.value.text.isEmpty) throw authException('please enter the username');
    if (_passwordController.value.text.isEmpty) throw authException('please enter the password');

    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: '${_emailController.value.text}@pend.com', password: _passwordController.value.text)
        .timeout(Duration(seconds: 30));
  }

  Widget build(BuildContext context) {
    //TODO: validate username and password not empty
    signIn() async {
      try {
        await signInFirebase();
      } on authException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(alertSnackBar(context, e.message));
        return;
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(alertSnackBar(context, e.message ?? 'something went wrong\nplease try again later'));
        return;
      } catch (e) {
        print('other exception: $e');
        ScaffoldMessenger.of(context).showSnackBar(alertSnackBar(context, 'something went wrong. please try again later'));
        return;
      }

      //TODO: missing Exception handling for this method to complete
      //TODO: [WalletCreation] not working
      try{
      await controller.ReadWallet(_emailController.text + _passwordController.text, context);
      } on walletException catch (e){
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(alertSnackBar(context, 'something went wrong. please try again later'));
        return;
      } catch (e){
        print('other wallet exception: $e');
        return;
      }

      Navigator.of(context).pushReplacementNamed(T3_Dashboard.route);
    }

    return Form(
      key: _formKey,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 200.0 + MediaQuery
                    .of(context)
                    .padding
                    .top,
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.5,
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
                                  labelText: 'Pend ID',
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
                                  return 'Please enter the password';
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
                  onTap: _isLoading
                      ? null
                      : () async {
                    setState(() => _isLoading = true);
                    await signIn();
                    setState(() => _isLoading = false);
                  },
                  child: Container(
                    height: 50.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: colorStyle.accentColor,
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    child: Center(
                      child: _isLoading
                          ? CircularProgressIndicator(color: colorStyle.primaryColor)
                          : Text(
                        "Sign In",
                        style: TextStyle(color: colorStyle.primaryColor, fontWeight: FontWeight.w400, fontSize: 20.0, letterSpacing: 1.0),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: GestureDetector(
                  onTap: _isLoading
                      ? null
                      : () {
                    Navigator.of(context).push(PageRouteBuilder(pageBuilder: (_, __, ___) => signUp()));
                  },
                  child: Container(
                    height: 50.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      color: colorStyle.accentColor,
                      border: Border.all(
                        width: 0.35,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Create Account",
                        style: TextStyle(color: colorStyle.primaryColor, fontWeight: FontWeight.w400, fontSize: 16.5, letterSpacing: 1.2),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.8,
                  child: Text(
                    "By creating an account you agree to our Terms of Service and Privacy Policy ©",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}