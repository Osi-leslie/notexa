import 'package:flutter/material.dart';
import '../models/note_model.dart';
import '../screens/note_view.dart';

class NoteCard extends StatelessWidget {
  const NoteCard(
      {Key? key,
      required this.note,
      required this.index,
      required this.onNoteDeleted})
      : super(key: key);

  final Note note;
  final int index;
  final Function(int) onNoteDeleted;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => NoteView(
                    note: note,
                    index: index,
                    onNoteDeleted: onNoteDeleted,
                  )),
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.title,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                note.body,
                style: const TextStyle(fontSize: 16),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
