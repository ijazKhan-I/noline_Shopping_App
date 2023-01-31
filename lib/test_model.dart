class TestModel{
  int? id;
  late String title;
  late String description;
 late String price;
   String? image;
  TestModel({this.id,required this.title,required this.description,required this.price,required this.image});

  Map<String,dynamic> map(){


    return{
      "id":id,
      "title":title,
      "description":description,
      "price":price,
      "image":image,
    };
  }

  TestModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    description = map['description'];
    price= map['price'];
    image=map['image'];
  }
}