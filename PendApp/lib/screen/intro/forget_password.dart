import 'package:pend_tech/screen/intro/login.dart';
import 'package:pend_tech/screen/intro/signup.dart';
import 'package:pend_tech/screen/setting/themes.dart';
import 'package:flutter/material.dart';
import 'package:pend_tech/component/style.dart';

class forgetPassword extends StatefulWidget {
  @override
  _forgetPasswordState createState() => _forgetPasswordState();
}

class _forgetPasswordState extends State<forgetPassword> {
  _forgetPasswordState();
  @override
  final TextEditingController _phone = TextEditingController();
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Scaffold(
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
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
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
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 20.0, right: 20.0),
              child: GestureDetector(
                onTap: () {
                  if( _phone.text.length!=11)
                  {
                    final snackBar = SnackBar(content: Text('Please check phone number'));

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  else
                  {
                    final snackBar = SnackBar(content: Text('Please wait and someone will call you'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    _phone.clear();
                  }

                },
                child: Container(
                  height: 50.0,
                  width: MediaQuery.of(context).size.width/2,
                  decoration: BoxDecoration(
                    color: colorStyle.blueColor,
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  child: Center(
                    child: Text(
                      "Restore",
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 17.5, letterSpacing: 1.9),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20.0, right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();

                },
                child: Container(
                  height: 50.0,
                  width: MediaQuery.of(context).size.width/3,
                  decoration: BoxDecoration(
                    color: colorStyle.blueColor,
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  child: Center(
                    child: Text(
                      "Back",
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 17.5, letterSpacing: 1.9),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ) ,
      ),
    );
  }

  Widget _buildTextFeild({
    String? hint,
    TextEditingController? controller,
    TextInputType? keyboardType,
    bool? obscure,
    String? icon,
    TextAlign? textAlign,
    Widget? widgetIcon,
  }) {
    return Column(
      children: <Widget>[
        Container(
          height: 55.5,
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
