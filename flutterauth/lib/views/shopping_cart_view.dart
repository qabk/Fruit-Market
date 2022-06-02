import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterauth/components/add_remove_buttons.dart';
import 'package:flutterauth/models/Order.dart';
import 'package:flutterauth/models/fruit.dart';
import 'package:flutterauth/viewmodels/fruits_provider.dart';
import 'package:provider/provider.dart';
import '../viewmodels/shopping_provider.dart';
import '../viewmodels/user_auth_vm.dart';

class ShoppingCartView extends StatelessWidget {
  const ShoppingCartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          child: Container(
            height: size.height * 0.7,
            child: Consumer<ShoppingProvider>(
              builder: (context, shopping, child) => StreamBuilder(
                  stream: shopping.getByUser(
                      Provider.of<UserAuthProvider>(context).myUser.userId),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData || snapshot.hasError) {
                      return Text("Error in loading");
                    } else {
                      var items = snapshot.data!.docs
                          .map((doc) => doc.data())
                          .toList()[0];
                      Order order = Order.fromMap(items);
                      List<Detail> details = [];
                      order.shoppingList.forEach((key, value) =>
                          details.add(Detail(uid: key, counter: value)));
                      return SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            for (int i = 0; i < details.length; i++)
                              Container(
                                child: Column(
                                  children: [
                                    Consumer<FruitProvider>(
                                        builder: (context, value, child) =>
                                            StreamBuilder(
                                                stream: value.getDoc(details[i].uid),
                                                builder: (BuildContext context,
                                                    AsyncSnapshot<QuerySnapshot>
                                                        snapshotFruit) {
                                                  if (!snapshotFruit.hasData ||
                                                      snapshotFruit.hasError) {
                                                    return Text("Error in loading");
                                                  } else {
                                                    var data = snapshotFruit
                                                        .data!.docs
                                                        .map((doc) => doc.data())
                                                        .toList()[0];
                                                    Fruit fruit = Fruit.fromMap(data);
                                                    return Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: size.height * 0.01),
                                                      child: Container(
                                                          height: size.height * 0.2,
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  image:
                                                                      DecorationImage(
                                                                    image: NetworkImage(
                                                                        fruit
                                                                            .img_link),
                                                                    fit: BoxFit.cover,
                                                                  ),
                                                                  border: Border.all(
                                                                    color:
                                                                        Colors.white,
                                                                    width: 1,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12),
                                                                ),
                                                                height: 100,
                                                                width: 100,
                                                              ),
                                                              Container(
                                                                child: Column(
                                                                  children: [
                                                                    Text(
                                                                      fruit.name,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14),
                                                                    ),
                                                                    Text(
                                                                      fruit.price
                                                                          .toString(),
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              12),
                                                                    ),
                                                                    Container(
                                                                      child: Row(
                                                                        children: [
                                                                          ElevatedButton(
                                                                              style: ElevatedButton
                                                                                  .styleFrom(
                                                                                shape:
                                                                                    CircleBorder(),
                                                                                padding:
                                                                                    EdgeInsets.all(5),
                                                                                primary:
                                                                                    Colors.white, // <-- Button color
                                                                                onPrimary:
                                                                                    Colors.black, // <-- Splash color
                                                                              ),
                                                                              onPressed:
                                                                                  (() {
                                                                                order.shoppingList[fruit.uid] +=
                                                                                    1;
                                                                                shopping
                                                                                    .write(order);
                                                                              }),
                                                                              child: Icon(
                                                                                  Icons.add)),
                                                                          Text(details[
                                                                                  i]
                                                                              .counter
                                                                              .toString()),
                                                                          ElevatedButton(
                                                                              onPressed:
                                                                                  (() {
                                                                                if (order.shoppingList[fruit.uid] >
                                                                                    0) {
                                                                                  order.shoppingList[fruit.uid] -=
                                                                                      1;
                                                                                  shopping.write(order);
                                                                                }
                                                                              }),
                                                                              style: ElevatedButton
                                                                                  .styleFrom(
                                                                                shape:
                                                                                    CircleBorder(),
                                                                                padding:
                                                                                    EdgeInsets.all(5),
                                                                                primary:
                                                                                    Colors.white, // <-- Button color
                                                                                onPrimary:
                                                                                    Colors.black, // <-- Splash color
                                                                              ),
                                                                              child: Icon(
                                                                                  Icons.remove)),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Align(alignment: Alignment.topRight,child: IconButton(onPressed: (){
                                                                order.shoppingList.remove(fruit.uid);
                                                                print(order.shoppingList.length);
                                                                shopping.write(order);

                                                              },icon: Icon(Icons.delete),)),
                                                            ],
                                                          )),
                                                    );
                                                  }
                                                })),
                                     Divider(color: Colors.grey)],
                                ),
                              ),
                          ],
                        ),
                      );
                    }
                  }),
            ),
          ),
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.orange,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/payment_view');
            },
            child: Text("Buy")),
      ],
    );
  }
}
