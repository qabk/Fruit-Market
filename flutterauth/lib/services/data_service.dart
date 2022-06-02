import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseService
{
  //collection reference
  String  collectionName;
  static late CollectionReference _collectionReference;
  DatabaseService({required this.collectionName})
  {
    
    _collectionReference = FirebaseFirestore.instance.collection(collectionName);
  }
  
CollectionReference get()
{
  return _collectionReference;
}

}