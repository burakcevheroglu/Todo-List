import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/homepage.dart';
import 'package:todoapp/notemodel.dart';

class NoteDetails extends ConsumerWidget {
  const NoteDetails({Key? key, required this.note}) : super(key: key);

  final NoteModel note;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController titleController = TextEditingController(
      text: note.title
    );
    TextEditingController noteController = TextEditingController(
      text: note.description
    );


    return Scaffold(
      backgroundColor: MyColors().grey,
      appBar: AppBar(
        title: Text(note.title),
        backgroundColor: MyColors().darkBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("TITLE", style: TextStyle(fontSize: 20,color: MyColors().darkBlue, letterSpacing: 5),),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
              width: double.infinity,
              color: MyColors().darkBlue,
              child: TextField(
                controller: titleController,
                autocorrect: false,
                decoration: const InputDecoration(
                  hintText: "It's time to write a great title!",
                  hintStyle: TextStyle(color: Colors.white54),
                  border: InputBorder.none,
                ),
                style: const TextStyle(color: Colors.white),


              ),
            ),
            const SizedBox(height: 30,),
            Text("NOTE DETAILS", style: TextStyle(fontSize: 20,color: MyColors().darkBlue, letterSpacing: 5),),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
              width: double.infinity,
              color: MyColors().darkBlue,
              child: TextField(
                controller: noteController,
                autocorrect: false,
                minLines: 10,
                maxLines: 10,
                decoration: const InputDecoration(
                  hintText: "It's time to show your note details into here.",
                  hintStyle: TextStyle(color: Colors.white54),
                  border: InputBorder.none,
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 50,),
            Container(
              width: double.infinity,
              height: 70,
              color: MyColors().darkBlue,
              child: InkWell(onTap: (){
                note.title = titleController.text;
                note.description = noteController.text;
                Navigator.pop(context);
              }, child: const Center(child: Text('SAVE CHANGES',style: TextStyle(color: Colors.white,fontSize: 18),))),
            )
          ],
        ),
      ),
    );
  }
}