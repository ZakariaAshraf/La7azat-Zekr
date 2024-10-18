import 'package:flutter/material.dart';
import 'habit_model.dart';

class HabitList extends StatefulWidget {
  final List<Habit> habits;

  HabitList({required this.habits});

  @override
  State<HabitList> createState() => _HabitListState();
}

class _HabitListState extends State<HabitList> {
  late List<bool> checkList; // Declare checkList

  @override
  void initState() {
    super.initState();
    // Initialize checkList as an empty list
    checkList = List<bool>.generate(widget.habits.length, (_) => false);
  }

  @override
  void didUpdateWidget(HabitList oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update the checkList if the habits list changes
    if (oldWidget.habits.length != widget.habits.length) {
      checkList = List<bool>.generate(widget.habits.length, (_) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // If habits list is empty, return a message
    if (widget.habits.isEmpty) {
      return Center(
        child: Text(
          'No habits found',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      );
    }

    return ListView.builder(
      itemCount: widget.habits.length,
      itemBuilder: (context, index) {
        final habit = widget.habits[index];

        // Ensure checkList has the correct size
        // Use an if statement to prevent any range error
        if (index >= checkList.length) {
          checkList.add(false); // Dynamically extend checkList if necessary
        }

        return ListTile(
          title: Text(habit.name, style: TextStyle(color: Colors.white)),
          subtitle: LinearProgressIndicator(
            value: habit.goal > 0 ? habit.progress / habit.goal : 0.0,
            backgroundColor: Colors.grey,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
          ),
          trailing: IconButton(
            icon: Icon(
              checkList[index] ? Icons.check_circle : Icons.check_circle_outline,
              color: checkList[index] ? Colors.green : Colors.grey,
            ),
            onPressed: () {
              setState(() {
                // Only update habit progress if the check is currently false
                if (!checkList[index]) {
                  habit.progress = (habit.progress < habit.goal)
                      ? habit.progress + 1
                      : habit.goal;
                }

                // Check the habit if progress reaches the goal
                if (habit.progress >= habit.goal) {
                  checkList[index] = true; // Mark as checked
                }
              });
            },
          ),
        );
      },
    );
  }
}