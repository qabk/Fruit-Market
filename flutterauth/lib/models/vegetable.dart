class Vegetable {
  int id;
  String name;
  String img_link;
  int star;
  double price;
  String description;
  List<String> detailDescription;

  Vegetable(
      {required this.id,
      required this.name,
      required this.img_link,
      required this.star,
      required this.price,
      required this.description,
      required this.detailDescription});
}
