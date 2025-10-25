import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wall/components/like_component.dart';

class WallPost extends StatefulWidget {
  final String message;
  final String username;
  final Timestamp time;
  final String postId;
  final List<String> likes;

  const WallPost({super.key, required this.message, 
  required this.time, 
  required this.username,
  required this.postId,
  required this.likes});

  @override
  State<WallPost> createState() => _WallPostState();
}

class _WallPostState extends State<WallPost> {
final currentUser= FirebaseAuth.instance.currentUser;
bool isliked=false;

  @override void initState() {
    // TODO: implement initState
    super.initState();
      isliked= widget.likes.contains(currentUser!.email);
  }

  void toggleLike(){
    setState(() {
      isliked=!isliked;
    });
    DocumentReference postRef =FirebaseFirestore.instance.collection('posts').doc(widget.postId);
   if (isliked){
    postRef.update({
      'likes': FieldValue.arrayUnion([currentUser!.email])
    });}
    else{
      postRef.update({
        'likes':FieldValue.arrayRemove([currentUser!.email])
      });
    }
  }

  void deleteWall() async{

      if(currentUser!.email==widget.username){
        showDialog(context: context, builder: (context){
       return AlertDialog(
            content: Text("Are you sure you want to delete it"),
            actions: [
              ElevatedButton(onPressed:()=> Navigator.pop(context), child: Text("Cancel")),
              ElevatedButton(onPressed:() async {
                Navigator.pop(context);
                
                  await FirebaseFirestore.instance.collection('posts').doc(widget.postId).delete();
              }, child: Text("OK"))

            ],
       );
             });
        
  
      }
      else{
        showDialog(context: context, builder: (builder){
          return AlertDialog(
              content: Text("You Can't delete this post as you are not the"),
          );
        });
      }
  }
  @override
  Widget build(BuildContext context) {
    return 
    Container(
      decoration: BoxDecoration(
        
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(15)
        
      ),
      margin: EdgeInsets.all(15),
      child: Padding(
        padding: EdgeInsets.all(15),
        
          child: 
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [   
              Row(
              children: [

                Icon(Icons.person_pin_sharp, size: 30,),
                Text(widget.username, textAlign: TextAlign.right),
                Spacer(),
                Text(widget.time.toDate().toString().substring(0,16)),
                
                Spacer(),
                
              ],)
              ,Row(
                children: [
              Text(widget.message),
              Spacer(),
              Column(
                children:[
                  LikeComponent(isliked: isliked, onTap: ()=>toggleLike()),
                  Text('${widget.likes.length}'),]),
             if (currentUser!.email==widget.username)   IconButton(onPressed: deleteWall, icon: Icon(Icons.delete)),
              
             ] )

              ],
            ),
          ),
    );
  }
}