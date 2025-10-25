import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wall/components/my_button.dart';
import 'package:flutter_wall/components/mytextfield.dart';
import 'package:flutter_wall/pages/home_page.dart';
// import 'package:flutter_deliveryapp/themes/theme_provider.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController= TextEditingController();
  final TextEditingController passwordController=TextEditingController();

void login() async{

  showDialog(context: context, 
  barrierDismissible: false,
  builder: (builder){
    return AlertDialog(
      
      content: 
     const Center(child: CircularProgressIndicator()),
    );
  });
  //
//authentication
  //
  try{
 UserCredential? user= await FirebaseAuth.instance.signInWithEmailAndPassword(
  email: emailController.text.trim(), password: passwordController.text); 
    if (context.mounted)Navigator.pop(context);
    if(context.mounted){
   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage()));
    }
  } on FirebaseAuthException catch (e){
    Navigator.pop(context);
    invalidEmail(e);
  }
  //navigate to home page
 
}

void invalidEmail(e){
  showDialog(context: context, builder: (builder){
    return AlertDialog(
      content: Text("Invalid email or password $e" ),
    );
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
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

            MyButton(onTap: login, text: "Login"),

            SizedBox(height: 20,),
             Row(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Not a member?", style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary
                    ),),
                    GestureDetector(
                      onTap: () {
                        widget.onTap!();
                      },
                      child: Text(" Sign Up", style: TextStyle(
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