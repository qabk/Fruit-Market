import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutterauth/models/fruit.dart';

import 'open_and_close_card.dart';

class DisplayFruitCard extends StatelessWidget {
  List<Fruit> fruitList;
  DisplayFruitCard({
    Key? key,
    required this.fruitList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        height: size.height * 0.3,
        width: size.width * 0.9,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              for (int i = 0; i < fruitList.length; i++)
                Padding(
                  padding:  EdgeInsets.only(right: 20),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        OpenContainer(closedBuilder: (context, _) {
                          return ClosedCard(data: fruitList[i]);
                        }, openBuilder: (context, _) {
                          return OpenCard(
                            data: fruitList[i],
                          );
                        }),
                        Text(fruitList[i].name),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.04,
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: Row(
                            children: [
                              Icon(
                                Icons.currency_yen,
                                size: 12,
                              ),
                              Text(fruitList[i].price.toString() + " Per kg"),
                              
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
            ],
          ),
        ));
  }
}
