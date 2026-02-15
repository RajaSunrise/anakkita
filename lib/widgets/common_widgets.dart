import 'package:flutter/material.dart';

class StatusBar extends StatelessWidget {
  final bool light;
  const StatusBar({super.key, this.light = false});

  @override
  Widget build(BuildContext context) {
    final color = light ? Colors.white : Theme.of(context).colorScheme.onSurface;
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '9:41',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
          Row(
            children: [
              Icon(Icons.signal_cellular_alt, size: 18, color: color),
              const SizedBox(width: 6),
              Icon(Icons.wifi, size: 18, color: color),
              const SizedBox(width: 6),
              Icon(Icons.battery_full, size: 18, color: color),
            ],
          ),
        ],
      ),
    );
  }
}

class HomeIndicator extends StatelessWidget {
  final Color? color;
  const HomeIndicator({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        width: 128,
        height: 6,
        decoration: BoxDecoration(
          color: color ?? Theme.of(context).dividerColor,
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  final String active;
  const BottomNavBar({super.key, required this.active});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final activeColor = theme.primaryColor;
    final inactiveColor = Colors.grey[400];

    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor.withOpacity(0.8),
        border: Border(top: BorderSide(color: theme.dividerColor)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildNavItem(context, 'dashboard', Icons.dashboard, 'Usage', active == 'usage', activeColor, inactiveColor),
          _buildNavItem(context, 'limits', Icons.security, 'Controls', active == 'controls', activeColor, inactiveColor),
          _buildNavItem(context, 'rewards', Icons.emoji_events, 'Rewards', active == 'rewards', activeColor, inactiveColor),
          _buildNavItem(context, 'settings', Icons.settings, 'Settings', active == 'settings', activeColor, inactiveColor),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, String route, IconData icon, String label, bool isActive, Color activeColor, Color? inactiveColor) {
    return InkWell(
      onTap: () {
        if (!isActive) {
          Navigator.pushReplacementNamed(context, '/$route');
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: isActive ? activeColor : inactiveColor),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: isActive ? activeColor : inactiveColor,
            ),
          ),
        ],
      ),
    );
  }
}
