import 'first_page.dart';

import 'tests.dart';
import 'package:intl/intl.dart';

    var now = DateTime.now();
    var formatter = DateFormat('dd.MM');
    String formattedDate = formatter.format(now);

class Book {
  final String title, pageCount, duration, note,date;
  Book({
    required this.title,
    required this.pageCount,
    required this.duration,
    required this.note,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
        'title': bTitleController.text.trim(),
        'pageCount': bPageCountController.text.trim(),
        'duration': bDurationController.text.trim(),
        'note': bNoteController.text.trim(),
        'date': formattedDate,
      };

  static Book fromJson(Map<String, dynamic> json) => Book(
      title: json['title'],
      pageCount: json['pageCount'],
      duration: json['duration'],
      note: json['note'],
      date: json['date']);

}

class Test {
  final String title, correctCount, wrongCount, blankCount,note,date;
  Test({
    required this.title,
    required this.correctCount,
    required this.wrongCount,
    required this.blankCount,
    required this.note,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
        'title': currentCollection,
        'correctCount': tCorrectCountController.text.trim(),
        'wrongCount': tWrongCountController.text.trim(),
        'blankCount': tBlankCountController.text.trim(),
        'note': tNoteController.text.trim(),
        'date': formattedDate,
      };

  static Test fromJson(Map<String, dynamic> json) => Test(
      title: json['title'],
      correctCount: json['correctCount'],
      wrongCount: json['wrongCount'],
      blankCount: json['blankCount'],
      note: json['note'],
      date: json['date']);

}

class Task {
  final String title,description,date;
  Task({
    required this.title,
    required this.description,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
        'taskTitle': taskTitle.text.trim(),
        'taskDescription': taskDescription.text.trim(),
        'date': formattedDate,
      };

  static Task fromJson(Map<String, dynamic> json) => Task(
        title: json['taskTitle'],
        description: json['taskDescription'],
        date: json['date']);

      
}
