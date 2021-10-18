import 'package:flutter/material.dart';
import 'package:pend_tech/component/style.dart';

class WithDraw extends StatefulWidget {
  _signUpState createState() => _signUpState();
}

class _signUpState extends State<WithDraw> {
  List<String> _actions = ["Smart Wallet","Bank Account"];
  ScrollController _scrollconto = ScrollController();

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
            Center(child:
            Text("My Cards",style: TextStyle(color: colorStyle.whiteColor,fontSize: 28,fontWeight: FontWeight.w500),),),
            SizedBox(height: 60,),

            Padding(padding: EdgeInsets.only(left: 30,right: 30),
            child: Container(
              height: MediaQuery.of(context).size.height-150,
              child: ListView.builder(
                itemBuilder: (_, index) {
                  return  _actions.length==0
                      ?Center(child: CircularProgressIndicator(),)
                      :Padding(
                    padding: EdgeInsets.only(top: 20,bottom: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: colorStyle.blueColor,
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ExpansionTile(
                            title: Center(child:Text(_actions[index],style: TextStyle(fontSize: 20,color: Colors.black,fontFamily: 'modak'),)),
                            children: <Widget>[
                              ListTile(
                                title: Text(_actions[index],style: TextStyle(color: Colors.black)),
                              ),
                              ElevatedButton(onPressed: (){

                              },
                                  child: Text("Open")),
                              SizedBox(height: MediaQuery.of(context).size.height/30,)
                            ],
                          ),

                        ],
                      ),),
                  );
                },
                itemCount: _actions.length,
                controller: _scrollconto,
              ),),)


          ],
        ),
      )),
    );
  }

}
