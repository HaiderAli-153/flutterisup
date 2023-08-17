
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled10/sign_in.dart';
import 'package:untitled10/ui_components/text_field.dart';

import 'home_page.dart';

class LoginPage extends StatelessWidget {
   LoginPage ({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();
   TextEditingController passController = TextEditingController();
   TextEditingController nameController = TextEditingController();
   


   void loginPage(context)async

   {

     String email = emailController.text.trim();
     String password = passController.text.trim();
     String name = nameController.text.trim();

     if(email == "" || password == ""|| name == ""){
       SnackBar snackBar = SnackBar(content: Text("Please fill in the feilds"));
       ScaffoldMessenger.of(context).showSnackBar(snackBar);
     }else{
       try{
         UserCredential userCredential = await  FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
         SnackBar snackBar = SnackBar(content: Text("Signed in"));
         ScaffoldMessenger.of(context).showSnackBar(snackBar);


           FirebaseFirestore.instance.collection("users").doc(userCredential.user!.uid)
               .set({"uid" : userCredential.user!.uid,
           "email":  email,"name": name});

         if(userCredential != null){
           Navigator.popUntil(context, (route) => route.isFirst);
           Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));



         }
       }on FirebaseAuthException catch(e){
         SnackBar snackBar = SnackBar(content: Text(e.code.toString()));
         ScaffoldMessenger.of(context).showSnackBar(snackBar);
       }


     }


   }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chat App"),),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 50,),
            Icon(Icons.message_outlined,size: 200,),
            SizedBox(height: 30,),
            Text("Welcome Back",style: TextStyle(color: Colors.grey,fontSize: 20),),
            SizedBox(height: 30,),
            TextFieldLogin(Text: "Name", controller: nameController),
            TextFieldLogin(Text: "Email", controller: emailController),

            TextFieldLogin(Text: "Password", controller: passController),

            CupertinoButton(child: Text("Login"),color: Colors.blue, onPressed: (){loginPage(context);}),
            SizedBox(height: 120,),

            Center(child: Row(children: [SizedBox(width: 65,),Text("If you are a new user please"),
              TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPage()));}, child: Text("Sign Up")),
              Text("here")
            ],),)

            

          ],
        ),
      ),
      
    );
  }
}
