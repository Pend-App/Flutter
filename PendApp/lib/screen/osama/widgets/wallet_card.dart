import 'package:flutter/material.dart';
import 'package:pend_tech/component/style.dart';

class WalletCard extends StatelessWidget {
  WalletCard({Key? key}) : super(key: key);
  final background = Color.fromRGBO(35, 45, 78, 1);
  final gColor = Color.fromRGBO(20, 232, 237, 1);
  final gColor2 = Color.fromRGBO(3, 161, 234, 1);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              child: Container(
                height: 150,
                decoration:
                    BoxDecoration(color: background, borderRadius: BorderRadius.circular(30), border: Border.all(color: Colors.grey.shade600, width: 1)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 14),
                      child: Text(
                        'Card',
                        style: TextStyle(fontSize: 16, fontFamily: 'Sans', color: Colors.white.withOpacity(0.9), fontWeight: FontWeight.w300),
                      ),
                    ),
                    Divider(color: Colors.grey, height: 1),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              margin: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: Colors.grey.shade600, width: 1),
                                  gradient: LinearGradient(colors: [gColor, gColor2], stops: [0, 1], begin: Alignment.topRight, end: Alignment.bottomLeft)),
                            ),
                            SizedBox(width: 12),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('ETHEREUM', style: const TextStyle(letterSpacing: 2, fontFamily: 'Popins', fontSize: 20)),
                                Text('654as3d6f4g325s4ad56g4dfs23', style: const TextStyle(fontFamily: 'Sans', fontSize: 16, color: Colors.blueGrey))
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: 150,
            height: 50,
            margin: const EdgeInsets.only(right: 35),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), gradient: LinearGradient(colors: [gColor, gColor2], stops: [0, 1])),
          )
        ],
      ),
    );
  }
}
