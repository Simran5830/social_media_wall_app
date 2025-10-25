import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wall/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings"), backgroundColor: Theme.of(context).colorScheme.surface,),
      body: 
      Column(
        children: [
          Padding(
            padding: EdgeInsets.all(15),
            
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Theme.of(context).colorScheme.secondary,
              ),
             
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsetsGeometry.all(15),
                    child: Text("Dark Mode")),
                  Spacer(),
                  CupertinoSwitch(value: Provider.of<ThemeProvider>(context, listen: false).isDark , onChanged: (value){
                
                  Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
                
                        }),
                       ] ),
            ),
          ),
    ]  ),
    );
  }
}