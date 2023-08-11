import 'package:flutter/material.dart';

import '../models/note_model.dart';

class NoteView extends StatelessWidget {
  const NoteView({Key? key, required this.note, required this.index, required this.onNoteDeleted})
      : super(key: key);

  final Function(int) onNoteDeleted;

  final Note note;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Note View'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title,
              style: const TextStyle(fontSize: 26.0),
            ),

            const SizedBox(height: 10.0,),

            Text(
              note.body,
              style: const TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context, builder: (context){
            return AlertDialog(
              title: const Text('Delete'),
              content: const Text('Are you sure you want to delete this note?'),

              actions: [
                TextButton(onPressed: (){
                  Navigator.of(context).pop();
                  onNoteDeleted(index);
                }, child: const Text('DELETE'),),

                TextButton(onPressed: (){
                  Navigator.of(context).pop();
                }, child: const Text('CANCEL'),),
              ],
            );
          });
        },
        backgroundColor: Colors.amber,
        child: const Icon(Icons.delete),
      ),
    );
  }
}
