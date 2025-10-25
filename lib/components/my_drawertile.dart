import 'package:flutter/material.dart';

class MyDrawertile extends StatefulWidget {
 final String text;
 final IconData? icon;
 final void Function()? onTap;

  const MyDrawertile({super.key, 
  required this.text,
  required this.icon,
  required this.onTap
  });

  @override
  State<MyDrawertile> createState() => _MyDrawertileState();
}

class _MyDrawertileState extends State<MyDrawertile> {
  
  @override
  Widget build(BuildContext context) {
    return 
    Padding(
      padding: EdgeInsets.only(left: 15),
      child: ListTile(
        title: Text(widget.text),
        leading: Icon(widget.icon),
        onTap: widget.onTap,
        // leading: ,
      ),
    );
  }
}