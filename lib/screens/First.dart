import 'package:flutter/material.dart';
import 'package:note_project/screens/setting.dart';

import '../widgets/button.dart';
import 'note_edit_screen.dart';
import 'note_list_screen2.dart';

class FirstScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Screen'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MyButton(
              color:Theme.of(context).primaryColor,
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => NoteEditScreen()));
              },
              title: 'ADD',
              color1:Theme.of(context).shadowColor,
            ),
            MyButton(
              color: Theme.of(context).primaryColor,
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => NoteListScreen2()));
              },
              title: 'VIEW',
              color1: Theme.of(context).shadowColor,
            ),
            MyButton(
              color: Theme.of(context).primaryColor,
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Setting()));
              },
              title: 'SETTING',
              color1:Theme.of(context).shadowColor,
            ),

          ],
        ),
      ),
    );

}

}
