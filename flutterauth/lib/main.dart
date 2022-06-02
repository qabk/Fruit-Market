import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterauth/viewmodels/change_tab_provider.dart';
import 'package:flutterauth/viewmodels/favorite_provider.dart';
import 'package:flutterauth/viewmodels/fruits_provider.dart';
import 'package:flutterauth/viewmodels/shopping_provider.dart';
import 'package:flutterauth/viewmodels/user_auth_vm.dart';
import 'package:flutterauth/views/favorite_view.dart';
import 'package:flutterauth/views/home_page_view.dart';
import 'package:flutterauth/views/loading.dart';
import 'package:flutterauth/views/login.dart';
import 'package:flutterauth/views/otp_view.dart';
import 'package:flutterauth/views/payment_view.dart';
import 'package:provider/provider.dart';

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => FavoriteProvider()),
          ChangeNotifierProvider(create: (ctx) => FruitProvider()),
          ChangeNotifierProvider(create: (ctx) => ChangeTabNotifier()),
          ChangeNotifierProvider(
            create: (ctx) => UserAuthProvider()..set(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => ShoppingProvider(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: "/",
          routes: {
            '/': (context) => LoginScreen(),
            '/otp_view': (context) => OtpScreen(),
            '/home_page_view': (context) => HomePageView(),
            '/favorite_view': (context) => FavoriteView(),
            '/payment_view': (context) => PaymentView(),
            'loading': (context) => LoadingScreen(),
          },
        ));
  }
}
