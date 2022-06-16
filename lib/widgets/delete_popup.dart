import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../helper/note_provider.dart';
import '../models/note.dart';
import '../screens/note_list_screen.dart';

class DeletePopUp extends StatelessWidget {
  final Note selectedNote;

  DeletePopUp(this.selectedNote);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      title: const Text('Delete?'),
      content: const Text('Do you want to delete the note?'),
      actions: [
        TextButton(
          child: const Text('Yes'),
          onPressed: () {
            Provider.of<NoteProvider>(context, listen: false)
                .deleteNote(selectedNote.id);
            // Navigator.popUntil(context, ModalRoute.withName(NoteListScreen.route));
            Navigator.of(context)
                .pushReplacementNamed(NoteListScreen.route);
          },
        ),
        TextButton(
          child: const Text('No'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
