

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:la7azat_zekr_v3/Azkar/screens/section_detail_screen.dart';

import '../models/section_model.dart';

class AzkarScreen extends StatefulWidget {
  const AzkarScreen({super.key});

  @override
  _AzkarScreenState createState() => _AzkarScreenState();
}

class _AzkarScreenState extends State<AzkarScreen> {
  List<SectionModel> sections = [];

  @override
  void initState() {
    super.initState();
    loadSections();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          "أذكار المسلم",
          style: TextStyle(
            fontFamily: 'Tajawal',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        elevation: 5,
      ),
      body: sections.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: sections.length,
          itemBuilder: (context, index) {
            return buildSectionCard(sections[index]);
          },
        ),
      ),
    );
  }

  Widget buildSectionCard(SectionModel section) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: InkWell(
        onTap: () {
          // Navigate to the SectionDetailScreen
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => SectionDetailScreen(
                id: section.id!,
                title: section.name!,
              ),
            ),
          );
        },
        splashColor: Colors.lightBlueAccent.withOpacity(0.3),
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Colors.green, Colors.lightBlueAccent],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.menu_book,
                size: 40,
                color: Colors.black,
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  section.name!,
                  style: const TextStyle(
                    fontFamily: 'Tajawal',
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> loadSections() async {
    try {
      String data = await DefaultAssetBundle.of(context)
          .loadString("assets/database/section_db.json");
      var response = json.decode(data);

      if (response is List) {
        sections = response
            .map((section) => SectionModel.fromJson(section))
            .toList();
      }

      setState(() {});
    } catch (error) {
      print("Error loading sections: $error");
    }
  }
}
