import 'package:flutter/material.dart';

class Mycurrentlocation extends StatelessWidget {
  const Mycurrentlocation({super.key});

void openLocationSearchBox(context){
  showDialog(context: context, 
  builder: (context)=> AlertDialog( 
    title: Text("Enter location"),
    content: TextField(
      decoration: InputDecoration(
        hintText: "Search address"
      ),

      ),
      actions: [
        MaterialButton(onPressed:()=> Navigator.pop(context) ,child: Text("Cancel"),)
      , MaterialButton(onPressed: ()=>Navigator.pop(context), child: Text("Save"),)
      ],
    )
    
  );
  
}
  @override
  Widget build(BuildContext context) {
    return 
    Padding(
      padding: EdgeInsetsGeometry.all(25.0),
      child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: 
            [Text("Deliver Now", style: TextStyle(
              color: Theme.of(context).colorScheme.primary
            ),),
          
          GestureDetector(
            onTap:()=> openLocationSearchBox(context),
            child: Row(
              children: [
                Text("some address 6991",  style: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary, fontWeight: FontWeight.bold)),
                Icon(Icons.arrow_drop_down_rounded)
              ],
            ),
          )
        ]),
    )
      
    ;
  }
}