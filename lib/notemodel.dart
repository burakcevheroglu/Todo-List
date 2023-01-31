import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final noteNotifierProvider =  ChangeNotifierProvider<NoteNotifier>((ref) => NoteNotifier());

class NoteModel{
  String title;
  String description;
  bool completed;

  NoteModel({required this.title,required this.description, this.completed = false});
}

class NoteNotifier extends ChangeNotifier{
  final List<NoteModel> _notes =[
    NoteModel(title: 'Daily Meeting with Team', description: "same as title"),
    NoteModel(title: '1', description: "same as title"),
    NoteModel(title: '2', description: "same as title", completed: true),
    NoteModel(title: '3', description: "same as title"),
    NoteModel(title: '4', description: "same as title"),
    NoteModel(title: '5', description: "same as title"),
  ];

  List<NoteModel> get notes => _notes;

 void addNote(NoteModel note){
   _notes.add(note);
  notifyListeners();
 }


  void removeNote(NoteModel note){
    _notes.remove(note);
    notifyListeners();
  }

}




/*
  static List<NoteModel> notes = [
    NoteModel(title: 'Daily Meeting with Team', description: "same as title"),
    NoteModel(title: '1', description: "same as title"),
    NoteModel(title: '2', description: "same as title", completed: true),
    NoteModel(title: '3', description: "same as title"),
    NoteModel(title: '4', description: "same as title"),
    NoteModel(title: '5', description: "same as title"),
  ];

  static List<NoteModel> get getNotes => notes;
 */