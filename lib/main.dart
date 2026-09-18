import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var mynum=1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body:Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
               children:[
               Image.asset(
                 "assets/images/image$mynum.png",
                 height: 150,
                 width: 150,
                 fit:BoxFit.contain
               ),
                 SizedBox(height: 30,),
                 Text('$mynum'),
                 SizedBox(height: 30,),
                 ElevatedButton(
                     onPressed: ()=>{
                       setState(() {
                        var random=Random();
                        mynum=random.nextInt(6)+1;
                       })
                     },
                     child: Text("dice",style: TextStyle(
                         fontWeight: FontWeight.bold,
                     fontSize: 24)
                 ))
            ]),
          ),
        )
    );
  }
}
