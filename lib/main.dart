import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_list_app/Widgets/glossary_list.dart';

void main(){

 runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Glossary App",
      theme: ThemeData.dark(useMaterial3: true).copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(
            124, 15, 174, 227),
          brightness: Brightness.dark,
          surface: Colors.black38,
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: GlossaryList(),
    );
  }

}