import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutterauth/viewmodels/user_auth_vm.dart';
import 'package:provider/provider.dart';

class AccountView extends StatelessWidget {
  const AccountView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<UserAuthProvider>(
      builder: ((context, value, child) {
        return(Scaffold(
          appBar:PreferredSize(
            preferredSize: Size.fromHeight(size.height*0.25),
            child: AppBar(
            title: CircleAvatar(child: Image.network(value.myUser.profile_img_link),radius: 30,),
          ),
          ),
          body: Text(value.myUser.email),
        ));
      }),
    );
  }
}