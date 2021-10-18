import 'package:flutter/material.dart';
import 'package:pend_tech/component/style.dart';
import 'package:pend_tech/screen/MainButtons/ImageHashIPFS.dart';
import 'package:pend_tech/screen/MainButtons/SmartWalletTWithdraw.dart';

final Color background2 = Color(0xFF222945);
final Color background = Color.fromRGBO(20, 28, 53, 1);
final gColor = Color.fromRGBO(20, 232, 237, 1);
final gColor2 = Color.fromRGBO(3, 161, 234, 1);

class CreateWalletTwo extends StatelessWidget {
  const CreateWalletTwo({Key? key}) : super(key: key);

  static const route = 'createWallet';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorStyle.primaryColor,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20),
              Text(
                'Add Info',
                style: TextStyle(fontSize: 20, fontFamily: 'Popins'),
              ),
              SizedBox(height: 16),
              // Text(
              //   'Select which wallet you want to add',
              //   style: TextStyle(fontSize: 18, fontFamily: 'Sans', color: Colors.blueGrey),
              // ),
              Spacer(),
              button(
                  text: 'add text',
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(pageBuilder: (_, __, ___) => SmartWalletWithDraw()));
                  }),
              button(
                  text: 'add image',
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(pageBuilder: (_, __, ___) => ImageHash()));
                  }),
              Spacer(),
            ],
          ),
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 40),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(25),
        child: Ink(
          height: 50,
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
              Text(
                text,
                style: TextStyle(fontSize: 16, fontFamily: 'Sans'),
              )
            ],
          ),
        ),
      ),
    );
  }
}