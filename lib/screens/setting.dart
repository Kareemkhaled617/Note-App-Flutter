import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:list_tile_switch/list_tile_switch.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Setting extends StatefulWidget {

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool val = false ;
 Future save_data(bool vall)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('status', vall);
  }
  Future get_data()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      val = prefs.getBool('status') ?? false;
    });
    return prefs.getBool('status');
  }

  @override
  void initState() {

      get_data();
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title:const Text('Setting'),
      ),
      body: Center(
        child: ListTileSwitch(
          value:val,
          leading: const Icon(Icons.lightbulb),
          onChanged: (value) {
            setState(() {
              val = value;
            });
            save_data(value);
            AwesomeDialog(
              context: context,
              dialogType: DialogType.INFO,
              animType: AnimType.BOTTOMSLIDE,
              title: 'Attend  !',
              desc: 'Restart your App to Apply Change',
              btnOkOnPress: () {},
            ).show();
          },
          visualDensity: VisualDensity.comfortable,
          switchActiveColor: Colors.indigo,
          title: const Text('Switch theme'),
        ),
      ),
    );
  }
}
