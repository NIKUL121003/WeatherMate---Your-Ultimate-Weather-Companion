import 'package:flutter/material.dart';

class HourlyForecastItem extends StatelessWidget {
  final String time;
  final String temperature;
  final IconData icon;
  final bool isDayTime;
  final bool isDarkMode;

  const HourlyForecastItem({
    super.key,
    required this.time,
    required this.temperature,
    required this.icon,
    required this.isDayTime,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    final timeColor = isDayTime
        ? (isDarkMode ? Colors.amber[200]! : Colors.orange[700]!)
        : (isDarkMode ? Colors.blue[200]! : Colors.blue[700]!);

    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            time,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: timeColor,
            ),
          ),
          const SizedBox(height: 8),
          Icon(icon, size: 30, color: timeColor),
          const SizedBox(height: 8),
          Text(
            temperature,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
