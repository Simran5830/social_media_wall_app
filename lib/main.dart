import 'package:flutter/material.dart';
import 'package:flutter_wall/auth/auth.dart';
import 'package:flutter_wall/firebase_options.dart';
import 'package:flutter_wall/themes/theme_provider.dart';
import 'package:provider/provider.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(create: (_)=>ThemeProvider(), 
    child: 
    MyApp()));
}

class MyApp extends StatelessWidget {
  
  const MyApp({super.key}); 

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // final themeProvider = context.watch<ThemeProvider>();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: Auth()
      // home:
    );
  }
}
