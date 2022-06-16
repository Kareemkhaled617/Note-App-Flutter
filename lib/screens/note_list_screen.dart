

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../helper/note_provider.dart';
import '../utils/constants.dart';
import '../widgets/dismissible_widget.dart';
import '../widgets/list_item.dart';
import 'note_edit_screen.dart';

class NoteListScreen extends StatelessWidget {
  static const route = '/note-list';


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<NoteProvider>(context, listen: false).getNotes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              body: Consumer<NoteProvider>(
                child: noNotesUI(context),
                builder: (context, noteprovider, child) =>
                noteprovider.items.length <= 0
                    ? child
                    : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: noteprovider.items.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return header();
                    } else {
                      final i = index - 1;
                      final item = noteprovider.items[i];
                      return DismissibleWidget(
                        item: noteprovider.items,
                        child: ListItem(
                          item.id,
                          item.title,
                          item.content,
                          item.imagePath,
                          item.date,
                        ),
                        onDismissed: (DismissDirection direction) {
                          Provider.of<NoteProvider>(context, listen: false)
                              .deleteNote(item.id);
                        },
                      );
                    }
                  },
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  goToNoteEditScreen(context);
                },
                child: const Icon(Icons.add),
              ),
            );
          }
        }
        return Container();
      },
    );
  }

  Widget header() {
    return Container(
      decoration: const BoxDecoration(
        color: headerColor,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(75.0),
        ),
      ),
      height: 150.0,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Notes',
            style: headerNotesStyle,
          )
        ],
      ),
    );
  }



  Widget noNotesUI(BuildContext context) {
    return ListView(
      children: [
        header(),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Image.asset(
                'crying_emoji.png',
                fit: BoxFit.cover,
                width: 200.0,
                height: 200.0,
              ),
            ),
            RichText(
              text: TextSpan(style: noNotesStyle, children: [
                const TextSpan(text: ' There is no note available\n Tap on "'),
                TextSpan(
                    text: '+',
                    style: boldPlus,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        goToNoteEditScreen(context);
                      }),
                const TextSpan(text: '" to add new note')
              ]),
            ),
          ],
        ),
      ],
    );
  }

  void goToNoteEditScreen(BuildContext context) {
    Navigator.of(context).pushNamed(NoteEditScreen.route);
  }
}
