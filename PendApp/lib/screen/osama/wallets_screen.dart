import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pend_tech/component/style.dart';
import 'package:pend_tech/screen/osama/widgets/wallet_card.dart';

class WalletsScreen extends StatelessWidget {
  static const route = 'walletsScreen';

  const WalletsScreen({Key? key}) : super(key: key);

  static const circleRadius = 250.0;

  @override
  Widget build(BuildContext context) {
    final gColor =  Color.fromRGBO(20, 232, 237, 1);
    final gColor2 =  Color.fromRGBO(3, 161, 234, 1);

    final topPadding = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment(-1, -1),
            child: Container(
              height: circleRadius,
              width: circleRadius,
              decoration: BoxDecoration(
                //shape: BoxShape.circle,
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(500)),
                gradient: LinearGradient(colors: [gColor, gColor2], stops: [0, 1],begin: Alignment.topLeft, end: Alignment.bottomRight),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: topPadding + 30 ,left: 32),
            child: Text('Card',style: TextStyle(fontSize: 25, fontFamily: 'Popins', fontWeight: FontWeight.bold),),
          ),
          Padding(
            padding: EdgeInsets.only(top: topPadding +100),
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              children: [
                WalletCard(),
                WalletCard(),
                WalletCard(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
