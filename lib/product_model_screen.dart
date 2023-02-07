
class ProductModle {
  int? id;
  late String title;
  late String description;
  late String price;
   String? picture;
   late int priceInt;
  ProductModle({
    this.id,
    required this.title,
    required this.description,
    required this.price,
     this.picture,required this.priceInt});
  Map<String,dynamic> map2(){

    return {
      "id":id,
      "title":title,
      "description":description,
      "price":price,
      "picture":picture,
      "priceInt":priceInt,
    };
  }
  ProductModle.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    description = map['description'];
    price= map['price'];
    picture=map['picture'];
    priceInt=map["priceInt"];
  }
}