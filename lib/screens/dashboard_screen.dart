import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:anak_kita_app/providers/app_state.dart';
import 'package:anak_kita_app/widgets/common_widgets.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appState = context.watch<AppState>();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const StatusBar(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Anak Kita',
                        style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'PARENTAL DASHBOARD',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: Colors.grey,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () => Navigator.pushNamed(context, '/activity'),
                    child: Stack(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: theme.primaryColor, width: 2),
                            image: const DecorationImage(
                              image: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuCeYynscrjj5dCMOG_y4IRi8gyQZekmodQ-2oTK-FiaKU0eNwgqA52kxJ-58Gy6U1jJS6aWUi1pjcDSppIFxVrtDGNIL2W2olOpp456_AfqLcYvaGRjI0pa5R6fMrY-Ytjv1zwDrdkf1r_OQ7w8VCmcRe1o7AMSDjv1IAM_Pi6Ziy3jx275lKnSLWt4t-RenBeqD1zD78V5YlQKjyoE0KdNK6rHMGQ7d9OotIx_kDNWTxqL57A89HxscgF_4WWb5OV2IS4-x-xjX0I'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.expand_more, size: 12, color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    // Tabs
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceVariant.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          _buildTab(context, 'Daily', true),
                          _buildTab(context, 'Weekly', false),
                          _buildTab(context, 'Monthly', false),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Circular Chart
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 180,
                            height: 180,
                            child: CircularProgressIndicator(
                              value: 1.0,
                              strokeWidth: 20,
                              valueColor: AlwaysStoppedAnimation<Color>(theme.dividerColor.withOpacity(0.1)),
                            ),
                          ),
                          SizedBox(
                            width: 180,
                            height: 180,
                            child: CircularProgressIndicator(
                              value: (appState.usageSecondsToday / appState.dailyLimitSeconds).clamp(0.0, 1.0),
                              strokeWidth: 20,
                              valueColor: AlwaysStoppedAnimation<Color>(theme.primaryColor),
                              strokeCap: StrokeCap.round,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                appState.formattedUsage,
                                style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'of ${appState.formattedLimit} limit',
                                style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Stats Grid
                    Row(
                      children: [
                        Expanded(child: _buildStatCard(context, Icons.history, 'AVG USAGE', '4h 12m')),
                        const SizedBox(width: 16),
                        Expanded(child: _buildStatCard(context, Icons.phonelink_lock, 'PICKUPS', '42 times')),
                      ],
                    ),
                    const SizedBox(height: 32),
                    // App Breakdown
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('App Breakdown', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                        TextButton(
                          onPressed: () => Navigator.pushNamed(context, '/activity'),
                          child: const Text('View All'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildAppItem(context, 'TikTok', '1h 30m', Colors.pink, Icons.music_note, 0.45),
                    _buildAppItem(context, 'YouTube', '1h 15m', Colors.red, Icons.play_arrow, 0.35),
                    _buildAppItem(context, 'Instagram', '1h 00m', Colors.purple, Icons.camera_alt, 0.30),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: () => Navigator.pushNamed(context, '/limits'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.timer),
                          SizedBox(width: 8),
                          Text('Adjust Screen Time Limits'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 100), // Spacing for navbar
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(active: 'usage'),
    );
  }

  Widget _buildTab(BuildContext context, String text, bool active) {
    final theme = Theme.of(context);
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: active ? BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 2),
          ],
        ) : null,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: active ? FontWeight.bold : FontWeight.w500,
            color: active ? theme.colorScheme.onSurface : Colors.grey,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, IconData icon, String label, String value) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: theme.primaryColor),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: theme.primaryColor),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildAppItem(BuildContext context, String name, String time, Color color, IconData icon, double percentage) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.dividerColor.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(time, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: percentage,
                  backgroundColor: theme.dividerColor.withOpacity(0.1),
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
