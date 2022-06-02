import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


import 'package:flutterauth/models/fruit.dart';
import 'package:flutterauth/viewmodels/favorite_provider.dart';
import 'package:provider/provider.dart';

import '../viewmodels/fruits_provider.dart';
import 'display_card.dart';

class DisplayChoice extends StatelessWidget {
   String kind;
   String type;
 
  DisplayChoice({
    Key? key,
    required this.kind,
    required this.type,
    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    
    return Consumer<FruitProvider>(
      builder: (context,value, child){  
        value.getQuery(kind,type);
        return Container(
        child: StreamBuilder(
          stream: value.getQuery(kind, type),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }
    
            if (!snapshot.hasData ) {
              return Text("Document does not exist");
            }
            else  {
              var items = snapshot.data!.docs.map((doc) => doc.data()).toList();
              List<Fruit> data = [];
               items.forEach((element) {
                 data.add(Fruit.fromMap(element));
               });
               print(data);
               return DisplayFruitCard(fruitList: data);
            }
    
          
          },
        ),
      );}
    );
  }
}
