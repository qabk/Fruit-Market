import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutterauth/viewmodels/shopping_provider.dart';

import '../models/Order.dart';
import '../viewmodels/user_auth_vm.dart';

class ButtonBars extends StatefulWidget {
  String data;
  int counter;
   ButtonBars({
    Key? key,
    required this.data,
    required this.counter,
  }) : super(key: key);

  @override
  State<ButtonBars> createState() => _ButtonBarsState();
}

class _ButtonBarsState extends State<ButtonBars> {
  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                     widget.counter++;
                    });
                  },
                  child: Icon(Icons.add, color: Colors.black),
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(5),
                    primary: Colors.white, // <-- Button color
                    onPrimary: Colors.red, // <-- Splash color
                  ),
                ),
                Text(widget.counter.toString()),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (widget.counter > 0) {
                        widget.counter--;
                      }
                    });
                  },
                  child: Icon(Icons.remove, color: Colors.black),
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(5),
                    primary: Colors.white, // <-- Button color
                    onPrimary: Colors.red, // <-- Splash color
                  ),
                ),
              ],
            ),
            Consumer<ShoppingProvider>(builder: (context, value, child) {
              return StreamBuilder(
                stream: value.getByUser(Provider.of<UserAuthProvider>(context).myUser.userId),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                 if(snapshot.hasError || !snapshot.hasData)
                 {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.orange,
                      ),
                      onPressed: () {},
                      child: Text("Add"));
                 }
                 else
                 {
                    var items = snapshot.data!.docs
                          .map((doc) => doc.data())
                          .toList()[0];
                      Order order = Order.fromMap(items);
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.orange,
                      ),
                      onPressed: () {
                         if(order.shoppingList.keys.contains(widget.data))
                  {
                    order.shoppingList[widget.data] +=widget.counter;
                    value.write(order);
                  }
                  else
                  {
                    order.shoppingList[widget.data] = widget.counter;
                    value.write(order);
                  }
                      },
                      child: Text("Add"));
                 }
                }
              );
            }),
          ],
        ),
      ),
    );
  }
}
