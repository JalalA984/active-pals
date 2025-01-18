import 'dart:developer';

import 'package:active_pals/models/user_model.dart';
import 'package:active_pals/screens/services/database.dart';
import 'package:active_pals/widgets/constants.dart';
import 'package:active_pals/widgets/loading.dart';
import 'package:active_pals/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> workoutTypes = [
    "Cardio",
    "Yoga",
    "Weightlifting",
    "Pilates",
    "Meditation",
    "Martial Arts"
  ];

  String _currentName = "";
  String _currentWorkout = "Cardio"; // Default value
  int _currentIntensity = 100; // Default value

  @override
  Widget build(BuildContext context) {
    final theUser = Provider.of<UserModel?>(context);

    return StreamBuilder<UserDataModel>(
      stream: DatabaseService(uid: theUser!.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserDataModel? userData = snapshot.data;

          // Initialize _current values based on userData
          _currentName = _currentName.isEmpty ? userData!.name : _currentName;
          _currentWorkout =
              _currentWorkout.isEmpty ? userData!.workout : _currentWorkout;
          _currentIntensity = _currentIntensity == 100
              ? userData!.intensity
              : _currentIntensity;

          return Form(
            key: _formKey,
            child: Column(
              children: [
                const Text(
                  "Update your exercise preferences",
                  style: TextStyle(fontSize: 18.0),
                ),
                const SizedBox(height: 20.0),

                // Name input field
                TextFormField(
                  initialValue: userData?.name,
                  decoration:
                      textInputDecoration.copyWith(hintText: "Your name"),
                  validator: (val) =>
                      val!.isEmpty ? "Please enter a name" : null,
                  onChanged: (val) {
                    setState(() => _currentName = val);
                  },
                ),
                const SizedBox(height: 20.0),

                // Dropdown for workout type
                DropdownButtonFormField<String>(
                  items: workoutTypes.map((workout) {
                    return DropdownMenuItem<String>(
                      value: workout,
                      child: Text(workout),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() => _currentWorkout = value!);
                  },
                  decoration: const InputDecoration(
                    labelText: "Workout Preference",
                    border: OutlineInputBorder(),
                  ),
                  value: workoutTypes.contains(userData!.workout)
                      ? userData.workout
                      : workoutTypes[0], // Fallback to default
                ),
                const SizedBox(height: 20.0),

                // Slider for intensity
                Slider(
                  min: 100,
                  max: 900,
                  divisions: 8,
                  value: _currentIntensity.toDouble(),
                  onChanged: (val) {
                    setState(() => _currentIntensity = val.round());
                  },
                  label: _currentIntensity.toString(),
                  activeColor: Colors.red[_currentIntensity],
                  inactiveColor: Colors.red[_currentIntensity],
                ),

                const SizedBox(height: 20.0),

                // Form button
                PrimaryButton(
                  text: "Update",
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      log("Name: $_currentName");
                      log("Workout: $_currentWorkout");
                      log("Intensity: $_currentIntensity");

                      // Call Firestore update method here if required
                      await DatabaseService(uid: theUser.uid).updateUserData(
                        _currentWorkout,
                        _currentName,
                        _currentIntensity,
                      );

                      // Close the bottom sheet
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          );
        } else {
          return const Loading();
        }
      },
    );
  }
}
