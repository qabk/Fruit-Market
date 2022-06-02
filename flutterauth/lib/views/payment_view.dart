import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutterauth/viewmodels/shopping_provider.dart';
import 'package:provider/provider.dart';

import '../viewmodels/user_auth_vm.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(backgroundColor:Colors.green,title: Text("Payment"),centerTitle: true,),
      body: Container(
        child: Consumer<ShoppingProvider>(builder: (context, shopping, child) => StreamBuilder(
          stream: shopping.getByUser(
                      Provider.of<UserAuthProvider>(context).myUser.userId),
          builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot)
                      {
                        if(!snapshot.hasData|| snapshot.hasError)
                        {
                          return SpinKitFadingCircle(
  itemBuilder: (BuildContext context, int index) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color:  Colors.green,
      ),
    );
  },
);
                        }
                        else
                        {
                           var items = snapshot.data!.docs
                                  .map((doc) => doc.data())
                                  .toList()[0];
                          return Container(child: Text(items.toString()),);
                        }
                      },),),
      ),);
  }
}