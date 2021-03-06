import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pend_tech/Controller/WalletController.dart';
import 'package:pend_tech/component/style.dart';
import 'package:pend_tech/screen/MainButtons/SmartWalletTWithdraw.dart';
import 'package:pend_tech/screen/MainButtons/WithDraw.dart';
import 'package:pend_tech/screen/osama/wallets_screen.dart';
import 'create_wallet.dart';
import 'create_wallet2.dart';
import 'shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({required Key key}) : super(key: key);

  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WalletController controller = Get.put((WalletController()));
  bool _isLoading = false;

  getBalance() async {
    setState(() => _isLoading = true);
    await controller.getBalance();
    controller.update();
    setState(() => _isLoading = false);
  }

  @override
  void initState() {
    getBalance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            header(),
            SizedBox(
              height: 20.0,
            )
          ],
        ),
      ),
    );
  }

  Widget header() {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[

        Container(
          color: colorStyle.primaryColor,
          padding: EdgeInsets.only(left: 20.0, bottom: 70.0, right: 20.0),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("WALLET CASH",
                            style: TextStyle(
                              color: Colors.grey[200],
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                            )),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Stack(
                            children: <Widget>[
                              Container(
                                child: Text(
                                  "LE",
                                  style: TextStyle(
                                    color: Color(0xffd0993c),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Text(
                                  "0",
                                  style: TextStyle(
                                    color: Color(0xffd0993c),
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Row(
                            children: <Widget>[
                              Text("POINTS",
                                  style: TextStyle(
                                    color: Colors.grey[200],
                                    fontSize: 14.0,
                                    fontFamily: "Sans",
                                    fontWeight: FontWeight.w400,
                                  )),
                              Text(
                                " 0",
                                style: TextStyle(
                                  color: Color(0xffd0993c),
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.refresh,
                            color: Colors.white,
                            size: 28.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Container(
                            height: 45.0,
                            width: 100.0,
                            child: RaisedButton(
                              child: Text(
                                "TOP UP",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              color: Color(0xFF21bfb3),
                              onPressed: () {
                                 controller.getHash();
                                 controller.update();

                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 130.0, left: 20.0, right: 20.0),
          child: Container(
            height: 80.0,
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.black12.withOpacity(0.1),
                blurRadius: 2.0,
                spreadRadius: 2.0,
              ),
            ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(PageRouteBuilder(pageBuilder: (_, __, ___) => CreateWallet()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          "assets/image/Template_3/transfer.png",
                          height: 30.0,
                        ),
                        SizedBox(
                          height: 7.0,
                        ),
                        Text("Withdraw", style: TextStyle(color: colorStyle.primaryColor.withOpacity(0.8), fontFamily: "Popins", fontSize: 13.0)),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Container(
                    height: 80.0,
                    width: 2.0,
                    color: Colors.black12,
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(PageRouteBuilder(pageBuilder: (_, __, ___) => CreateWalletTwo()));
                  },
                  child: Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        "assets/image/Template_3/scan.png",
                        height: 30.0,
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      Text("Upload", style: TextStyle(color: colorStyle.primaryColor.withOpacity(0.8), fontFamily: "Popins")),
                    ],
                  ),
                ),),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Container(
                    height: 80.0,
                    width: 2.0,
                    color: Colors.black12,
                  ),
                ),
               GestureDetector(
                 onTap: (){
                   Navigator.of(context).push(PageRouteBuilder(pageBuilder: (_, __, ___) => WalletsScreen()));
                 },
                 child: Padding(
                   padding: const EdgeInsets.only(top: 9.0),
                   child: Column(
                     children: <Widget>[
                       Image.asset(
                         "assets/image/Template_3/people.png",
                         height: 30.0,
                       ),
                       SizedBox(
                         height: 8.0,
                       ),
                       Text("Cards", style: TextStyle(color: colorStyle.primaryColor.withOpacity(0.8), fontFamily: "Popins")),
                     ],
                   ),
                 ),
               ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget menuBottom() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            cardMenuBottom("assets/image/Template_3/menu_home.png", "Home"),
            cardMenuBottom("assets/image/Template_3/menu_bus.png", "Transport"),
            cardMenuBottom("assets/image/Template_3/menu_shopping.png", "Shopping"),
            cardMenuBottom("assets/image/Template_3/menu_tv.png", "Entertainment"),
            SizedBox(
              height: 20.0,
            )
          ],
        ),
      ),
    );
  }

  Widget cardMenuBottom(String img, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 19.0),
      child: Container(
        height: 90.0,
        width: double.infinity,
        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10.0)), color: Colors.white, boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            spreadRadius: 2.0,
          )
        ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 110.0,
              width: 4.5,
              decoration: BoxDecoration(
                  color: colorStyle.primaryColor.withOpacity(0.8),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), bottomLeft: Radius.circular(20.0))),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Image.asset(
                img,
                height: 20.0,
                color: colorStyle.primaryColor.withOpacity(0.8),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0.0),
              child: Container(
                width: 250.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    title,
                    style: TextStyle(fontFamily: "Sans", fontWeight: FontWeight.w400, fontSize: 16.5, color: Colors.black54),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
