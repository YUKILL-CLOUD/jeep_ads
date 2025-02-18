import 'package:flutter/material.dart';

enum AdStatus {
  closed,
  pendingPayment,
  rejected,
  running,
  processing;

  Color get color {
    switch (this) {
      case AdStatus.closed:
        return Colors.grey;
      case AdStatus.pendingPayment:
        return Colors.orange;
      case AdStatus.rejected:
        return Colors.red;
      case AdStatus.running:
        return Colors.green;
      case AdStatus.processing:
        return Colors.yellow;
    }
  }

  String get label {
    switch (this) {
      case AdStatus.closed:
        return 'Closed';
      case AdStatus.pendingPayment:
        return 'Pending Payment';
      case AdStatus.rejected:
        return 'Rejected';
      case AdStatus.running:
        return 'Running';
      case AdStatus.processing:
        return 'Processing';
    }
  }
}

class AdCampaign {
  final String id;
  final String title;
  final String thumbnailUrl;
  final AdStatus status;
  final String transactionId;
  final int units;
  final double budget;
  final String duration;
  final String dateRange;
  final int numberOfJeeps;
  final double subtotal;
  final double discount;
  final int months;

  const AdCampaign({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.status,
    required this.transactionId,
    required this.units,
    required this.budget,
    required this.duration,
    required this.dateRange,
    required this.numberOfJeeps,
    required this.subtotal,
    required this.discount,
    required this.months,
  });
} 