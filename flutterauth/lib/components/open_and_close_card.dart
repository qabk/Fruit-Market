import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterauth/models/Order.dart';
import 'package:flutterauth/models/favorites.dart';
import 'package:flutterauth/viewmodels/favorite_provider.dart';
import 'package:flutterauth/viewmodels/shopping_provider.dart';
import 'package:flutterauth/viewmodels/user_auth_vm.dart';
import 'package:provider/provider.dart';

import '../models/fruit.dart';

class OpenCard extends StatelessWidget {
  Fruit data;
  OpenCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen[600],
        title: Text('DETAILS'),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Image.network(
                  data.img_link,
                  width: size.width * 0.92,
                  height: size.height * 0.3,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              data.name,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(
                data.description,
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Nutrition",
              style: TextStyle(fontSize: 16),
            ),
            Container(
              // height: size.height * 0.1,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (int i = 0; i < data.nutritions.length; i++)
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          size: 8,
                          color: Colors.grey[600],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              data.nutritions[i],
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey[600]),
                            ))
                      ],
                    ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(children: [
              Icon(
                Icons.point_of_sale_outlined,
              ),
              Text(
                data.price.toString(),
                style: TextStyle(fontSize: 18),
              ),
            ]),
            SizedBox(
              width: size.width * 0.3,
              height: size.height * 1 / 20,
              child: Consumer<ShoppingProvider>(
                
                builder: (context, value, child) => StreamBuilder(
                  stream: value.getByUser(Provider.of<UserAuthProvider>(context).myUser.userId),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (!snapshot.hasData || snapshot.hasError) {
                      return Text("Snapshots have some problems");
                    } else {
                      var items = snapshot.data!.docs
                          .map((doc) => doc.data())
                          .toList()[0];
                      Order order = Order.fromMap(items);
                      return  SizedBox(
              width: size.width * 0.3,
              height: size.height * 1 / 20,
              child: RaisedButton(
                color: Colors.lightGreen[600],
                onPressed: () {
                  print(data.uid);
                  print(order.shoppingList.keys);
                  if(order.shoppingList.keys.contains(data.uid))
                  {
                    order.shoppingList[data.uid] +=1;
                    value.write(order);
                  }
                  else
                  {
                    order.shoppingList[data.uid] = 1;
                    value.write(order);
                  }
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                child: Text(
                  "Buy Now",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ClosedCard extends StatelessWidget {
  Fruit data;
  ClosedCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        height: size.height * 0.2,
        width: size.width * 0.3,
        child: Stack(
          children: <Widget>[
            Image.network(data.img_link,
                height: size.height * 0.2,
                width: size.width * 0.3,
                fit: BoxFit.cover),
            Align(
              alignment: Alignment.topRight,
              child: CircleAvatar(
                radius: 14,
                backgroundColor: Colors.white,
                child: Consumer<FavoriteProvider>(
                    builder: ((context, value, child) => StreamBuilder(
                        stream: value.get(Provider.of<UserAuthProvider>(
                          context,
                        ).myUser.userId),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError || !snapshot.hasData) {
                            return InkWell(
                              onTap: () {},
                              child: Icon(
                                Icons.favorite_outline,
                                color: Colors.red,
                              ),
                            );
                          } else {
                            var items = snapshot.data!.docs
                                .map((doc) => doc.data())
                                .toList()[0];
                            Favorites userFavorites = Favorites.fromMap(items);
                            return InkWell(
                              onTap: () {
                                userFavorites.addOrRemove(data.uid);
                                value.write(userFavorites);
                              },
                              child: Icon(
                                !userFavorites.docFruitIds.contains(data.uid)
                                    ? Icons.favorite_outline
                                    : Icons.favorite,
                                color: Colors.red,
                              ),
                            );
                          }
                        }))),
              ),
            ),
          ],
        ));
  }
}
