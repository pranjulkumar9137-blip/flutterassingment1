import 'package:card_widget_practice/data/data.dart';
import 'package:card_widget_practice/data/journal_entry_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class journal_card_widget extends StatelessWidget {
  final JournalEntryData entry;
  const journal_card_widget({super.key, required this.entry});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xECEDDC87),
      margin: EdgeInsets.symmetric(horizontal: 15,vertical: 8),
      child: Container(
        child:Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(entry.title,style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color:Colors.black87
                  ),),
                  const SizedBox(height: 8,),
                  Text(entry.content,style: TextStyle(
                    fontSize: 18,
                    color:Colors.black87,
                    fontWeight: FontWeight(600)
                  ),),
                  const SizedBox(height: 8,),

                  Text(entry.date,style: TextStyle(
                    fontSize: 20,
                    color:Colors.grey
                  ),)
                ],
              ),
        )
      ),
    );
  }
}

