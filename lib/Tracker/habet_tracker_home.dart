import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'add_habit_dialog.dart';
import 'habit_list.dart';
import 'habit_model.dart';

class HabitTrackerHome extends StatefulWidget {
  @override
  _HabitTrackerHomeState createState() => _HabitTrackerHomeState();
}

class _HabitTrackerHomeState extends State<HabitTrackerHome> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  Map<DateTime, List<Habit>> habitHistory = {};

  List<Habit> _getHabitsForDay(DateTime day) {
    return habitHistory[day] ?? [];
  }

  void _addHabit(Habit habit) {
    setState(() {
      if (habitHistory[_selectedDay] == null) {
        habitHistory[_selectedDay] = [];
      }
      habitHistory[_selectedDay]!.add(habit);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Habit Tracker'),
      ),
      body: Column(
        children: [
          // Calendar widget
          TableCalendar(
            focusedDay: _focusedDay,
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            eventLoader: _getHabitsForDay,
          ),
          Expanded(
            child: HabitList(
              habits: _getHabitsForDay(_selectedDay),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddHabitDialog(context);
        },
        backgroundColor: Colors.green,
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddHabitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AddHabitDialog(onAdd: _addHabit);
      },
    );
  }
}
