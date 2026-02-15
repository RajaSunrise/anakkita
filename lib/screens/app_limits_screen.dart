import 'package:flutter/material.dart';
import 'package:anak_kita_app/widgets/common_widgets.dart';

class AppLimitsScreen extends StatefulWidget {
  const AppLimitsScreen({super.key});

  @override
  State<AppLimitsScreen> createState() => _AppLimitsScreenState();
}

class _AppLimitsScreenState extends State<AppLimitsScreen> {
  // Mock data
  final List<Map<String, dynamic>> _apps = [
    {
      'name': 'TikTok',
      'time': '1h 30m',
      'checked': true,
      'color': Colors.black,
      'icon': Icons.tiktok, // Flutter doesn't have tiktok icon by default, using music_note
      'img': 'https://lh3.googleusercontent.com/aida-public/AB6AXuBXxSebLT8zR9hFhKqNHyQRpLC3xP81E8-nAVRNu4mOZlx9jyks6ngvIwap80yO09uUueDh3f8478k0TrvwQyx_QZGkjICH04TEmCc80forc3UGggEkT5Fmgllhlpi8eQowN7klwIF5crVPtGBNwiWnktz0RjbmBh-xvm3G7ym9-KAVoNMzxp5QGzxswrV0-1mYfjCb1pSBIrZRIPTDWjWPvIZ6L1VNE8XSJ-okMQSQlQbhP6Ti4kcqby7j3oIig0doCMJm7D_PbeE'
    },
    {
      'name': 'YouTube',
      'time': '2h 00m',
      'checked': true,
      'color': Colors.red,
      'icon': Icons.play_arrow,
      'img': 'https://lh3.googleusercontent.com/aida-public/AB6AXuCWrqVEitkfh41ciT__s46bAqRZ_i0mqNh7mDiGLyGn-efIT4EIAANlO4cILMcGz5d0lzTIYTXycAITY85WJ_K4YTopTOWPgdfylmJOaSiO44eXWllfpbrSpUDslRvMjz_1iSGI34WPwXa7nL2K8kMmoR5N2Jlhd5KXJQFxIL26-07g2LIUspn8OR3SOhsusLvapaCz9oLwpDRiWXcs_DO3ZqbmS5Gspf_xNY-zEPdT3mkZEunLnB7p958exDA1Ljb949JikGrADpM'
    },
    {
      'name': 'Instagram',
      'time': '45m',
      'checked': true,
      'color': Colors.purple,
      'icon': Icons.camera_alt,
      'img': 'https://lh3.googleusercontent.com/aida-public/AB6AXuBXVWQiP9Ruk98--BQxnZIXplSyEcpjcIlMAK6uE4OIHGcRsrFrioI7d8l0wh3wSVYxHJ3rqcAtdc5z9Nri2oTsO7tipy9erf6UtOu5qufe3NchOm5DIUCy_C4rMQRjQGbvNOO9lyZ0rCRFYe6aoUCBurblsATUXI7Tn1jpQNfdEcWQP4gp3_8RbWcT4meg6SDQj176lt0rVg4BityrG_d_nYsV_T14po_2Y-Y1lyRQvtgBC96aWlRQRzca42dNh2MQQxy4ihTMIjY'
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const StatusBar(),
            Expanded(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(24, 16, 24, 100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () => Navigator.pop(context),
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                width: 40,
                                height: 40,
                                alignment: Alignment.centerLeft,
                                child: Icon(Icons.arrow_back_ios, color: theme.primaryColor, size: 20),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Set App Limits',
                                textAlign: TextAlign.center,
                                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(width: 40),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Text('Anak Kita', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                        Text('Manage daily screen time for social apps.', style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey)),
                        const SizedBox(height: 16),
                        // Search Bar
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Search apps...',
                            prefixIcon: const Icon(Icons.search),
                            filled: true,
                            fillColor: theme.cardColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('SOCIAL MEDIA APPS', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 12)),
                            Text('3 Restricted', style: TextStyle(color: theme.primaryColor, fontWeight: FontWeight.bold, fontSize: 12)),
                          ],
                        ),
                        const SizedBox(height: 16),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _apps.length,
                          separatorBuilder: (context, index) => const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final app = _apps[index];
                            return Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: theme.cardColor,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: theme.dividerColor.withOpacity(0.1)),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 48,
                                    height: 48,
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: (app['color'] as Color).withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Image.network(app['img'], errorBuilder: (c,e,s) => Icon(Icons.apps, color: app['color'])),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(app['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                                        Text('Active: ${app['time']} / day', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Switch(
                                        value: app['checked'],
                                        onChanged: (val) {
                                          setState(() {
                                            app['checked'] = val;
                                          });
                                        },
                                        activeColor: theme.primaryColor,
                                      ),
                                      Text('SET LIMIT', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: theme.primaryColor)),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        InkWell(
                          onTap: () => Navigator.pushNamed(context, '/study-config'),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: theme.primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: theme.primaryColor.withOpacity(0.2)),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.auto_stories, color: theme.primaryColor),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Mode Belajar', style: TextStyle(fontWeight: FontWeight.bold, color: theme.primaryColor)),
                                      Text('Fokus pada aplikasi edukasi', style: TextStyle(fontSize: 12, color: theme.primaryColor.withOpacity(0.7))),
                                    ],
                                  ),
                                ),
                                Icon(Icons.chevron_right, color: theme.primaryColor),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.scaffoldBackgroundColor.withOpacity(0.9),
                        border: Border(top: BorderSide(color: theme.dividerColor.withOpacity(0.1))),
                      ),
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.primaryColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text('Save All Limits'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(active: 'controls'),
    );
  }
}
