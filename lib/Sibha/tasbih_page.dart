
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class TasbihPage extends StatefulWidget {
  @override
  _TasbihPageState createState() => _TasbihPageState();
}

class _TasbihPageState extends State<TasbihPage> {
  int _counter = 0;
  int _completedCounts = 0; // Secondary counter
  int _selectedCount = 33; // Default selected count

  void _incrementCounter() {
    setState(() {
      if (_counter < _selectedCount) {
        _counter++;
      } else {
        // Reset the counter and increment completed counts
        _counter = 0;
        _completedCounts++;
        Fluttertoast.showToast(
          msg: "Completed $_selectedCount counts!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      }
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("سبحه",style:TextStyle(
          fontFamily: 'Tajawal',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ) ,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'العداد',
                style: TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
              SizedBox(height: 10),
              // Custom Dropdown Button
              GestureDetector(
                onTap: () {
                  // Show a dialog to select count
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('اختيار العدد'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              title: Text('33', style: TextStyle(color: Colors.green)),
                              onTap: () {
                                setState(() {
                                  _selectedCount = 33;
                                  _counter = 0; // Reset counter when count is changed
                                });
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              title: Text('99', style: TextStyle(color: Colors.green)),
                              onTap: () {
                                setState(() {
                                  _selectedCount = 99;
                                  _counter = 0; // Reset counter when count is changed
                                });
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'العدد: $_selectedCount',
                    style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              CircularPercentIndicator(
                radius: 150.0,
                lineWidth: 13.0,
                animation: true,
                percent: _counter <= _selectedCount ? _counter / _selectedCount : 1.0,
                center: Text(
                  '$_counter',
                  style: TextStyle(
                    fontSize: 48.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                progressColor: Colors.white,
                backgroundColor: Colors.green.shade700,
                circularStrokeCap: CircularStrokeCap.round,
              ),
              SizedBox(height: 10),
              Text(
                'المكتمل: $_completedCounts',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _incrementCounter,
                    child: Text('+', style: TextStyle(fontSize: 24)),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      backgroundColor: Colors.green,
                    ),
                  ),
                  SizedBox(width: 14),
                  ElevatedButton(
                    onPressed: _resetCounter,
                    child: Text('اعادة', style: TextStyle(fontSize: 20)),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      backgroundColor: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
