import 'dart:async';
import 'package:pend_tech/Services/authservices.dart';
import 'package:pend_tech/screen/intro/login.dart';
import 'package:pend_tech/screen/intro/on_Boarding.dart';
import 'package:pend_tech/screen/osama/T3_Dashboard.dart';
import 'package:pend_tech/screen/osama/create_wallet.dart';
import 'package:pend_tech/screen/osama/wallets_screen.dart';
import 'package:pend_tech/screen/setting/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pend_tech/screen/setting/setting.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Run first apps open
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  runApp(myApp());
}

class myApp extends StatefulWidget {
  _myAppState createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  /// Create _themeBloc for double theme (Dark and White theme)
  late ThemeBloc _themeBloc;

  @override
  void initState() {
    super.initState();
    _themeBloc = ThemeBloc();
  }

  @override
  Widget build(BuildContext context) {
    /// To set orientation always portrait
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    /// StreamBuilder for themeBloc
    return StreamBuilder<ThemeData>(
      initialData: _themeBloc.initialTheme().data,
      stream: _themeBloc.themeDataStream,
      builder: (BuildContext context, AsyncSnapshot<ThemeData> snapshot) {
        return MaterialApp(
          title: 'PEND',
          theme: snapshot.data,
          debugShowCheckedModeBanner: false,
          //home: SplashScreen(themeBloc: _themeBloc),
          home: T3_Dashboard(key: UniqueKey()),

          /// Move splash screen to onBoarding Layout
          /// Routes
          ///
          routes: <String, WidgetBuilder>{
            "login": (BuildContext context) => login(),
            OnBoardingScreen.route: (BuildContext context) => OnBoardingScreen(),
            T3_Dashboard.route: (BuildContext context) => T3_Dashboard(key: UniqueKey()),
            WalletsScreen.route: (BuildContext context) => WalletsScreen(),
            CreateWallet.route: (BuildContext context) => CreateWallet(),
          },
        );
      },
    );
  }
}

/// Component UI
class SplashScreen extends StatefulWidget {
  final ThemeBloc themeBloc;

  SplashScreen({required this.themeBloc});

  @override
  _SplashScreenState createState() => _SplashScreenState(themeBloc);
}

/// Component UI
class _SplashScreenState extends State<SplashScreen> {
  ThemeBloc themeBloc;

  @override
  _SplashScreenState(this.themeBloc);

  /// Setting duration in splash screen
  startTime() {
    return Future.delayed(Duration(milliseconds: 4000)).then((value) => NavigatorPage());
  }

  /// To navigate layout change
  void NavigatorPage() {
    Navigator.of(context).pushReplacementNamed("login");
  }

  /// Declare startTime to InitState
  @override
  void initState() {
    super.initState();
    startTime();
  }

  /// Code Create UI Splash Screen
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Container();
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              /// Set Background image in splash screen layout (Click to open code)
              decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/image/splash_screen.png'), fit: BoxFit.cover)),
              child: Container(
                /// Set gradient black in image splash screen (Click to open code)
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Colors.white,
                  Colors.white,
                ], begin: FractionalOffset.topCenter, end: FractionalOffset.bottomCenter)),
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/image/logoSplash.jpg"),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 5), // changes position of shadow
                        ),
                      ],
                    ),
                    height: MediaQuery.of(context).size.width / 3,
                    width: MediaQuery.of(context).size.width / 3,
                  ),
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
