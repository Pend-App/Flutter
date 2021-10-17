import 'package:pend_tech/component/style.dart';

import 'T3_deals.dart';
import 'T3_finance.dart';
import 'T3_history.dart';
import 'home.dart';
import 'T3_wallet.dart';
import 'package:flutter/material.dart';

class T3_Dashboard extends StatefulWidget {
  static const route  = 'dashboard';
  T3_Dashboard({required Key key}) : super(key: key);

  _T3_DashboardState createState() => _T3_DashboardState();
}

class _T3_DashboardState extends State<T3_Dashboard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  ///
  /// Initstate for tab bar
  ///
  @override
  void initState() {
    _tabController = new TabController(length: 5, vsync: this, initialIndex: 4);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      ///
      /// Appbar
      ///
      appBar: AppBar(
        brightness: Brightness.dark,
        elevation: 0.0,
        backgroundColor: colorStyle.primaryColor,
        centerTitle: false,
        title: Text(
          "Wallet",
          style: TextStyle(color: Colors.white, fontFamily: "Gotik"),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Image.asset(
              "assets/image/messageAppbar.png",
              color: Colors.white,
              height: 20.0,
              width: 20.0,
            ),
          )
        ],
      ),

      body: Container(
        color: colorStyle.primaryColor,
        height: 800.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ///
            /// Custom tab bar
            ///
            Expanded(
              child: DefaultTabController(
                length: 5,
                child: new Scaffold(
                  backgroundColor: colorStyle.primaryColor,
                  appBar: PreferredSize(
                    preferredSize:
                        Size.fromHeight(70.0), // here the desired height
                    child: new AppBar(
                      backgroundColor: colorStyle.primaryColor,
                      elevation: 0.0,
                      centerTitle: true,
                      flexibleSpace: SafeArea(
                        child: Stack(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 68.0),
                              child: Container(
                                width: double.infinity,
                                height: 4.1,
                                color: Colors.white12.withOpacity(0.1),
                              ),
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 0.0, left: 0.0),
                                child: new TabBar(
                                  indicatorColor: Colors.white,
                                  labelColor: Colors.white,
                                  unselectedLabelColor: Colors.white24,
                                  indicatorSize: TabBarIndicatorSize.label,
                                  tabs: [
                                    new Tab(
                                      icon: Icon(
                                        Icons.home_filled,
                                        size: 19.0,
                                      ),
                                      text: "MyPend",
                                    ),
                                    new Tab(
                                      icon: Icon(
                                        Icons.work,
                                        size: 19.0,
                                      ),
                                      text: "Dpend",
                                    ),
                                    new Tab(
                                      icon: Icon(
                                        Icons.account_balance,
                                        size: 19.0,
                                      ),
                                      text: "Spend",
                                    ),
                                    new Tab(
                                      icon: Icon(
                                        Icons.monetization_on,
                                        size: 19.0,
                                      ),
                                      text: "Apend",
                                    ),
                                    new Tab(
                                      icon: Icon(
                                        Icons.signal_cellular_4_bar,
                                        size: 19.0,
                                      ),
                                      text: "History",
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      automaticallyImplyLeading: false,
                    ),
                  ),

                  ///
                  /// Body for tab bar
                  ///
                  body: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: new TabBarView(
                      children: [
                        HomeScreen(key: UniqueKey()),
                        T3_deals(key: UniqueKey()),
                        T3_wallet(key: UniqueKey()),
                        T3_finance(key: UniqueKey()),
                        T3_history(key: UniqueKey()),
                      ],
                    ),
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
