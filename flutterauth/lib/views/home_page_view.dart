import 'package:flutter/material.dart';
import 'package:flutterauth/viewmodels/favorite_provider.dart';
import 'package:flutterauth/viewmodels/user_auth_vm.dart';
import 'package:flutterauth/views/account_view.dart';
import 'package:flutterauth/views/favorite_view.dart';
import 'package:flutterauth/views/fruit_choice_view.dart';
import 'package:flutterauth/views/shopping_cart_view.dart';
import 'package:provider/provider.dart';

List<Widget> _widgetOptions = <Widget>[
  FruitChoiceView(),
  ShoppingCartView(),
  FavoriteView(),
  AccountView(),
];
class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
 
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  int _selectedIndex = 0;

   void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: size.height*0.12,
        centerTitle: true,
        title: Text("Fruit Market"),
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(onPressed: (() {}), icon: Icon(Icons.notifications, )),
        ],
      ),
      body: Center(child: Container(
        height: size.height*0.8,
        width: size.width*0.95,
        child:_widgetOptions.elementAt(_selectedIndex),
      )),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex:_selectedIndex,
          onTap:(int index){
            setState(() {
              _selectedIndex = index;
            });
          },
          selectedItemColor: Colors.green,
          unselectedLabelStyle: TextStyle(color: Colors.black),
          items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined,color: Colors.green),
        label: 'Home',
        
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.shopping_cart_outlined,color: Colors.green),
        label: 'Shopping cart',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.favorite_outline,color: Colors.green),
        label: 'Favourite',
        
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person_outline,color: Colors.green),
        label: 'My Account',
      ),
    ],
        ),

    );
  }
}


