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
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Assignment 5"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(
                "this UI is depends on assignment 5",
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 21,
                ),
              ),
              SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  spacing: 21,
                  children: [
                    Container(height: 120, width: 120, color: Colors.blue),
                    Container(height: 120, width: 120, color: Colors.orange),
                    Container(height: 120, width: 120, color: Colors.yellow),
                    Container(height: 120, width: 120, color: Colors.red),
                    Container(height: 120, width: 120, color: Colors.brown),
                    Container(height: 120, width: 120, color: Colors.blue),
                  ],
                ),
              ),
              SizedBox(height: 30),

              Column(
                  children:[
                    Image.asset("assets/images/image.jpeg"),
                    SizedBox(height: 10,),
                    Image.asset("assets/images/image.jpeg"),
                    SizedBox(height: 10,),
                    Image.asset("assets/images/image.jpeg"),
                    SizedBox(height: 10,),
                    Image.asset("assets/images/image.jpeg"),
                    SizedBox(height: 10,),
                    Image.asset("assets/images/image.jpeg"),
                  ]
              ),
              SizedBox(height: 30,),
              Row(
                spacing: 20,
                children:[
                  Icon(Icons.eighteen_mp_outlined),
                  Icon(Icons.home),
                  Icon(Icons.eighteen_mp_sharp)
                ]
              )
            ],
          ),
        ),
      ),
    );
  }
}
