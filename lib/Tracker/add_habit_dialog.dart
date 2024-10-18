import 'package:flutter/material.dart';
import 'habit_model.dart';

class AddHabitDialog extends StatelessWidget {
  final Function(Habit) onAdd;

  AddHabitDialog({required this.onAdd});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _goalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add New Habit'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Habit Name'),
          ),
          TextField(
            controller: _goalController,
            decoration: InputDecoration(labelText: 'Habit Goal'),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (_nameController.text.isNotEmpty &&
                _goalController.text.isNotEmpty) {
              final habit = Habit(
                name: _nameController.text,
                goal: int.parse(_goalController.text),
              );
              onAdd(habit);
              Navigator.of(context).pop();
            }
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}
