import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterauth/components/add_remove_buttons.dart';
import 'package:flutterauth/my_widgets/star_rating.dart';
import 'package:flutterauth/viewmodels/favorite_provider.dart';
import 'package:flutterauth/viewmodels/fruits_provider.dart';
import 'package:flutterauth/viewmodels/user_auth_vm.dart';
import 'package:provider/provider.dart';

import '../models/favorites.dart';
import '../models/fruit.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({Key? key}) : super(key: key);

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        child: Consumer<FavoriteProvider>(builder: (context, value, child) {
      return StreamBuilder(
          stream: value.get(Provider.of<UserAuthProvider>(
            context,
          ).myUser.userId),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Documents have error");
            }
            if (!snapshot.hasData) {
              return Text("Document not exist");
            } else {
              var items =
                  snapshot.data!.docs.map((doc) => doc.data()).toList()[0];
              Favorites userFavorites = Favorites.fromMap(items);
              return SingleChildScrollView(
                child: Column(
                  children: [
                    for (int i = 0; i < userFavorites.docFruitIds.length; i++)
                      StreamBuilder(
                          stream: Provider.of<FruitProvider>(context)
                              .getDoc(userFavorites.docFruitIds[i]),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return Text("no data");
                            }
                            if (snapshot.hasError) {
                              return Text("snapshot has error");
                            } else {
                              var items = snapshot.data!.docs
                                  .map((doc) => doc.data())
                                  .toList()[0];
                              Fruit favorite = Fruit.fromMap(items);
                           
                              return Column(
                                children: [
                                  Container(
                                    height: size.height * 0.2,
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  favorite.img_link),
                                              fit: BoxFit.cover,
                                            ),
                                            border: Border.all(
                                              color: Colors.white,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          height: 100,
                                          width: 100,
                                        ),
                                        SizedBox(width: size.width * 0.1),
                                        Container(
                                          child: Column(children: <Widget>[
                                            Text(
                                              favorite.name,
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w300,
                                                fontFamily: 'Poppins',
                                              ),
                                            ),
                                            Text(favorite.description,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'Poppins',
                                                )),
                                            StarRating(star: favorite.star),
                                            ButtonBars(data:favorite.uid,counter: 0, ),
                                          ]),
                                        ),
                                       
                                      ],
                                    ),
                                  ),
                                  Divider(color: Colors.grey)
                                ],
                              );
                            }
                          }),
                  ],
                ),
              );
            }
          });
    }));
  }
}
