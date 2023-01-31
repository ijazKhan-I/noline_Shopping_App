import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'admin_screen.dart';
import 'db_screen.dart';
import 'user_screen.dart';
import 'registeration_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  List<String> items=<String>[
    "Admin",
    "User"
  ];

  late String logemail,logPassword;

  var emailcontroler= TextEditingController();
  var passcontroler=TextEditingController();
  var Loginformkey= GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Log In")),
        automaticallyImplyLeading: false,
      ),

      body: Form(
        key: Loginformkey,
        child: Padding(
          padding:  EdgeInsets.all( MediaQuery.of(context).devicePixelRatio*10,),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("log in",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).devicePixelRatio*9,
                ),),
                SizedBox(height:MediaQuery.of(context).devicePixelRatio*3,),
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  height: MediaQuery.of(context).devicePixelRatio*40,
                  child: Image.asset("assets/login.jpg"),
                ), SizedBox(height: MediaQuery.of(context).devicePixelRatio*6,),
                SizedBox(
                  width: MediaQuery.of(context).devicePixelRatio*155,
                  height: MediaQuery.of(context).devicePixelRatio*22,
                  child: TextFormField(
                    controller: emailcontroler,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        hintText:"Enter email",
                        labelText:"Enter email",
                        prefix: const Icon(Icons.verified_user),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(MediaQuery.of(context).devicePixelRatio*6),
                        )
                    ),
                    validator: (String? text) {
                      if (text == null || text.isEmpty) {
                        return "Enter Email please!";
                      }else if(!text.contains("@") || !text.contains("."))
                      {
                        return "Invited email";
                      }

                      else {
                        logemail=emailcontroler.text;

                        return null;
                      }
                    },
                  ),
                ),SizedBox(height: MediaQuery.of(context).devicePixelRatio*6,),
                SizedBox(
                  width: MediaQuery.of(context).devicePixelRatio*155,
                  height: MediaQuery.of(context).devicePixelRatio*22,
                  child: TextFormField(
                    controller: passcontroler,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: "Enter password ",
                        labelText: "Enter password ",
                        prefix: const Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(MediaQuery.of(context).devicePixelRatio*6),
                        )
                    ),
                    validator: (String? text) {
                      if (text == null || text.isEmpty) {
                        return "Enter password please!";
                      } else {
                        //encrypt the password
                        final encrypt_The_passwor=passcontroler.text;
                        final key = encrypt.Key.fromLength(32);
                        final iv =encrypt.IV.fromLength(8);
                        final encrypter =encrypt.Encrypter(encrypt.Salsa20(key));
                        final encrypted = encrypter.encrypt(encrypt_The_passwor, iv: iv);
                        logPassword=encrypted.base64;
                        return null;
                      }
                    },
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).devicePixelRatio*6,),
                SizedBox(height: MediaQuery.of(context).devicePixelRatio*3,),
                ElevatedButton(onPressed: () async{

                  if(Loginformkey.currentState!.validate()){

                    var data= await DatabaseHelper.instance.read();
                    print(data);

                    for(var reads in data){
                      if(emailcontroler.text==reads["Email"]){
                        if(logPassword==reads["password"]){
                          if(reads["role"]==1){

                            Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminScreen()));

                          }else{
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>UserScreen()));

                          //  Fluttertoast.showToast(msg: "Login successfully!" );
                          }

                        }

                      }

                    }

                  }else
                  {
                    Fluttertoast.showToast(msg: "Invited " );
                  }
                }, child: const Text("Log in")),
                SizedBox(height: MediaQuery.of(context).devicePixelRatio*6,),
                //Registration button
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Registration()));
                }, child:const Text("Register now?")),
              ],
            ),
          ),
        ),

      ),
    );

  }

}