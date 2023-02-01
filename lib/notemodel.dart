import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final noteNotifierProvider =  ChangeNotifierProvider<NoteNotifier>((ref) => NoteNotifier());

class NoteModel{
  int id;
  String title;
  String description;
  bool completed;

  void completeReverse(){
    completed = !completed;
  }

  NoteModel({required this.id ,required this.title,required this.description, this.completed = false});
}

class NoteNotifier extends ChangeNotifier{
  final List<NoteModel> _notes =[
    NoteModel(id: 0 ,title: 'Daily Meeting with Team', description: "same as title"),
    NoteModel(id: 1 ,title: '1', description: "same as title"),
    NoteModel(id: 2 ,title: '2', description: "same as title", completed: true),
    NoteModel(id: 3 ,title: '3', description: "same as title"),
    NoteModel(id: 4 ,title: '4', description: "same as title"),
    NoteModel(id: 5 ,title: '5', description: "same as title"),
  ];

  List<NoteModel> get notes => _notes;

 void addNote(NoteModel note){
   _notes.add(note);
  notifyListeners();
 }

 void changeCompleted(NoteModel note){
   note.completeReverse();
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