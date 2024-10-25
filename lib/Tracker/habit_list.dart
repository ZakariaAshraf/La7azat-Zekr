import 'package:flutter/material.dart';
import 'habit_model.dart';

class HabitList extends StatefulWidget {
  final List<Habit> habits;
  final Function(Habit) onHabitDeleted;

  HabitList({required this.habits, required this.onHabitDeleted});

  @override
  State<HabitList> createState() => _HabitListState();
}

class _HabitListState extends State<HabitList> {
  late List<bool> checkList;

  @override
  void initState() {
    super.initState();
    checkList = List<bool>.generate(widget.habits.length, (_) => false);
  }

  @override
  void didUpdateWidget(HabitList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.habits.length != widget.habits.length) {
      checkList = List<bool>.generate(widget.habits.length, (_) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
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

        return Dismissible(
          key: Key(habit.name),
          background: Container(color: Colors.red),
          onDismissed: (direction) {
            widget.onHabitDeleted(habit);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${habit.name} deleted')),
            );
          },
          child: ListTile(
            title: Text(habit.name, style: TextStyle(color: Colors.white)),
            subtitle: LinearProgressIndicator(
              value: habit.goal > 0 ? habit.progress / habit.goal : 0.0,
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    setState(() {
                      widget.onHabitDeleted(habit); // Notify parent to delete
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${habit.name} deleted')),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}