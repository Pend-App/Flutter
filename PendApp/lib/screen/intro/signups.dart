import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'dart:math';
import 'package:web3dart/web3dart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pend_tech/component/style.dart';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';


class signUp extends StatefulWidget {
  signUp();
  @override
  _signUpState createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  _signUpState();
  @override
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _otp = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController = TextEditingController();
  bool state = false;
  bool verify = false;
  Dio dio = new Dio();

  Future<void> verifyPhone() async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+201282160015',
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {},
        codeSent: (String verificationId, int? resendToken) {},
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
    }
  }

  Future<String> getFilePath() async {
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory(); // 1
    String appDocumentsPath = appDocumentsDirectory.path; // 2
    String filePath = '$appDocumentsPath/Wallet.json'; // 3

    return filePath;
  }

  void readFile() async {
    File file = File(await getFilePath()); // 1
    String fileContent = await file.readAsString(); // 2

    print('File Content: $fileContent');
  }

  Future<void> WalletCreation() async {
    var rng = new Random.secure();
    EthPrivateKey credentials = EthPrivateKey.createRandom(rng);
    var address = await credentials.extractAddress();
    print(address.hex);
    Wallet wallet = Wallet.createNew(credentials, "mostafa", rng);
    print(wallet.toJson());
    File file = File(await getFilePath()); // 1
    file.writeAsString(wallet.toJson()); // 2
  }

  FetchIPFS() async{
    String username = '1zPDRpuNnp13PuZF2rKPPT05i2M';
    String password = 'fadf76b64fcfbe02e43befe04a6e8aeb';
    var auth = 'Basic '+base64Encode(utf8.encode('$username:$password'));

    dio.post('https://ipfs.infura.io:5001/api/v0/cat?arg=QmVn1znsuJbDrMwDjcNcXx5ppDnb6tMtMNkGiUUDBnntfP',
        data: {'param': []},
        options: Options(headers: <String, String>{'authorization': auth})).then((value) =>
    {
      print(value)
    });

  }

  PostIPFS(String name,String phone,String pass) async{
    var a = {
      "username": name,
      "phone": phone,
      "password": pass
    };

    String username = '1zPDRpuNnp13PuZF2rKPPT05i2M';
    String password = 'fadf76b64fcfbe02e43befe04a6e8aeb';
    var auth = 'Basic '+base64Encode(utf8.encode('$username:$password'));

    dio.post('https://ipfs.infura.io:5001/api/v0/add',
        data: FormData.fromMap(a),
        options: Options(headers: <String, String>{'authorization': auth})).then((value) =>
    {
      setState(() {
        print(value.data["Hash"]);
        final _firestore = FirebaseFirestore.instance;
        DocumentReference documentReference = _firestore
            .collection("Request")
            .doc(value.data["Hash"]);
        documentReference.set({
          "hash": value.data["Hash"],
          "size": value.data["Size"],
        });
      })
    });

  }

  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);

    return  FirebasePhoneAuthProvider(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,

          /// Set Background image in splash screen layout (Click to open code)
          decoration: BoxDecoration(color: colorStyle.primaryColor),
          child: Stack(
            children: <Widget>[
              ///
              /// Set image in top
              ///
              Container(
                height: 129.0,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/image/signupHeader.png"),
                        fit: BoxFit.cover)),
              ),
              Container(
                height: double.infinity,
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      /// Animation text marketplace to choose Login with Hero Animation (Click to open code)
                      Padding(
                        padding:
                        EdgeInsets.only(top: mediaQuery.padding.top + 130.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset("assets/image/logo.png", height: 35.0),
                          ],
                        ),
                      ),
                      state==false
                          ?Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 20.0, top: 40.0),
                            child: _buildTextFeild(
                                widgetIcon: Icon(
                                  Icons.people,
                                  color: colorStyle.primaryColor,
                                  size: 20,
                                ),
                                controller: _phone,
                                hint: 'phone number',
                                obscure: false,
                                keyboardType: TextInputType.emailAddress,
                                textAlign: TextAlign.start),
                          ),

                          verify==false
                              ?Padding(
                            padding: const EdgeInsets.only(top:20,left: 20.0, right: 20.0),
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
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(0.0)),
                                  border: Border.all(
                                    color: colorStyle.primaryColor,
                                    width: 0.35,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "SEND OTP",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 17.5,
                                        letterSpacing: 1.9),
                                  ),
                                ),
                              ),
                            ),
                          )
                              : FirebasePhoneAuthHandler(
                            phoneNumber: "+2"+_phone.text,
                            timeOutDuration: const Duration(seconds: 60),
                            onLoginSuccess: (userCredential, autoVerified) async {
                              print(autoVerified
                                  ? "OTP was fetched automatically"
                                  : "OTP was verified manually");

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

                              return  Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0, right: 20.0, top: 40.0),
                                    child: _buildTextFeild(
                                        widgetIcon: Icon(
                                          Icons.security,
                                          color: colorStyle.primaryColor,
                                          size: 20,
                                        ),
                                        controller: _otp,
                                        hint: 'OTP',
                                        obscure: false,
                                        keyboardType: TextInputType.emailAddress,
                                        textAlign: TextAlign.start),
                                  ),
                                  SizedBox(height: 20,),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                                    child: GestureDetector(
                                      onTap: () async {
                                        if (_otp.text.length != 6) {
                                          print("Please enter a valid 6 digit OTP");
                                        } else {
                                          final res =
                                          await controller.verifyOTP(otp: _otp.text);
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
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(0.0)),
                                          border: Border.all(
                                            color: colorStyle.primaryColor,
                                            width: 0.35,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Verify",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 17.5,
                                                letterSpacing: 1.9),
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
                          :Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 20.0, top: 40.0),
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
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 20.0, top: 20.0),
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
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 20.0, top: 20.0),
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
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 20.0, top: 40.0),
                            child: GestureDetector(
                              onTap: () async{

                                if(_passwordController.text == _confirmpasswordController.text)
                                  {
                                    PostIPFS(_emailController.text,_phone.text,_passwordController.text);



                                    setState(() {
                                      _emailController.clear();
                                      _passwordController.clear();
                                      _confirmpasswordController.clear();
                                      _otp.clear();
                                      _phone.clear();
                                      state = false;
                                      verify = false;
                                    });
                                  }
                                else
                                  {
                                    final snackBar = SnackBar(content: Text('Password is not matching'));
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                  }

                              },
                              child: Container(
                                height: 50.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(0.0)),
                                  color: colorStyle.primaryColor,
                                ),
                                child: Center(
                                  child: Text(
                                    "Register",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20.0,
                                        letterSpacing: 1.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                        ],
                      )
//                  Padding(
//                    padding: const EdgeInsets.only(left:20.0,right: 20.0,bottom: 15.0),
//                    child: Container(width: double.infinity,height: 0.15,color: colorStyle.primaryColor,),
//                  ),
//                  Text("Register",style: TextStyle(color: colorStyle.primaryColor,fontSize: 17.0,fontWeight: FontWeight.w800),),
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
    TextEditingController ? controller,
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
