class NoteModel{
  String title;
  String description;
  bool completed;

  NoteModel({required this.title,required this.description, this.completed = false});

  static List<NoteModel> notes = [
    NoteModel(title: 'Daily Meeting with Team', description: "same as title"),
    NoteModel(title: '1', description: "same as title"),
    NoteModel(title: '2', description: "same as title", completed: true),
    NoteModel(title: '3', description: "same as title"),
    NoteModel(title: '4', description: "same as title"),
    NoteModel(title: '5', description: "same as title"),
  ];

  static List<NoteModel> get getNotes => notes;
}