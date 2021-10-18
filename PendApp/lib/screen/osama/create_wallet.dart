import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:pend_tech/screen/MainButtons/SmartWalletTWithdraw.dart';

final Color background2 = Color(0xFF222945);
final Color background = Color.fromRGBO(20, 28, 53, 1);
final gColor = Color.fromRGBO(20, 232, 237, 1);
final gColor2 = Color.fromRGBO(3, 161, 234, 1);

class CreateWallet extends StatelessWidget {
  const CreateWallet({Key? key}) : super(key: key);

  static const route = 'createWallet';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100, bottom: 20),
              child: CircleAvatar(
                backgroundColor: background2,
                child: Image.asset(
                  'assets/image/create_wallet.png',
                  height: 70,
                ),
                radius: 80,
              ),
            ),
            Text(
              'Create new wallet',
              style: TextStyle(fontSize: 20, fontFamily: 'Popins'),
            ),
            SizedBox(height: 16),
            Text(
              'Select which wallet you want to add',
              style: TextStyle(fontSize: 18, fontFamily: 'Sans', color: Colors.blueGrey),
            ),
            Spacer(),
            button(text: 'Bank account',onTap: (){
              Navigator.of(context).push(PageRouteBuilder(pageBuilder: (_, __, ___) => SmartWalletWithDraw()));

            }),
            button(text: 'Smart wallet',onTap: (){
              Navigator.of(context).push(PageRouteBuilder(pageBuilder: (_, __, ___) => SmartWalletWithDraw()));

            }),
            button2(text: 'other', onTap: (){}),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

class button extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const button({Key? key, required this.text, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(25),
      onTap: onTap,
      child: Container(
        height: 50,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 40),
        width: double.infinity,
        decoration: BoxDecoration(
          color: background2,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [gColor, gColor2]),
              ),
            ),
            SizedBox(width: 16),
            Text(text, style: TextStyle(fontSize: 16, fontFamily: 'Sans'),)
          ],
        ),
      ),
    );
  }
}

class button2 extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const button2({Key? key, required this.text, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 40),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(25),
        child: DottedBorder(
          color: background2,
          strokeWidth: 2.5,
          dashPattern: [10, 5],
          borderType: BorderType.RRect,
          radius: Radius.circular(25),
          child: Ink(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(colors: [gColor.withOpacity(0.9), gColor2.withOpacity(0.9)]),
                  ),
                ),
                SizedBox(width: 16),
                Text(
                  text,
                  style: TextStyle(fontSize: 16, fontFamily: 'Sans'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
