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

            button(text: 'Bank account',onTap: (){
              Navigator.of(context).push(PageRouteBuilder(pageBuilder: (_, __, ___) => SmartWalletWithDraw()));

            }),
            button(text: 'Smart wallet',onTap: (){
              Navigator.of(context).push(PageRouteBuilder(pageBuilder: (_, __, ___) => SmartWalletWithDraw()));

            }),
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
