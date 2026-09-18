import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter GridView",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final List<Map<String, dynamic>> products = const [
    {
      "name": "Laptop",
      "price": "₹60,000",
      "icon": Icons.laptop,
      "color": Colors.blue,
    },
    {
      "name": "Mobile",
      "price": "₹30,000",
      "icon": Icons.phone_android,
      "color": Colors.green,
    },
    {
      "name": "Camera",
      "price": "₹45,000",
      "icon": Icons.camera_alt,
      "color": Colors.orange,
    },
    {
      "name": "Watch",
      "price": "₹5,000",
      "icon": Icons.watch,
      "color": Colors.purple,
    },
    {
      "name": "Headphone",
      "price": "₹2,500",
      "icon": Icons.headphones,
      "color": Colors.red,
    },
    {
      "name": "Speaker",
      "price": "₹4,000",
      "icon": Icons.speaker,
      "color": Colors.teal,
    },
    {
      "name": "Camera",
      "price": "₹45,000",
      "icon": Icons.camera_alt,
      "color": Colors.orange,
    },
    {
      "name": "Watch",
      "price": "₹5,000",
      "icon": Icons.watch,
      "color": Colors.purple,
    },
    {
      "name": "Headphone",
      "price": "₹2,500",
      "icon": Icons.headphones,
      "color": Colors.red,
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Product Store"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),

        child: GridView.builder(
          itemCount: products.length,

          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.8,
          ),

          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "${products[index]["name"]} Selected",
                    ),
                  ),
                );
              },

              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),

                child: Padding(
                  padding: const EdgeInsets.all(12),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                    children: [

                      CircleAvatar(
                        radius: 35,
                        backgroundColor:
                        (products[index]["color"] as Color)
                            .withOpacity(0.2),

                        child: Icon(
                          products[index]["icon"],
                          size: 40,
                          color: products[index]["color"],
                        ),
                      ),

                      Text(
                        products[index]["name"],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Text(
                        products[index]["price"],
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.green,
                        ),
                      ),

                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) {
                              return AlertDialog(
                                title: Text(products[index]["name"]),
                                content: Text(
                                  "${products[index]["name"]} added successfully.",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("OK"),
                                  ),
                                ],
                              );
                            },
                          );
                        },

                        child: const Text("Buy Now"),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
