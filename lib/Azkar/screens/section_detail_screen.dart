import 'package:flutter/material.dart';
import 'dart:convert';
import '../models/section_detail_model.dart';

class SectionDetailScreen extends StatefulWidget {
  final int id;
  final String title;

  const SectionDetailScreen({
    Key? key,
    required this.id,
    required this.title,
  }) : super(key: key);

  @override
  _SectionDetailScreenState createState() => _SectionDetailScreenState();
}

class _SectionDetailScreenState extends State<SectionDetailScreen> {
  List<SectionDetailModel> sectionDetails = [];
  bool isLoading = true; // Indicator for loading state
  String? errorMessage; // Store error message if any
  final ScrollController _scrollController = ScrollController();
  bool _showScrollToTopButton = false; // Controls visibility of "Scroll to Top" button

  @override
  void initState() {
    super.initState();
    loadSectionDetail();

    // Listen to scroll events
    _scrollController.addListener(() {
      if (_scrollController.offset >= 400) {
        // Show the button when scrolled down by 400px
        setState(() {
          _showScrollToTopButton = true;
        });
      } else {
        setState(() {
          _showScrollToTopButton = false;
        });
      }
    });
  }

  @override
  void dispose() {
    // Dispose the ScrollController when done
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator()) // Show loader while fetching data
          : errorMessage != null
          ? Center(
        child: Text(
          errorMessage!,
          style: const TextStyle(color: Colors.red, fontSize: 18),
          textAlign: TextAlign.center,
        ),
      )
          : sectionDetails.isEmpty
          ? const Center(
        child: Text(
          "No details available.",
          style: TextStyle(fontSize: 18),
        ),
      )
          : Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.separated(
          controller: _scrollController, // Attach ScrollController here
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return buildDetailTile(sectionDetails[index]);
          },
          separatorBuilder: (context, index) => Divider(
            height: 1,
            color: Colors.grey.withOpacity(0.8),
          ),
          itemCount: sectionDetails.length,
        ),
      ),
      floatingActionButton: _showScrollToTopButton
          ? FloatingActionButton(
        onPressed: _scrollToTop,
        child: const Icon(Icons.arrow_upward),
      )
          : null,
    );
  }

  Widget buildDetailTile(SectionDetailModel detail) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: ListTile(
        title: Text(
          detail.reference ?? '',
          textDirection: TextDirection.rtl,
          style: TextStyle(color: Colors.black),
        ),
        subtitle: Text(
          detail.content ?? '',
          textDirection: TextDirection.rtl,
          style: const TextStyle(fontSize: 20,color: Colors.black),
        ),
      ),
    );
  }

  // Function to load section details from the JSON
  Future<void> loadSectionDetail() async {
    try {
      final data = await DefaultAssetBundle.of(context)
          .loadString("assets/database/section_detail_db.json");
      final List<dynamic> response = json.decode(data);

      setState(() {
        sectionDetails = response
            .map((item) => SectionDetailModel.fromJson(item))
            .where((detail) => detail.sectionId == widget.id)
            .toList();
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
        errorMessage = "Failed to load details. Please try again later.";
      });
      print("Error loading section details: $error");
    }
  }

  // Function to scroll to the top of the ListView
  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }
}
