import 'package:flutter/material.dart';

class LikeComponent extends StatelessWidget {
  final bool isliked;
  final void Function()? onTap;

  const LikeComponent({super.key, 
  required this.isliked, 
  required this.onTap});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon( isliked ? Icons.favorite : Icons.favorite_border,
      color:  isliked? Colors.red: Colors.grey,)
    );
  }
}