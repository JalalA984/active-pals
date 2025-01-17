import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
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
    final preferences = Provider.of<QuerySnapshot?>(context); // Make nullable

    if (preferences == null) {
      log("Preferences are null");
      return const Center(child: CircularProgressIndicator());
    }

    for (var doc in preferences.docs) {
      final data = doc.data() as Map<String, dynamic>; // Safely cast to a Map
      log("Document: ${data.toString()}");
    }

    return const Placeholder();
  }
}