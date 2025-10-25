import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wall/components/my_drawer.dart';
import 'package:flutter_wall/components/texting_field.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final currentUser= FirebaseAuth.instance.currentUser;
  final TextEditingController controller= TextEditingController();
  String newValue="";
  void editFun( String field) async{
    await showDialog(context: context, builder: (context){
        return AlertDialog(
          title: Text(" Edit $field"),
          
          content:  
           TextField(
              decoration: InputDecoration(
              hintText: "Enter $field", fillColor: Colors.grey[100] ,
              
            ),
          
          controller: controller,
          onChanged: (value){
            newValue=value;
          },
          ),
          actions: [
            ElevatedButton(onPressed: ()=> Navigator.pop(context), child: Text("Cancel")),
            TextButton(onPressed: (){
              Navigator.of(context).pop(newValue);
              controller.clear();
              if (newValue.trim().isNotEmpty){
               FirebaseFirestore.instance.collection('Users').doc(currentUser!.email).update({
                 field :newValue
      
          });
    }
            }, child: Text('Save'))
          ],
        );

    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile"),
      backgroundColor: Theme.of(context).colorScheme.secondary,),
      // drawer: MyDrawer(),
      body: 
      Padding(
        padding: EdgeInsetsGeometry.only(left: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child:
               Padding(
                padding: EdgeInsets.all(15),
                 child: Column(
                  children: [
                    Icon(Icons.person, size: 54,),
                    Text('${currentUser!.email}'),
                 
                         ]),
               )),
               Text("User Details", textAlign: TextAlign.start,),
               StreamBuilder(
                 stream: FirebaseFirestore.instance.collection('Users').doc(currentUser!.email).snapshots(),
                 
                 builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData){
                    return CircularProgressIndicator();
                  }
                  var data=snapshot.data.data();
                   return Container(
                     child: Column(
                      children: [
                     TextingField(firstname: "username",secondname: data['username'] , editFun:()=> editFun('username'),),
                     TextingField(firstname: "bio", secondname: data['bio'], editFun: ()=>editFun('bio'),),
           ] )  );
                 },
               ),
               
               
          ],
        ),
      )
    );
  }
}