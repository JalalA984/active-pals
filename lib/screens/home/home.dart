import 'package:active_pals/models/Pal.dart';
import 'package:active_pals/screens/home/pals_list.dart';
import 'package:active_pals/screens/home/settings_form.dart';
import 'package:active_pals/screens/services/auth.dart';
import 'package:active_pals/screens/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();

    void _showSettingsPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: SettingsForm(),
        );
      });

    }

    return StreamProvider<List<Pal>?>.value(
      value: DatabaseService().preferences,
      initialData: null,
      child: Scaffold(
        appBar: AppBar(
          title: Text("ActivePals"),
          backgroundColor: Colors.blue[400],
          actions: [

          TextButton.icon(
                onPressed: () {
                  _showSettingsPanel();
                  
                },
                icon: const Icon(Icons.settings, color: Colors.black),
                label: const Text(
                  "Settings",
                  style: TextStyle(color: Colors.black),
                )),


            TextButton.icon(
                onPressed: () async {
                  await _auth.signOut();
                },
                icon: const Icon(Icons.person, color: Colors.black),
                label: const Text(
                  "Logout",
                  style: TextStyle(color: Colors.black),
                )),


      

          ],
        ),


        body: PalsList(

        ),
      
      
        
      ),
    );
  }
}

