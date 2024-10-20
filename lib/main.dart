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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.green,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          color: Colors.green,
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
        title: const Text('لحظات ذكر',style: TextStyle(
          fontFamily: 'Tajawal',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(child: IconGrid()),
        ],
      ),
    );
  }
}

class IconGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      children: [
        _buildIconWithText(context, Icons.menu_book, "قران", QuranView()),
        _buildIconWithText(context, Icons.loop, "اذكار", AzkarScreen()),
        _buildIconWithText(context, Icons.favorite, "سبحة", TasbihPage()),
        _buildIconWithText(context, Icons.star, "اسماء الله", NamesOfAllahPage()),
        _buildIconWithText(context, Icons.explore, "القبلة", QiblaPage()),
         _buildIconWithText(context, Icons.track_changes, "Tracker", HabitTrackerHome()),
      ],
    );
  }

  Widget _buildIconWithText(
      BuildContext context, IconData icon, String title, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40.0, color: Colors.green),
          SizedBox(height: 5),
          Text(title, style: TextStyle(
            fontFamily: 'Tajawal',
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ) ,),
        ],
      ),
    );
  }
}
