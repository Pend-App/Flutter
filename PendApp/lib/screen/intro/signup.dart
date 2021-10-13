import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' as GetX;
import 'package:pend_tech/Controller/WalletController.dart';
import 'package:pend_tech/screen/osama/encryption_model.dart';
import 'dart:math';
import 'package:web3dart/web3dart.dart';
import 'package:flutter/material.dart';
import 'package:pend_tech/component/style.dart';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as Firestore;

class signUp extends StatefulWidget {
  signUp();

  @override
  _signUpState createState() => _signUpState();
}

class _signUpState extends State<signUp> {

  final TextEditingController _phone = TextEditingController();
  final TextEditingController _otp = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController = TextEditingController();
  late Credentials unlocked;
  bool state = false;
  bool verify = false;
  Dio dio = new Dio();
  WalletController controller = GetX.Get.put((WalletController()));


  Future<void> WalletCreation() async {
    var rng = new Random.secure();
    EthPrivateKey credentials = EthPrivateKey.createRandom(rng);
    var address = await credentials.extractAddress();
    Wallet wallet = Wallet.createNew(credentials, _emailController.text+_passwordController.text, rng);
    File file = File(await controller.getFilePath()); // 1
    file.writeAsString(encrypt(wallet.toJson())); // 2

    PostIPFS(_emailController.text, _phone.text, _passwordController.text,wallet.toJson().toString());

    print("Hossary"+address.hex);
   print("Shebl"+encrypt(wallet.toJson()));
   print("Mostafa"+decrypt(encrypt(wallet.toJson())));
   print("Eslam"+await unlocked.toString());

  }
  PostIPFS(String name,String phone,String pass,String Json) async{
    var a = {
      "username": name+","+phone+","+pass+","+Json,
    };
    print(a);
    String username = '1zPDRpuNnp13PuZF2rKPPT05i2M';
    String password = 'fadf76b64fcfbe02e43befe04a6e8aeb';
    var auth = 'Basic '+base64Encode(utf8.encode('$username:$password'));

    dio.post('https://ipfs.infura.io:5001/api/v0/add',
        data: FormData.fromMap(a),
        options: Options(headers: <String, String>{'authorization': auth})).then((value) =>
    {
      print(value)
    });

  }


  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);

    return FirebasePhoneAuthProvider(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(color: colorStyle.primaryColor),
          child: Stack(
            children: <Widget>[
              Container(
                height: 129.0,
                width: double.infinity,
                decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/image/signupHeader.png"), fit: BoxFit.cover)),
              ),
              Container(
                height: double.infinity,
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: mediaQuery.padding.top + 130.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset("assets/image/logo.png", height: 35.0),
                          ],
                        ),
                      ),
                      state == false
                          ? Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0),
                                  child: _buildTextFeild(
                                      widgetIcon: Icon(
                                        Icons.phone_enabled,
                                        color: colorStyle.whiteColor,
                                        size: 20,
                                      ),
                                      controller: _phone,
                                      hint: 'phone number',
                                      obscure: false,
                                      keyboardType: TextInputType.phone,
                                      textAlign: TextAlign.start),
                                ),
                                verify == false
                                    ? Padding(
                                        padding: const EdgeInsets.only(top: 50, left: 20.0, right: 20.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              verify = true;
                                            });
                                          },
                                          child: Container(
                                            height: 50.0,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: colorStyle.blueColor,
                                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                              border: Border.all(
                                                color: colorStyle.blueColor,
                                                width: 0.35,
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Send code",
                                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 17.5, letterSpacing: 1.9),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : FirebasePhoneAuthHandler(
                                        phoneNumber: "+2" + _phone.text,
                                        timeOutDuration: const Duration(seconds: 60),
                                        onLoginSuccess: (userCredential, autoVerified) async {
                                          print(autoVerified ? "OTP was fetched automatically" : "OTP was verified manually");

                                          print("Login Success UID: ${userCredential.user?.uid}");
                                          setState(() {
                                            state = true;
                                          });
                                        },
                                        onLoginFailed: (authException) {
                                          print("An error occurred: ${authException.message}");

                                          // handle error further if needed
                                        },
                                        builder: (context, controller) {
                                          return Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0),
                                                child: _buildTextFeild(
                                                    widgetIcon: Icon(
                                                      Icons.security,
                                                      color: colorStyle.whiteColor,
                                                      size: 20,
                                                    ),
                                                    controller: _otp,
                                                    hint: 'Code',
                                                    obscure: false,
                                                    keyboardType: TextInputType.phone,
                                                    textAlign: TextAlign.start),
                                              ),
                                              SizedBox(height: 40),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                                                child: GestureDetector(
                                                  onTap: () async {
                                                    if (_otp.text.length != 6) {
                                                      print("Please enter a valid 6 digit OTP");
                                                    } else {

                                                      final res = await controller.verifyOTP(otp: _otp.text);
                                                      // Incorrect OTP
                                                      if (!res)
                                                        print(
                                                          "Please enter the correct OTP sent",
                                                        );
                                                    }
                                                  },
                                                  child: Container(
                                                    height: 50.0,
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                      color: colorStyle.blueColor,
                                                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                                      border: Border.all(color: colorStyle.blueColor, width: 0.35),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "Verify",
                                                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 17.5, letterSpacing: 1.9),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          );
                                        },
                                      )
                              ],
                            )
                          : Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0),
                                  child: _buildTextFeild(
                                      widgetIcon: Icon(
                                        Icons.people,
                                        color: colorStyle.primaryColor,
                                        size: 20,
                                      ),
                                      controller: _emailController,
                                      hint: 'User Name',
                                      obscure: false,
                                      keyboardType: TextInputType.emailAddress,
                                      textAlign: TextAlign.start),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                                  child: _buildTextFeild(
                                      widgetIcon: Icon(
                                        Icons.vpn_key,
                                        size: 20,
                                        color: colorStyle.primaryColor,
                                      ),
                                      controller: _passwordController,
                                      hint: 'Password',
                                      obscure: true,
                                      keyboardType: TextInputType.emailAddress,
                                      textAlign: TextAlign.start),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                                  child: _buildTextFeild(
                                      widgetIcon: Icon(
                                        Icons.vpn_key,
                                        size: 20,
                                        color: colorStyle.primaryColor,
                                      ),
                                      controller: _confirmpasswordController,
                                      hint: 'Confirm Password',
                                      obscure: true,
                                      keyboardType: TextInputType.emailAddress,
                                      textAlign: TextAlign.start),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      WalletCreation();
                                      setState(() {
                                        state = false;
                                        verify = false;
                                      });
                                    },
                                    child: Container(
                                      height: 50.0,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(0.0)),
                                        color: colorStyle.primaryColor,
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Register",
                                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 20.0, letterSpacing: 1.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                              ],
                            ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width*0.8,
                          child: Text("By creating an account you agree to our Terms of Service and Privacy Policy ©",style: TextStyle(color:  Colors.white),),
                        ),
                      )

                    ],
                  ),
                ),
              ),
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
                child: TextField(
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
