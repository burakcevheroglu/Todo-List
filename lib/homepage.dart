import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/categorymodel.dart';
import 'package:todoapp/notedetails.dart';
import 'package:todoapp/notemodel.dart';

final categoryProvider =
    Provider<List<CategoryModel>>((ref) => CategoryModel.getCategories);

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 52, 79, 161),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TopButtonsRow(),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "What's Up Burak!",
                  style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w800,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Categories",
                  style: TextStyle(
                      color: MyColors().foregroundBlue,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 150,
                  width: double.infinity,
                  child: ListView.builder(
                    itemCount: CategoryModel.getCategories.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return CategoryCard(
                        index: index,
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "TODAY'S TASKS",
                  style: TextStyle(
                      color: MyColors().foregroundBlue,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 10,
                ),
                SingleChildScrollView(
                  child: SizedBox(
                    width: double.infinity,
                    height: 400,
                    child: Consumer(
                      builder: (context, ref, child) {
                        final note = ref.watch(noteNotifierProvider);
                        return (note.notes.isEmpty)
                            ? const ZeroNoteWidget()
                            : ListView.builder(
                                itemCount: note.notes.length,
                                itemBuilder: (context, index) {
                                  return NoteCard(index: index);
                                },
                              );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Consumer(builder: (context, ref, child) {
        final note = ref.watch(noteNotifierProvider);
        return FloatingActionButton(
          onPressed: () {
            addNewNote(note);
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          backgroundColor: MyColors().purple,
          child: const Icon(Icons.add),
        );
      }),
    );
  }
}

void addNewNote(NoteNotifier note) {
  note.addNote(NoteModel(
      id: note.notes.length,
      title: 'New note!   id:${note.notes.length}',
      description: 'Yes this is new note with riverpod!',
      date: DateTime.now(),
  ));
}

class ZeroNoteWidget extends ConsumerWidget {
  const ZeroNoteWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final note = ref.watch(noteNotifierProvider);

    return Expanded(
        child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: MyColors().darkBlue,
      ),
      child: Container(
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: MyColors().backgroundBlue),
          child: Center(
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () => addNewNote(note),
              child: Container(
                width: 300,
                height: 70,
                decoration: BoxDecoration(
                  color: MyColors().darkBlue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    'Create a new note now!',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          )),
    ));
  }
}

class NoteCard extends ConsumerWidget {
  final int index;
  const NoteCard({super.key, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final note = ref.watch(noteNotifierProvider);
    final myNote = note.notes[index];

    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () async {
          NoteModel result = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NoteDetails(note: myNote)));
          note.makeChanges(myNote, result);
        },
        child: Container(
          height: 80,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: MyColors().darkBlue),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  note.changeCompleted(note.notes[index]);
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: (myNote.completed)
                          ? ((index % 2 == 0)
                              ? MyColors().purple
                              : MyColors().lightBlue)
                          : null,
                      border: (!myNote.completed)
                          ? Border.all(
                              color: (index % 2 == 0)
                                  ? MyColors().purple
                                  : MyColors().lightBlue,
                              width: 2)
                          : null),
                  child: (myNote.completed) ? const Icon(Icons.check) : null,
                ),
              ),
              Expanded(
                  flex: 8,
                  child: (myNote.title.isEmpty)
                      ? Text(
                          myNote.description.substring(0, (myNote.description.length < 30) ? myNote.description.length : 30),
                      style: (myNote.completed)
                          ? const TextStyle(
                          color: Colors.white70,
                          fontSize: 18,
                          decoration: TextDecoration.lineThrough,
                          decorationThickness: 2)
                          : const TextStyle(
                          color: Colors.white70, fontSize: 18),
                        )
                      : Text(myNote.title,
                          style: (myNote.completed)
                              ? const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  decoration: TextDecoration.lineThrough,
                                  decorationThickness: 2)
                              : const TextStyle(
                                  color: Colors.white, fontSize: 18))),
              Expanded(
                  flex: 2,
                  child: IconButton(
                    onPressed: () {
                      note.removeNote(myNote);
                    },
                    icon: const Icon(
                      Icons.delete_outline,
                      color: Colors.redAccent,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends ConsumerWidget {
  final int index;

  const CategoryCard({super.key, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoryProvider);

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 20),
          width: 250,
          height: 150,
          decoration: BoxDecoration(
            color: MyColors().darkBlue,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '${categories[index].taskCount.toString()} tasks',
                  style: TextStyle(
                      color: MyColors().foregroundBlue.withOpacity(.6),
                      fontSize: 18),
                ),
                Text(
                  categories[index].title,
                  style: const TextStyle(color: Colors.white, fontSize: 24),
                ),
                LinearProgressIndicator(
                  value: categories[index].taskCount / 100,
                  color: (index % 2 == 0)
                      ? MyColors().purple
                      : MyColors().lightBlue,
                  backgroundColor: MyColors().grey,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class TopButtonsRow extends StatelessWidget {
  const TopButtonsRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu_sharp,
              size: 30,
              color: Color.fromARGB(255, 152, 179, 255),
            )),
        Row(
          children: [
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search,
                    size: 30, color: Color.fromARGB(255, 152, 179, 255))),
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_outlined,
                    size: 30, color: Color.fromARGB(255, 152, 179, 255)))
          ],
        )
      ],
    );
  }
}

class MyColors {
  Color backgroundBlue = const Color.fromARGB(255, 52, 79, 161);
  Color foregroundBlue = const Color.fromARGB(255, 152, 179, 255);
  Color darkBlue = const Color.fromARGB(255, 3, 24, 85);
  Color lightBlue = const Color.fromARGB(255, 34, 123, 255);
  Color purple = const Color.fromARGB(255, 234, 7, 255);
  Color grey = const Color.fromARGB(255, 70, 89, 140);
}
