

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled10/ui_components/text_field.dart';


class ChatPage extends StatelessWidget {
   ChatPage({Key? key,required this.UserName, required this.UserId}) : super(key: key);
  final UserName;
  final UserId;

  TextEditingController messageController= TextEditingController();


  User? user =FirebaseAuth.instance.currentUser;

  void onSendMessage()async{

    Map<String, dynamic> messages = {};

    FirebaseFirestore.instance.collection('chatroom').doc(UserId).collection("chats").add(
        {
          "sendby" : user?.displayName,
          "message" : messageController.text,
        });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(UserName),),
      body: Column(

        children: [
          Expanded(
            child: SingleChildScrollView(child: Column(
              children: [
                Container(child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection("chatroom").doc(UserId)
                        .collection("chats").snapshots()
                    ,builder:
                ((context,AsyncSnapshot<QuerySnapshot> snapshot){
                  if(snapshot.data != null){
                  return ListView.builder(itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context,index){

                    Map<String,dynamic>  map = snapshot.data!.docs[index].data() as Map<String,dynamic>;

                    return  snapshot.data!.docs[index]['message'];
                  });
                }else{
                    return Container();
                }
                })),)
              ],
            ),),
          ),
          Row(children: [IconButton(onPressed: (){}, icon: Icon(Icons.emoji_emotions,size: 40,),),
            IconButton(onPressed: (){}, icon: Icon(Icons.image,size: 40,),),
            SizedBox(width: 270,child: TextFieldLogin(Text: "Type Message", controller: messageController,)),
            IconButton(onPressed: (){onSendMessage();}, icon: Icon(Icons.send,size: 40,),)
          ],),

        ],
      ),
    );
  }
}
