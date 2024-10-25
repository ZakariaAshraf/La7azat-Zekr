import 'package:flutter/material.dart';
import 'package:la7azat_zekr_v3/names/names_page.dart';

import 'Azkar/screens/azkar_screen.dart';
import 'Qibla/qibla_page.dart';
import 'Quran/quran_view.dart';
import 'Sibha/tasbih_page.dart';
import 'Tracker/habet_tracker_home.dart';
import 'core/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.teal,
        scaffoldBackgroundColor: Colors.grey[900],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.teal,
          elevation: 5,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontFamily: 'Tajawal'),
        ),
      ),
      title: 'Islamic Prayer App',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'لحظات ذكر',
          style: TextStyle(
            fontFamily: 'Tajawal',
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Expanded(child: IconGrid()),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class IconGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.2,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        final iconData = [
          Icons.menu_book,
          Icons.loop,
          Icons.favorite,
          Icons.star,
          Icons.explore,
          Icons.track_changes,
        ];

        final titles = [
          "قران",
          "اذكار",
          "سبحة",
          "اسماء الله",
          "القبلة",
          "Tracker",
        ];

        final pages = [
          QuranView(),
          AzkarScreen(),
          TasbihPage(),
          NamesOfAllahPage(),
          QiblaPage(),
          HabitTrackerHome(),
        ];

        return _buildIconCard(
          context,
          iconData[index],
          titles[index],
          pages[index],
        );
      },
    );
  }

  Widget _buildIconCard(
      BuildContext context, IconData icon, String title, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Card(
        color: Colors.grey[850],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50.0, color: Colors.teal),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Tajawal',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}