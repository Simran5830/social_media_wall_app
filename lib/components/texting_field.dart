import 'package:flutter/material.dart';

class TextingField extends StatefulWidget {
  final String firstname;
  final String secondname;
  final void Function()? editFun;

  const TextingField({super.key
  , required this.firstname,
  required this.secondname,
  required this.editFun
  });

  @override
  State<TextingField> createState() => _TextingFieldState();
}

class _TextingFieldState extends State<TextingField> {

  @override
  Widget build(BuildContext context) {
    return 
    Padding(
      padding: EdgeInsets.all(15),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(11)
          
          
        ), child: 
        Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row( 
                children: [
              Text(widget.firstname, style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),),
             Spacer(),
              IconButton(onPressed: widget.editFun, icon: Icon(Icons.settings, size: 24,color: Theme.of(context).colorScheme.inversePrimary,),)
              ]),
             Text(widget.secondname),
            
          ]),
        )
      ));
  }
}