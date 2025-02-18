// Timport 'package:flutter/material.dart';
import 'package:flutter/material.dart';

enum NotificationStatus {
  reminder,
  videoisrunning,
  pendingPayment;

  Color get color {
    switch (this) {
      case NotificationStatus.reminder:
        return Colors.black;
      case NotificationStatus.videoisrunning:
        return Colors.green;
      case NotificationStatus.pendingPayment:
        return Colors.yellow;
    }
  }

  Color get labelColor {
    switch (this) {
      case NotificationStatus.reminder:
        return const Color.fromARGB(255, 0, 0, 0); // Darker blue for better readability
      case NotificationStatus.videoisrunning:
        return const Color(0xFF34A853); // Darker green for better readability
      case NotificationStatus.pendingPayment:
        return const Color(0xFFE37400); // Orange for better readability than yellow
    }
  }

  Color get backgroundColor {
    return color.withOpacity(0.1); // Light background based on status color
  }

  String get label {
    switch (this) {
      case NotificationStatus.reminder:
        return 'Reminder!';
      case NotificationStatus.videoisrunning:
        return 'Video is Running';
      case NotificationStatus.pendingPayment:
        return 'Pending Payment';
    }
  }
}

class AdNotification {
  final String id;
  //final String title;
  final String message;
  final String date;
  final NotificationStatus status;
  final String? campaignId;
  final String? actionUrl;

  const AdNotification({
    required this.id,
    //required this.title,
    required this.message,
    required this.date,
    required this.status,
    this.campaignId,
    this.actionUrl,
  });
}