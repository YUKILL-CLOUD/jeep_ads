import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../models/notifications/ad_campaign.dart';

class AdStatisticsScreen extends StatelessWidget {
  final AdCampaign campaign;

  const AdStatisticsScreen({
    super.key,
    required this.campaign,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFFFA500)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Ad Statistics',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 42, right: 42, top: 42),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Campaign Preview
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(campaign.thumbnailUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              
              // Campaign Title
              Text(
                campaign.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),

              // Statistics Cards
              _buildStatisticsCard(
                title: 'Total Plays',
                value: '1,234', // Replace with actual data
                icon: Icons.play_circle_outline,
                color: const Color(0xFFFFA500),
              ),
              const SizedBox(height: 16),
              _buildStatisticsCard(
                title: 'Average Daily Plays',
                value: '123', // Replace with actual data
                icon: Icons.bar_chart,
                color: const Color(0xFF4CAF50),
              ),
              const SizedBox(height: 16),
              _buildStatisticsCard(
                title: 'Days Remaining',
                value: '15 days', // Calculate from campaign duration
                icon: Icons.timer_outlined,
                color: const Color(0xFF2196F3),
              ),
              const SizedBox(height: 24),

              // Performance Graph
              const Text(
                'Performance Over Time',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildPerformanceGraph(),

              const SizedBox(height: 24),
              // Campaign Details
              _buildDetailItem('Campaign Status', campaign.status.label),
              _buildDetailItem('Start Date', campaign.dateRange.split(' - ')[0]),
              _buildDetailItem('End Date', campaign.dateRange.split(' - ')[1]),
              _buildDetailItem('Number of Units', campaign.units.toString()),
              _buildDetailItem('Duration', campaign.duration),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatisticsCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // Add this method to generate sample data
  List<FlSpot> _generateDailyData() {
    // Sample data for 7 days
    return [
      FlSpot(0, 120),
      FlSpot(1, 150),
      FlSpot(2, 180),
      FlSpot(3, 140),
      FlSpot(4, 200),
      FlSpot(5, 170),
      FlSpot(6, 190),
    ];
  }

  // Add this method to build the line chart
  Widget _buildPerformanceGraph() {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 50,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Colors.grey.withOpacity(0.1),
                strokeWidth: 1,
              );
            },
          ),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 22,
                getTitlesWidget: (value, meta) {
                  const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                  if (value >= 0 && value < days.length) {
                    return Text(
                      days[value.toInt()],
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    );
                  }
                  return const Text('');
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 35,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toInt().toString(),
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          minX: 0,
          maxX: 6,
          minY: 0,
          maxY: 250,
          lineBarsData: [
            LineChartBarData(
              spots: _generateDailyData(),
              isCurved: true,
              color: const Color(0xFFFFA500),
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) {
                  return FlDotCirclePainter(
                    radius: 4,
                    color: Colors.white,
                    strokeWidth: 2,
                    strokeColor: const Color(0xFFFFA500),
                  );
                },
              ),
              belowBarData: BarAreaData(
                show: true,
                color: const Color(0xFFFFA500).withOpacity(0.1),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 