import 'package:flutter/material.dart';

class CustomTimeOfDay extends TimeOfDay {
  const CustomTimeOfDay({hour, minute})
      : super(
          hour: hour,
          minute: minute,
        );

  factory CustomTimeOfDay.fromJson(Map<String, dynamic>? json) {
    final hour = json!['hour'];
    final minute = json['minute'];
    return CustomTimeOfDay(hour: hour, minute: minute);
  }

  factory CustomTimeOfDay.now() {
    var time = DateTime.now();
    return CustomTimeOfDay(hour: time.hour, minute: time.minute);
  }

  Map<String, dynamic> toJson() => {'hour': hour, 'minute': minute};

  @override
  String toString() {
    return '${getConvertedTime(hour)}:${getConvertedTime(minute)}';
  }

  String getConvertedTime(int time) {
    if (time < 10) {
      return '0$time';
    } else {
      return '$time';
    }
  }
}
