import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wall/auth/auth.dart';
import 'package:flutter_wall/components/my_drawertile.dart';
import 'package:flutter_wall/pages/login_page.dart';
import 'package:flutter_wall/pages/profile_page.dart';
import 'package:flutter_wall/pages/register_page.dart';
import 'package:flutter_wall/pages/settings.dart';


class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      child: Column(
        children: [
          Padding(
            //ICON
            padding: EdgeInsetsGeometry.only(top: 100),
            child: Icon(Icons.person, size: 68, color: Theme.of(context).colorScheme.primary,))
      
      // DIVIDER
      , Padding(
        padding: EdgeInsets.all(25),
        child: Divider(
          
        ),
      ),

      //HOME TILE
      MyDrawertile(text: "H O M E", icon: Icons.home, onTap: ()=> Navigator.pop(context)),
      MyDrawertile(text: "P R O F I L E", icon: Icons.person, onTap: (){
        Navigator.pop(context);
        Navigator.push(context,
          MaterialPageRoute(builder: (context){
            return ProfilePage();
          }));
      }),
      // SETTING TILE
      MyDrawertile(text: "S E T T I N G S", icon: Icons.settings, onTap: (){ 
        Navigator.push(context, MaterialPageRoute(builder: (context)=> Settings()));
      })
      ,
      Spacer(),
      //LOGOUT TILE
      MyDrawertile(text: "L O G O U T", icon: Icons.logout, onTap: (){
        FirebaseAuth.instance.signOut();
        Navigator.push(context, MaterialPageRoute(builder: (context)=> Auth()));
      }),
        SizedBox(height: 25,)
        ],
      ),
    );
  }
}