import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DayAndDateWidget extends StatefulWidget {
  @override
  _DayAndDateWidgetState createState() => _DayAndDateWidgetState();
}

class _DayAndDateWidgetState extends State<DayAndDateWidget> {
  late DateTime _currentDate;

  @override
  void initState() {
    super.initState();
    _currentDate = DateTime.now();
  }

  void _updateDate() {
    setState(() {
      _currentDate = DateTime.now();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String day=DateFormat('EEEE, MMMM d, y').format(_currentDate).split(',')[0];
    String formattedDate = DateFormat('EEEE, MMMM d, y').format(_currentDate).split(',')[1];
    return Text(
      day+" |"+
      formattedDate,
      style: TextStyle(fontSize:20),
    );
  }
}
