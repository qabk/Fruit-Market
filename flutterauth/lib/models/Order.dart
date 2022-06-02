class Order
{
late String uid;
late String userId;
late Map <dynamic,dynamic> shoppingList;

Order({required this.uid, required this.userId, required this.shoppingList});
Order.fromMap(Map<String, dynamic> map)
{
uid = map["uid"];
userId = map["userId"];
shoppingList = map["shoppingList"];
}
}
class Detail
{
  String uid;
  int counter;
  Detail({required this.uid, required this.counter});
}