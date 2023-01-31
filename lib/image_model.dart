
class ProfileModel{

  int? id;
  String? title;
  String? description;
  String? price;
  String? image64bit;

  ProfileModel({this.id ,this.title,this.description,this.price,  this.image64bit});

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      "title":title,
      "description":description,
      "price":price,
      "image64bit" : image64bit
    };

    if(id!=null){
      map["id"] = id;
    }

    return map;
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) =>
      ProfileModel(
          id: map["id"],
          title:map["title"],
          description: map["description"],
          price: map["price"],
          image64bit: map["image64bit"]
      );



}