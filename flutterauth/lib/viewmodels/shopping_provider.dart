import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';


import '../models/Order.dart';
import '../models/fruit.dart';

class ShoppingProvider with ChangeNotifier {
  static CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection("Shopping");
  
  getByDoc(String uid)
  {
    return _collectionReference.where("uid", isEqualTo:uid).snapshots();
  }

  getByUser(String userId)
  {
     return _collectionReference.where("userId", isEqualTo:userId).snapshots();
  }

  write(Order order)
  {
    _collectionReference.doc(order.uid).set({"uid":order.uid,"userId":order.userId,"shoppingList":order.shoppingList});
  }
}
