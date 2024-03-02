import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NoteList extends StatefulWidget {
  @override
  _NoteListState createState() => _NoteListState();
}

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addNote(String note) async {
    await _firestore.collection('notes').add({'note': note});
  }

  Stream<List<String>> getNotes() {
    return _firestore.collection('notes').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        if (doc.data() != null && doc.data()!.containsKey('note')) {
          return doc.data()!['note'].toString();
        } else {
          return '';
        }
      }).toList();
    });
  }
}

class _NoteListState extends State<NoteList> {
  final FirebaseService _firebaseService = FirebaseService();
  List<String> _enteredNotes = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey[900],
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.purple,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            _shownote(context);
          },
        ),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            'Notes',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.purple,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Expanded(
              child: StreamBuilder<List<String>>(
                stream: _firebaseService.getNotes(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  _enteredNotes = snapshot.data!;
                  return ListView.builder(
                    itemCount: _enteredNotes.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                        child: ListTile(
                          title: Text(_enteredNotes[index]),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _shownote(BuildContext context) async {
    TextEditingController _save = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Take Your Notes'),
          content: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              hintText: 'Take Note',
            ),
            controller: _save,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await _firebaseService.addNote(_save.text);
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
