import 'package:card_widget_practice/data/data.dart';
import 'package:card_widget_practice/data/journal_entry_data.dart';
import 'package:card_widget_practice/journal_card_widget.dart';
import 'package:flutter/material.dart';

import 'AddRoutine.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home:MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("Daily routine manage"),
          centerTitle: true,
        ),
        body:ListView.builder(
          itemCount: data_list.length,
            itemBuilder: (context,index){
               return journal_card_widget(
                 entry: data_list[index],
               );
            }
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.amber,
            onPressed: (){
                showModalBottomSheet(
                    context: context,
                    builder: (context){
                      return Addroutine(
                        onSave: (JournalEntryData entry)
                        {
                          setState(() {
                            data_list.add(entry);
                          });
                        },
                      );
                    }
                );
            },
          child:Icon(Icons.add)
        ),

    );
  }
}
