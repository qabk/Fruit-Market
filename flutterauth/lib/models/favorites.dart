class Favorites {
  late String uid;
  late String userId;
  late List<dynamic> docFruitIds;
  Favorites(
      {required this.docFruitIds, required this.uid, required this.userId});

  Favorites.fromMap(Map<String, dynamic> map) {
    uid = map["uid"];
    userId = map["userId"];
    docFruitIds = map["docFruitIds"];
  }

  bool check(String fruitId) {
    return docFruitIds.contains(fruitId);
  }

  void addOrRemove(String fruitId) {
    if (!check(fruitId)) {
      docFruitIds.add(fruitId);
    } else {
      docFruitIds.remove(fruitId);
    }
  }
}
