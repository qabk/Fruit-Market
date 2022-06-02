import 'package:flutter/material.dart';

import 'package:flutterauth/viewmodels/change_tab_provider.dart';

import 'package:provider/provider.dart';

import '../components/fruit_choice.dart';
import '../components/top_navigation_bar.dart';

final List<String> topnavbaritems = ['Vegetables', 'Fruits', 'Dry Fruits'];

class FruitChoiceView extends StatelessWidget {
  const FruitChoiceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tab = Provider.of<ChangeTabNotifier>(context);
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          //searchBar
          const SizedBox(height: 10),
          //top navbar
          SizedBox(
              height: size.height * 0.1,
              width: size.width,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(topnavbaritems.length, (index) {
                    return InkWell(
                        onTap: () {
                          tab.setTab(index);
                        },
                        child: TopNavBar(
                            currentTab: tab.currentTab,
                            index: index,
                            title: topnavbaritems[index]));
                  }))),
          //body
          IndexedStack(
            index: tab.currentTab,
            children: [
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    DisplayChoice(
                         kind: "vegetables",type: "organic vegetable",),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    DisplayChoice(kind: "fruit", type: "organic"),
                    DisplayChoice(kind: "fruit", type: "mixed"),
                    DisplayChoice(kind: "fruit", type: "stone fruit"),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[  
                    DisplayChoice(
                        kind: "dry fruit", type: "indeshicent"),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
