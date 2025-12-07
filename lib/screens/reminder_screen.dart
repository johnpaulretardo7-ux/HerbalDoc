
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/services/notification_service.dart';

class ReminderScreen extends StatefulWidget {
  final String herbName;

  const ReminderScreen({super.key, required this.herbName});

  @override
  State<ReminderScreen> createState() => ReminderScreenState();
}

class ReminderScreenState extends State<ReminderScreen> {
  TimeOfDay? _selectedTime;
  final NotificationService _notificationService = NotificationService();

  void _selectTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  void _setReminder() {
    if (_selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a time first.')),
      );
      return;
    }

    final now = DateTime.now();
    final scheduledDate = DateTime(
      now.year,
      now.month,
      now.day,
      _selectedTime!.hour,
      _selectedTime!.minute,
    );

    final reminderId = widget.herbName.hashCode;

    _notificationService.scheduleNotification(
      id: reminderId,
      title: 'Time for your ${widget.herbName}!',
      body: 'It\'s time to take your herbal medicine.',
      scheduledTime: scheduledDate.isBefore(now) 
          ? scheduledDate.add(const Duration(days: 1)) 
          : scheduledDate, 
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Reminder set for ${DateFormat.jm().format(scheduledDate)} every day.')),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set Reminder for ${widget.herbName}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _selectedTime == null
                  ? 'No time selected'
                  : 'Reminder will be set at: ${DateFormat.jm().format(DateTime(0, 0, 0, _selectedTime!.hour, _selectedTime!.minute))}',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: _selectTime,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                textStyle: const TextStyle(fontSize: 18),
              ),
              icon: const Icon(Icons.alarm),
              label: const Text('Select Time'),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: _setReminder,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              child: const Text('Set Daily Reminder'),
            ),
          ],
        ),
      ),
    );
  }
}
