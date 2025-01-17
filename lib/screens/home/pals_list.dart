import 'dart:developer';

import 'package:active_pals/models/Pal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PalsList extends StatefulWidget {
  const PalsList({super.key});

  @override
  State<PalsList> createState() => _PalsListState();
}

class _PalsListState extends State<PalsList> {
  @override
  Widget build(BuildContext context) {
    final pals = Provider.of<List<Pal>?>(context); // Safely handle nullable value

    if (pals == null || pals.isEmpty) {
      log("No pals available or data is still loading.");
      return const Center(
        child: Text(
          "No pals to display.",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      );
    }

    pals.forEach((pal) {
      log("Name: ${pal.name}");
      log("Workout: ${pal.workout}");
      log("Intensity: ${pal.intensity}");
    });

    return ListView.builder(
      itemCount: pals.length,
      itemBuilder: (context, index) {
        final pal = pals[index];
        return ListTile(
          title: Text(pal.name),
          subtitle: Text("Workout: ${pal.workout}, Intensity: ${pal.intensity}"),
        );
      },
    );
  }
}
