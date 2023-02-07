class Add_To_Cart{

  int? id;
 late int userID;
 late int productID;
 late String name;
 late String Email;
 late String password;
 late int role ;
 late String title;
 late String description;
 late String picture;
 late String price;
 late int priceInt;

  Add_To_Cart({this.id,required this.userID,required this.productID});

  Map<String,dynamic> map(){
    return{
      "id":id,
      "userID":userID,
      "productID":productID
    };
  }
  Add_To_Cart.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    userID = map['userID'];
    productID = map['productID'];
    name=map["name"];
    Email=map["Email"];
    password=map["password"];
    role=map["role"];
    title=map["title"];
    description=map["description"];
    picture=map["picture"];
    price=map["price"];
    priceInt=map["priceInt"];


}
}