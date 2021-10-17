import 'package:flutter/material.dart';


final Color background2 = Color(0xFF222945);
final Color background = Color.fromRGBO(20, 28, 53, 1);

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
                child: Image.asset('assets/image/create_wallet.png',height: 70,),
                radius: 80,
              ),
            ),
            Text(
              'Create new wallet',
              style: TextStyle(fontSize: 20, fontFamily: 'Popins'),
            ),


          ],
        ),
      ),
    );
  }
}

class button extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const button({Key? key,required this.text,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 40),
      width: double.infinity,
      decoration: BoxDecoration(
        color: background2,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
      //  gradient: LinearGradient(colors: [gColor, gColor2],
          ),
        )
      ],),
    );
  }
}
