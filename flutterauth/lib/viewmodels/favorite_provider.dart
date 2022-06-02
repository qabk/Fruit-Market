import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutterauth/models/favorites.dart';
import 'package:provider/provider.dart';

import '../models/fruit.dart';

class FavoriteProvider with ChangeNotifier {
  static CollectionReference _favoritesDatabase =
      FirebaseFirestore.instance.collection("Favorites");
  
  get(String userId)
  {
    return _favoritesDatabase.where("userId", isEqualTo: userId).snapshots();
  }

  write( Favorites favorites)
  {
    _favoritesDatabase.doc(favorites.uid).set({"uid":favorites.uid,"userId":favorites.userId,"docFruitIds":favorites.docFruitIds});
  }

}
