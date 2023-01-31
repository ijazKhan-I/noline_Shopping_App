import 'dart:math';
import 'dart:typed_data';

class ProductModle {
  int? id;
  late String title;
  late String description;
  late String price;
   String? picture;

  ProductModle({
    this.id,
    required this.title,
    required this.description,
    required this.price,
     this.picture,});


  Map<String,dynamic> map2(){

    return {
      "id":id,
      "title":title,
      "description":description,
      "price":price,
      "picture":picture,
    };
  }
  ProductModle.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    description = map['description'];
    price= map['price'];
    picture=map['picture'];
  }
}