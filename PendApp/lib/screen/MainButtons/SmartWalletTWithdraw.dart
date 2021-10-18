import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pend_tech/component/style.dart';

class SmartWalletWithDraw extends StatefulWidget {
  _signUpState createState() => _signUpState();
}

class _signUpState extends State<SmartWalletWithDraw> {
  List<String> _actions = ["Smart Wallet","Bank Account"];
  ScrollController _scrollconto = ScrollController();
  final name = TextEditingController();

  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: colorStyle.primaryColor,
      body: SafeArea(child:
      SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 60,),


            Padding(padding: EdgeInsets.only(left: 30,right: 30),
              child: Container(
                decoration: BoxDecoration(
                  color: colorStyle.primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),

                child: Padding(
                  padding: EdgeInsets.only(left: 20,right: 20),
                  child:
                    Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          color: colorStyle.blueColor,
                        ),
                        SizedBox(width: 20,),
                        Column(
                          children: [
                            Text("VF cash",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 20),),
                            SizedBox(height: 10,),
                            Text("01000000000",style: TextStyle(fontWeight: FontWeight.w200,fontSize: 13)),
                          ],
                        ),
                        SizedBox(width: 80,),
                        Text("Amount : "+"0"),

                      ],
                    )
                  ,
                ),),),
            Padding(padding: EdgeInsets.all(20),
            child: Divider(thickness: 2,color: colorStyle.goldColors,),),
            Padding(padding: const EdgeInsets.only(top: 30,left: 30,right: 30),
              child: Container(
                color: colorStyle.primaryColor,
                height: 50,
                child: TextFormField(
                  controller: name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color:  Colors.white,
                  ),
                  cursorColor:Colors.white,
                  keyboardType: TextInputType.name,
                  decoration: new InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff0D2943), width: 5.0),
                    ),
                    labelText: "Address",
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    enabledBorder:  const OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xff0D2943)),
                    ),  //fillColor: Colors.green
                  ),
                ),),),
            SizedBox(height: 20,),
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
                    color: colorStyle.goldColors,
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  child: Center(
                    child: Text(
                      "Upload",
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 17.5, letterSpacing: 1.9),
                    ),
                  ),
                ),
              ),
            ),


          ],
        ),
      )),
    );
  }

}
