import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutterauth/services/data_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FruitProvider with ChangeNotifier {
 static CollectionReference collectionReference = FirebaseFirestore.instance.collection("Fruits");

 getQuery(String kind, String type)
 {
   return collectionReference.where("kind", isEqualTo: kind).where("type",isEqualTo: type).snapshots();
 }

 getDoc(String doc)
 {
   return collectionReference.where("uid", isEqualTo: doc).snapshots();
 }
}
