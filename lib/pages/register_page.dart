import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wall/components/my_button.dart';
import 'package:flutter_wall/components/mytextfield.dart';
import 'package:flutter_wall/pages/home_page.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
   final TextEditingController emailController= TextEditingController();
  final TextEditingController passwordController=TextEditingController();
  final TextEditingController confirmPasswordController= TextEditingController();

  void newUser() async {
  if (passwordController.text != confirmPasswordController.text) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Error"),
        content: const Text("Passwords do not match!"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
    return;
  }

  // show loading
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => const Center(child: CircularProgressIndicator()),
  );

  try {
    UserCredential userCredential= await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
    //create user in db
    FirebaseFirestore.instance.collection('Users').doc(userCredential.user!.email).set({
      'username': emailController.text.split('@')[0],
      'bio': "Empty bio.."
    });

    if (context.mounted) Navigator.pop(context); // remove loading
    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomePage()),
      );
    }

  } on FirebaseAuthException catch (e) {
    if (context.mounted) Navigator.pop(context); // remove loading
    if (context.mounted) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Registration Failed"),
          content: Text(e.message ?? "Can't register"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            )
          ],
        ),
      );
    }
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person, size: 80,
            color: Theme.of(context).colorScheme.inversePrimary,),
            SizedBox(height: 20,),
            Text("Wall Post"),
            SizedBox(height: 20,),
              
             Mytextfield(controller: emailController, hintText: "Email", obscureText: false),
           SizedBox(height: 20,),
            Mytextfield(controller: passwordController, hintText: "Password", obscureText: true)
            ,SizedBox(height: 20,),
            Mytextfield(controller: confirmPasswordController, hintText: "Confirm Password", obscureText: true)
             ,
             SizedBox(height: 20,),

            MyButton(onTap: ()=>newUser(), text: "Sign Up"),
            SizedBox(height: 20,),
             Row(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already a member?", style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary
                    ),),
                    GestureDetector(
                      onTap: () {
                        widget.onTap!();
                      },
                      child: Text(" Login", style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontWeight: FontWeight.bold
                      ),))
                  ],
                ),
  
            
          ],
        ),
      ),
    );
  }
}