import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:onlineshoppinapp/db_screen.dart';
import 'package:onlineshoppinapp/model_screen.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  late var name, email, password, Confirm_password,Role;
  var formkey = GlobalKey<FormState>();
  List<String> items=<String>[
    "Admin",
    "User"
  ];
  String dropdownValue="Admin";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("sign up"),
      ),
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).devicePixelRatio*10),
        child: Form(
          key: formkey,

          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "sign up",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize:  MediaQuery.of(context).devicePixelRatio*9,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).devicePixelRatio*3,
                ),
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(width:MediaQuery.of(context).devicePixelRatio*0,)),
                  height: MediaQuery.of(context).devicePixelRatio*35,
                  child: Image.asset("assets/regis.png"),

                ),
                SizedBox(
                  height: MediaQuery.of(context).devicePixelRatio*4,
                ),
                SizedBox(
                  width: MediaQuery.of(context).devicePixelRatio*155,
                  height: MediaQuery.of(context).devicePixelRatio*22,
                  child: TextFormField(

                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        prefix: const Icon(Icons.verified_user),
                        hintText: "User name",
                        labelText: "User name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(MediaQuery.of(context).devicePixelRatio*6),
                        )),
                    validator: (String? text) {

                      if (text == null || text.isEmpty){
                        return "Enter name please!";

                      }
                      else {
                        name=text.toString();
                        return null;
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).devicePixelRatio*6,
                ),
                SizedBox(
                  width: MediaQuery.of(context).devicePixelRatio*155,
                  height: MediaQuery.of(context).devicePixelRatio*22,
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        prefix: const Icon(Icons.email),
                        hintText: "Enter email",
                        labelText: "Enter email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(MediaQuery.of(context).devicePixelRatio*6),
                        )),
                    validator: (String? text) {
                      if (text == null || text.isEmpty) {
                        return "Enter email please!";
                      }else if(!text.contains("@") || !text.contains(".")||!text.contains("gmail")){
                        return "Invalid email";
                      }

                      else {
                        email=text.toString();

                        return null;
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).devicePixelRatio*6,
                ),
                SizedBox(
                  width: MediaQuery.of(context).devicePixelRatio*155,
                  height: MediaQuery.of(context).devicePixelRatio*22,
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: InputDecoration(
                        prefix: const Icon(Icons.lock),
                        hintText: "Enter password",
                        labelText: "Enter password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(MediaQuery.of(context).devicePixelRatio*6),
                        )),
                    validator: (String? text) {
                      if (text == null || text.isEmpty) {
                        return "Enter password please!";
                      }

                      else {
                       password=text.toString();

                        return null;
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).devicePixelRatio*6,
                ),
                SizedBox(
                  width: MediaQuery.of(context).devicePixelRatio*155,
                  height: MediaQuery.of(context).devicePixelRatio*22,
                  child: TextFormField(
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        prefix: const Icon(Icons.lock),
                        hintText: "Confirm password",
                        labelText: "Confirm password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(MediaQuery.of(context).devicePixelRatio*6),
                        )),
                    validator: (String? text) {
                      if (text == null || text.isEmpty ) {
                        return "Confirm password please!";
                      }

                      else {
                        Confirm_password = text.toString();
                        if(Confirm_password!=password)
                        {
                          return "Password not match";
                        }

                      }
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).devicePixelRatio*6,
                ),
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
                SizedBox(
                  height: MediaQuery.of(context).devicePixelRatio*6,
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (formkey.currentState!.validate()) {
                        //encrypt the password
                        final p=password;
                        final key = encrypt.Key.fromLength(32);
                        final iv =encrypt.IV.fromLength(8);
                        final encrypter =encrypt.Encrypter(encrypt.Salsa20(key));

                        final encrypted = encrypter.encrypt(p, iv: iv);
                       final encriptedPassword=encrypted.base64;
                       //check the dropdownItems
                       if(dropdownValue=="Admin"){
                         Role=1;
                       }
                       else{
                         Role=2;
                       }
                       Registeration reg= Registeration(name: name,
                           email: email,
                           password: encriptedPassword,
                           Role: Role);

                       var result= await DatabaseHelper.instance.insertion(reg);

                       if(result>0){
                         Fluttertoast.showToast(msg: "submit successfully!" );
                       }
                       else{
                         Fluttertoast.showToast(msg: "Record failed" );
                       }


                      }
                      else
                      {

                      }
                    },
                    child: const Text("Submit")),

              ],
            ),
          ),
        ),
      ),
    );
  }
  void Encrip(){

  }
}