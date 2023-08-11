import 'package:flutter/material.dart';
import '../models/sql_helper.dart';
import 'create_note.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> notes = [];

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  bool isLoading = true;

  void refreshNoteList() async {
    final data = await SQLHelper.getItems();
    setState(() {
      notes = data;
      isLoading = true;
    });
  }

  @override
  void initState() {
    super.initState();

    refreshNoteList();
    print('TOTAL NUMBER OF ITEMS: ${notes.length}');
  }

  void showForm(int? id) async {
    if (id != null) {
      final existingNotes = notes.firstWhere((element) => element['id'] == id);
      titleController.text = existingNotes['title'];
      descriptionController.text = existingNotes['description'];
    } else {
      titleController.text = '';
      descriptionController.text = '';
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CreateNote(
          titleController: titleController,
          descriptionController: descriptionController,
          id: id,
          function: refreshNoteList,
        ),
      ),
    );
    print('Form ID: $id');
    print('TOTAL NUMBER OF ITEMS: ${notes.length}');
  }

  Future<void> deleteItem(int id) async {
    await SQLHelper.deleteItem(id);
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Successfully deleted item')));
    refreshNoteList();
    print('Item Deleted!');
  }

  void saveNote(int? id) async {}

  //List<Note> notes = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Notex'),
      ),
      body: notes == List.empty()
          ? const Center(
              child: Text(
                'Empty List',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.only(top: 16.0, bottom: 32),
              itemCount: notes.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    showForm(notes[index]['id']);
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.blueAccent,
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width / 1.5,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    notes[index]['title'],
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    notes[index]['description'],
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.grey),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                deleteItem(notes[index]['id']);
                              },
                              icon: const Icon(
                                Icons.delete,
                              ))
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showForm(null),
        backgroundColor: Colors.amber,
        label: const Text('Create Note'),
      ),
    );
  }
}
