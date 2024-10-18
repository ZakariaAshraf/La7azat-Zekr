
import 'package:adhan_dart/adhan_dart.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class QiblaPage extends StatefulWidget {
  @override
  _QiblaPageState createState() => _QiblaPageState();
}

class _QiblaPageState extends State<QiblaPage> {
  Position? _position;
  double? _qiblahDirection;

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, return an error or prompt user to enable.
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, return an error or prompt user to enable.
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are permanently denied, handle accordingly.
      return;
    }

    // When we reach here, permissions are granted and we can access the location.
    final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _position = position;
    });
    _calculateQiblahDirection();
  }

  void _calculateQiblahDirection() {
    if (_position != null) {
      try {
        final coordinates = Coordinates(_position!.latitude, _position!.longitude);
        // Calculate Qibla direction
        final qiblahDirection =  Qibla.qibla(coordinates);
        setState(() {
          _qiblahDirection = qiblahDirection;
        });
      } catch (e) {
        print('Error calculating Qibla direction: $e');
      }
    } else {
      print('Position is null');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('اتجاه القبلة'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'اتجاه القبلة: ${_qiblahDirection ?? 'غير معروف'}',
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _determinePosition,
              child: Text('احصل على اتجاه القبلة'),
            ),
          ],
        ),
      ),
    );
  }
}