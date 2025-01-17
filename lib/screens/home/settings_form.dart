import 'dart:developer';

import 'package:active_pals/widgets/constants.dart';
import 'package:active_pals/widgets/primary_button.dart';
import 'package:flutter/material.dart';

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

  late String _currentName;
  late String _currentWorkout;
  late int _currentIntensity;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text(
            "Update your exercise preferences",
            style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(
            height: 20.0,
          ),
          TextFormField(
            decoration: textInputDecoration.copyWith(hintText: "Your name"),
            validator: (val) => val!.isEmpty ? "Please enter a name" : null,
            onChanged: (val) {
              setState(() => _currentName = val);
            },
          ),
          SizedBox(
            height: 20.0,
          ),

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
            value: workoutTypes.isNotEmpty ? workoutTypes[0] : "Cardio",
          ),
          SizedBox(
            height: 20.0,
          ),

          // Slider for intensity

          SizedBox(
            height: 20.0,
          ),

          // Form button
          PrimaryButton(
              text: "Update",
              onPressed: () async {
                log(_currentName);
                log(_currentWorkout);
              })
        ],
      ),
    );
  }
}
