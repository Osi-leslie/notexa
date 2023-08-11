import 'package:flutter/material.dart';

import '../models/sql_helper.dart';
import 'home_screen.dart';

class CreateNote extends StatefulWidget {
  const CreateNote({
    Key? key,
    required this.titleController,
    required this.descriptionController,
    required this.id,
    required this.function,
  }) : super(key: key);

  //final Function(Note) onNewNoteCreated;
  final int? id;
  final Function function;

  //final titleController;
  //final descriptionController;

  final TextEditingController titleController;
  final TextEditingController descriptionController;

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  Future<void> addItem() async {
    await SQLHelper.createItem(
        widget.titleController.text, widget.descriptionController.text);
    widget.function;
    print('Item Added!');
  }

  Future<void> updateItem(int id) async {
    await SQLHelper.updateItem(
        id, widget.titleController.text, widget.descriptionController.text);
    widget.function;
    print('Item Updated!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.id == null ? 'Create Note' : 'Edit Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
        child: Column(
          children: [
            //TITLE TEXT
            TextFormField(
              controller: widget.titleController,
              style: const TextStyle(
                fontSize: 28.0,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Note Title',
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            //BODY TEXT
            TextFormField(
              controller: widget.descriptionController,
              style: const TextStyle(
                fontSize: 18.0,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Description',
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          if (widget.id == null) {
            await addItem();
          }
          if (widget.id != null) {
            await updateItem(widget.id!);
          }

          widget.titleController.text = '';
          widget.descriptionController.text = '';

          // ignore: use_build_context_synchronously
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const HomeScreen()));
          widget.function;
          print('NOTE SAVED!!!');
        },
        backgroundColor: Colors.amber,
        label: Text(widget.id == null ? 'Save Note' : 'Update Note'),
      ),
    );
  }
}
