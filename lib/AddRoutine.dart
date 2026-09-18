import 'package:card_widget_practice/data/data.dart';
import 'package:card_widget_practice/data/journal_entry_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'main.dart';

class Addroutine extends StatefulWidget {
  final Function(JournalEntryData) onSave;
  const Addroutine({required this.onSave,super.key});

  @override
  State<Addroutine> createState() => _AddroutineState();
}

class _AddroutineState extends State<Addroutine> {
  var titleController=TextEditingController();
  var contentController=TextEditingController();
  int count=1;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 70.0),
        child: Column(
          children: [
            TextField(
              controller:titleController ,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText:"Title",
                border: OutlineInputBorder(),
                hintText: "Enter your title"
              ),
            ),
            const SizedBox(height: 20,),
            TextField(
              decoration: InputDecoration(
                  labelText:"Content",
                  border: OutlineInputBorder(),
                  hintText: "Enter your Content"
              ),
              controller: contentController,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 25,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    foregroundColor: Colors.white,
                    textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    )
                    ),
                    onPressed:()
                    {
                      titleController.clear();
                      contentController.clear();
                      Navigator.pop(context);
                    },
                    child: Text("Cancel")
                ),
                ElevatedButton(
                    style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        textStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        )
                    ),
                    onPressed:()
                    {
                        JournalEntryData entry=JournalEntryData(
                            id: count,
                            title: titleController.text,
                            content: contentController.text,
                            date:DateFormat('dd/MM/yyyy').format(DateTime.now()));
                        // setState(() {
                        //   data_list.add(entry);
                        // }); now we calling the function onsave
                        setState(() {
                          count++;
                        });
                        widget.onSave(entry);
                        Navigator.pop(context);
                    },
                    child: Text("Save"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
