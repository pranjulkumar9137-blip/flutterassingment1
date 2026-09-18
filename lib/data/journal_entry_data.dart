import 'package:flutter/cupertino.dart';

class JournalEntryData {
  final int id;
  final String title;
  final String content;
  final String date;

  JournalEntryData(
  {
    required this.id,
    required this.title,
    required this.content,
    required this.date
  });
}