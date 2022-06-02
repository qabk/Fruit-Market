import 'package:flutter/material.dart';

class TopNavBar extends StatelessWidget {
  const TopNavBar({
    Key? key,
    required this.currentTab, 
    required this.index, 
    required this.title,
  }) : super(key: key);

  final int currentTab;
  final int index;
  final String title;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: currentTab==index ? Colors.orange[600] : null,
        borderRadius: BorderRadius.circular(5)
      ),
      height: size.height*0.05,
      width: size.width*0.2,
      child: Text(title,
        style: TextStyle(
          color: currentTab==index ? Colors.white : Colors.grey
        ),
      ),
    );
  }
}
