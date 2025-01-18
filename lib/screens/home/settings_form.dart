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

  String _currentName = "";
  String _currentWorkout = "Cardio"; // Default value
  int _currentIntensity = 100; // Default value

  @override
  Widget build(BuildContext context) {
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
            decoration: textInputDecoration.copyWith(hintText: "Your name"),
            validator: (val) => val!.isEmpty ? "Please enter a name" : null,
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
            value: _currentWorkout,
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
              }
            },
          ),
        ],
      ),
    );
  }
}
