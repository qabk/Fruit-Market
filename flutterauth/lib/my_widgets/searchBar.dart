import 'package:flutter/material.dart';

class searchBar extends StatefulWidget {
  const searchBar({
    Key? key,
  }) : super(key: key);


  @override
  State<searchBar> createState() => _searchBarState();
}

class _searchBarState extends State<searchBar> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height*0.06,
      child: Stack(
        children: [
          Container(
            height: size.height*0.06 - 15,
            color: Colors.lightGreen[600]
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            // top: -1,
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: size.height*0.05,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0,10),
                    blurRadius: 25,
                    color: Colors.grey.withOpacity(0.3)
                  )
                ]
              ),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    color: Colors.grey
                  ),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
