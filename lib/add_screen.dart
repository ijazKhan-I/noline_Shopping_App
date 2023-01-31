import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:onlineshoppinapp/db_screen.dart';
import 'package:onlineshoppinapp/product_model_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';


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
  Future<String> pickImageCamera() async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 45);

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
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   InkWell(
                     onTap: () async {
                       byte64String= await pickImageCamera();
                     },
                     child: Container(
                       width: 70,
                       height: 70,
                       decoration: BoxDecoration(

                         color:Colors.white,
                         borderRadius: const BorderRadius.only(
                             topLeft: Radius.circular(10),
                             topRight: Radius.circular(10),
                             bottomLeft: Radius.circular(10),
                             bottomRight: Radius.circular(10)),
                         boxShadow: [
                           BoxShadow(
                             color: Colors.grey.withOpacity(0.5),
                             spreadRadius: 5,
                             blurRadius: 7,
                             offset: const Offset(0, 3), // changes position of shadow
                           ),
                         ],
                       ),
                       child: Image.asset("assets/cam.png"),
                     ),
                   ),
                   const SizedBox(width: 15,),
                   InkWell(
                     onTap: () async {
                       byte64String= await pickImage();
                     },
                     child: Container(
                       width: 70,
                       height: 70,
                       decoration: BoxDecoration(

                         color:Colors.white,
                         borderRadius: const BorderRadius.only(
                             topLeft: Radius.circular(10),
                             topRight: Radius.circular(10),
                             bottomLeft: Radius.circular(10),
                             bottomRight: Radius.circular(10)),
                         boxShadow: [
                           BoxShadow(
                             color: Colors.grey.withOpacity(0.5),
                             spreadRadius: 5,
                             blurRadius: 7,
                             offset: const Offset(0, 3), // changes position of shadow
                           ),
                         ],
                       ),
                       child: Image.asset("assets/gallary.png"),
                     ),
                   ),
                 ],
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
                 price=dropdownValue;
                // TestModel model=TestModel(title: title, description: description, price: price, image: byte64String);
                // var insert=await Helper.instance.Insert(model);
                 //await DatabaseHelper2.insertProfile(ProfileModel(title:title,description: description,price: price,image64bit: byte64String).toMap());
                 
                 ProductModle productM=ProductModle(title: title, description: description, price: price, picture:byte64String );
                 var result= await  DatabaseHelper.instance.productInsert(productM);
                //  var red=await DatabaseHelper.instance.productRead();
                 if(result>0){
                Fluttertoast.showToast(msg: "Save");
                 }
                 else{

                 }

                }else{
                }
              }, child: Text("Submit")),
            ],
          ),
        ),
      ),
    );
  }

}
