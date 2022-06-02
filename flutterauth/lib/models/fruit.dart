
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterauth/services/data_service.dart';

class Fruit {
  late String uid;
  late int id;
  late String name;
  late String img_link;
  late String type;
  late String kind;
  late int star;
  late var price;
  late String description;
  late List<dynamic> nutritions;

  Fruit(
      {required this.uid,
        required this.id,
      required this.name,
      required this.img_link,
      required this.type,
      required this.star,
      required this.price,
      required this.kind,
      required this.description,
      required this.nutritions});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      "uid":uid,
      'name': name,
      'img_link': img_link,
      'star': star,
      "price": price,
      "type": type,
      "kind": kind,
      "description": description,
      "nutritions": nutritions,
    };
    return map;
  }

  Future<List<Fruit>> fetchData(String kind, String type) async {
    DatabaseService databaseService =
        await DatabaseService(collectionName: "Fruits");
    var querySnapshot = await databaseService
        .get()
        .where("kind", isEqualTo: kind)
        .where("type", isEqualTo: type)
        .get();
        List<Fruit> res = [];
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    for(int i =0;i < allData.length; i++)
    {
      res.add(Fruit.fromMap(allData[i]));
    }

    return res;
  }

  Fruit.fromMap(Map<String, dynamic> map) {
    uid = map["uid"];
    id = map['id'];
    name = map['name'];
    description = map['description'];
    price = map['price'];
    img_link = map["img_link"];
    nutritions = map["nutritions"];
    type = map["type"];
    star = map["star"];
    kind = map["kind"];
  }
  List<Fruit> fruitListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc){
      //print(doc.data);
      return Fruit(
        uid: doc["uid"],
        id : doc['id'],
    name : doc['name'],
    description : doc['description'],
    price : doc['price'],
    img_link : doc["img_link"],
    nutritions : doc["nutritions"],
    type : doc["type"],
    star : doc["star"],
    kind: doc["type"],
        
      );
    }).toList();
  }
Stream<List<Fruit>> getfruitTypeKind(String type, String kind)
{
  return DatabaseService(collectionName: "Fruits").get()
        .where("kind", isEqualTo: kind)
        .where("type", isEqualTo: type).snapshots().map(fruitListFromSnapshot);
}
}

 