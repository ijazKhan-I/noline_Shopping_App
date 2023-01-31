import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:onlineshoppinapp/db_screen.dart';
import 'package:onlineshoppinapp/product_model_screen.dart';
import 'package:onlineshoppinapp/test_db.dart';
import 'package:onlineshoppinapp/test_model.dart';
import 'image_model.dart';
import 'image_db.dart';


class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {

  List<String> items=<String>[
    "PKR",
    "Dollar"
  ];
  String dropdownValue="PKR";
  var formkey=GlobalKey<FormState>();
  var titleController=TextEditingController();
  var descriptController=TextEditingController();
  late String title,description,price;
 late  String picture;
  //
  // File? _image;
  // final _picker = ImagePicker();
  // Future<void> _openImagePicker() async {
  //   final XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);
  //   if (pickedImage != null) {
  //     setState(() async {
  //       _image = File(pickedImage.path);
  //
  //
  //     });
  //   }
  // }
  // final ImagePicker imagePicker= ImagePicker();
  // String imagepath="";
  // String base64string="";
  // OpenImage() async {
  //   var pickedFile=await imagePicker.pickImage(source: ImageSource.gallery,);
  //   if(pickedFile!=null){
  //     imagepath=pickedFile.path;
  //     print(imagepath);
  //     File imagefile= File(imagepath);
  //     Uint8List imagebyte= await imagefile.readAsBytes();
  //     base64string=base64.encode(imagebyte);
  //   }
  // }


  Future<String> pickImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 45);

   var imageBytes = await image!.readAsBytes();

    print("IMAGE PICKED: ${image.path}");

    String base64Image = base64Encode(imageBytes);

    return base64Image;
  }


  String? byte64String;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add product"),
      ),
      body: Form(
        key: formkey,
        child: Container(
          padding: EdgeInsets.all(20),
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              InkWell(
                onTap: () async {
                  //here call image picker
                  byte64String = await pickImage();

                },
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color:Colors.white,
                    shape: BoxShape.rectangle,
                    border: Border.all(color: Colors.grey,width: 2)
                  ),
                  child: Image.memory(base64Decode(byte64String!)),
                       // child: image!.isEmpty? Image.memory(
                       //     const Base64Decoder().convert(byte64String!)) : Text(
                       //     "No Profile"),

                ),
              ),
                 SizedBox(height: 20,),
              SizedBox(
                width: MediaQuery.of(context).devicePixelRatio*155,
                height: MediaQuery.of(context).devicePixelRatio*22,
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: "Title",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(MediaQuery.of(context).devicePixelRatio*6),
                      )
                  ),
                  validator: (String? text){
                    if(text==null||text.isEmpty){
                      return "Enter title";
                    }else{
                      title=text;
                      return null;
                    }
                  },
                ),
              ),
              SizedBox(height: 20,),
                 SizedBox(
                   width: MediaQuery.of(context).devicePixelRatio*155,
                   height: MediaQuery.of(context).devicePixelRatio*22,
                   child: TextFormField(
                     decoration: InputDecoration(
                       hintText: "Description",
                       border: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(MediaQuery.of(context).devicePixelRatio*6),
                       )
                     ),
                     validator: (String? text){
                       if(text==null||text.isEmpty){
                         return "Enter Description";
                       }else{
                         description=text;
                         return null;
                       }
                     },
                   ),
                 ),
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.all(MediaQuery.of(context).devicePixelRatio*5),
                width: MediaQuery.of(context).devicePixelRatio*155,
                height: MediaQuery.of(context).devicePixelRatio*22,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1,color: Colors.grey)
                ),
                //DropdownButton......
                child: DropdownButton<String>(
                  isExpanded: true,
                  onChanged: (String? newValue){
                    setState(() {
                      dropdownValue=newValue!;
                    });
                  },
                  value: dropdownValue,
                  items: items.map<DropdownMenuItem<String>>(
                        (String value){
                      return DropdownMenuItem(value: value,child: Text(value,style: TextStyle(
                        color: Colors.grey,
                      ),));
                    },
                  ).toList(),
                ),
              ),
              ElevatedButton(onPressed: () async{
                if(formkey.currentState!.validate()){
                  picture="okkk";
                 price=dropdownValue;
                 TestModel model=TestModel(title: title, description: description, price: price, image: byte64String);
                 var insert=await Helper.instance.Insert(model);
                 await DatabaseHelper2.insertProfile(ProfileModel(title:title,description: description,price: price,image64bit: byte64String).toMap());
                 
                 ProductModle productM=ProductModle(title: title, description: description, price: price, picture:byte64String );
                 var result= await  DatabaseHelper.instance.productInsert(productM);
                //  var red=await DatabaseHelper.instance.productRead();
                //  print(red);

                //  if(//result>0){
                //
                //  }
                //  else{
                //
                //  }
                //
                // }else{
                }
              }, child: Text("Submit")),
            ],
          ),
        ),
      ),
    );
  }

}
