

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled10/ui_components/chat_page.dart';
import 'package:untitled10/ui_components/data_class.dart';


class HomePage extends StatefulWidget {
   HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Map<String,dynamic> userMap;
  bool isLoading = false;

final FirebaseAuth _auth= FirebaseAuth.instance;

String chatRoom(String? user1,String? user2){
  if(user1![0].toLowerCase().codeUnits[0]>user2![0].toLowerCase().codeUnits[0]){
    return "$user1$user2";
  }else{
    return "$user2$user1";
  }
}



  @override
  Widget build(BuildContext context) {



    return Scaffold(appBar: AppBar(title: Text("Chat Box"),),


    body: StreamBuilder(
      stream: FirebaseFirestore.instance.collection("users").snapshots(),
      builder: (context,snaphot){

        if(snaphot.hasError){
          return Text("error");
        }if(snaphot.connectionState == ConnectionState.waiting){
          return Text("Loading");

        }

        return ListView.builder(itemCount: snaphot.data!.docs.length,itemBuilder: (context, int index)
        { var data=snaphot.data!.docs[index];
          print(data['name']);
          if(_auth.currentUser?.email !=null){



            return  Padding(
              padding: EdgeInsets.all(8),
              child: Card(

                child: InkWell(
                  onTap: (){
                    String roomId =chatRoom(FirebaseAuth.instance.currentUser?.email,userMap["name"]);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatPage(UserName: data['name'],  UserId: roomId,)));},
                  child: ListTile(
                    title: Text(snaphot.data!.docs[index]['name']),
                    trailing: Text(snaphot.data!.docs[index]['email']),
                  ),
                ),
              ),
            );//hello from hammad

          }else {
            return Container();
          }

        });

      },
    ),


      );

  }

  //Widget  _buildUserListItem(DocumnetSnapshot document){
   // Map<String,dynamic> data = document.data()! as Map<String, dynamic>;

    //if (FirebaseAuth.instance.currentUser!.email != data["email"]){
    //  return ListTile(
     //   title: data["email"],
    //    onTap: (){
     //     Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatPage(UserName: snaphot.data!.docs[index]['name'], userMap: userMap, UserId: UserId)))
    //    },
   //   );
  //  }
//  }
}
