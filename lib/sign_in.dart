import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled10/login_page.dart';
import 'package:untitled10/ui_components/text_field.dart';

import 'home_page.dart';

class SignUpPage extends StatelessWidget {
   SignUpPage({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController cPassController = TextEditingController();
   TextEditingController nameController = TextEditingController();

   var userName;

 void signUp(context)async{

   String email = emailController.text.trim();
   String passWord = passController.text.trim();
   String cPass = cPassController.text.trim();
   String name = nameController.text.trim();



   if(email == "" || passWord == "" || cPass == "" || name == ""){
     SnackBar snackBar = SnackBar(content: Text("Please enter complete data"));
     ScaffoldMessenger.of(context).showSnackBar(snackBar);

   }else if(passWord != cPass){
     SnackBar snackBar = SnackBar(content: Text("Passwords d'nt match"));
     ScaffoldMessenger.of(context).showSnackBar(snackBar);

   }else{
     try{
       UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: passWord);
       SnackBar snackBar = SnackBar(content: Text("Data saved"));
       ScaffoldMessenger.of(context).showSnackBar(snackBar);

         FirebaseFirestore.instance.collection("users").doc(userCredential.user!.uid)
             .set({"uid" : userCredential.user!.uid,
           "email":  email,"name": name,},SetOptions(merge: true));



       if(userCredential != null){
         Navigator.popUntil(context, (route) => route.isFirst);
         Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));



       }


     }on FirebaseAuthException catch(e){
       SnackBar snackBar = SnackBar(content: Text(e.code.trim()));
       ScaffoldMessenger.of(context).showSnackBar(snackBar);


     }
   }

   UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: passWord);

  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text("Chat App"),),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 50,),
            Icon(Icons.message_outlined,size: 170,),
            SizedBox(height: 30,),
            Text("Fill All The Fields",style: TextStyle(color: Colors.grey,fontSize: 20),),
            SizedBox(height: 30,),
            TextFieldLogin(Text: "name", controller: nameController),

            TextFieldLogin(Text: "Email", controller: emailController),
            TextFieldLogin(Text: "Password", controller: passController),
            TextFieldLogin(Text: "Confirm  Password", controller: cPassController),


            CupertinoButton(color: Colors.blue, onPressed: (){signUp(context);}, child: const Text("Sign Up")),
            SizedBox(height: 20,),

            Center(child: Row(children: [SizedBox(width: 65,),Text("If all ready Have a account"),
              TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));}, child: Text("Login")),
              Text("here")
            ],),)

          ],
        ),
      ),
    );
  }
}
