import 'package:flutter/material.dart';
import '../../models/notifications/ad_notification.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _sampleNotifications.length,
        itemBuilder: (context, index) {
          final notification = _sampleNotifications[index];
          return Card(
            elevation: 4, // Increase elevation for a more prominent shadow
            shadowColor: Colors.black.withOpacity(0.8), // Slightly darker shadow
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.grey.shade100),
            ),
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row for label and date
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Status label and icon aligned to the left
                      Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: notification.status.color,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            notification.status.label,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: notification.status.labelColor,
                            ),
                          ),
                        ],
                      ),
                      // Date aligned to the right
                      Text(
                        notification.date,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Message
                  Text(
                    notification.message,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF2F2D2D)
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

final List<AdNotification> _sampleNotifications = [
  const AdNotification(
    id: '1', 
    message: 'Dont be alarmed, this is just here to fill up the space since your finalized copy isn\'t ready yet.',
    date: '30 mins. ago',
    status: NotificationStatus.reminder,
    campaignId: 'TRX-001',
  ),
  AdNotification(
    id: '2',
    message: 'Please complete the payment for your new campaign "Jeep Grand Cherokee Luxury Tour".',
    date: '1 hour ago',
    status: NotificationStatus.videoisrunning,
    campaignId: 'TRX-002',
    actionUrl: '/payment',
  ),
  AdNotification(
    id: '3',
    message: 'Your campaign "City Tours Promotion" has ended. View the performance report.',
    date: '10 hours ago',
    status: NotificationStatus.pendingPayment,
    campaignId: 'TRX-003',
  ),
  AdNotification(
    id: '4',
    message: 'Your new campaign "Weekend Special" is being reviewed by our team.',
    date: '2 days ago',
    status: NotificationStatus.pendingPayment,
    campaignId: 'TRX-004',
  ),
  AdNotification(
    id: '5',
    message: 'Your campaign "Night Drive" has been archived.',
    date: '3 days ago',
    status: NotificationStatus.videoisrunning,
    campaignId: 'TRX-005',
  ),
  AdNotification(
    id: '6',
    message: 'Your campaign "Night Drive" has been archived.',
    date: '4 days ago',
    status: NotificationStatus.videoisrunning,
    campaignId: 'TRX-005',
  ),
];
