import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:anak_kita_app/providers/app_state.dart';
import 'package:anak_kita_app/widgets/common_widgets.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

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
                  InkWell(
                    onTap: () => Navigator.pushReplacementNamed(context, '/dashboard'),
                    child: Row(
                      children: [
                        Icon(Icons.chevron_left, color: theme.primaryColor),
                        Text('Beranda', style: TextStyle(fontWeight: FontWeight.bold, color: theme.primaryColor)),
                      ],
                    ),
                  ),
                  Text('Hadiah & Pencapaian', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  Icon(Icons.more_horiz, color: theme.primaryColor),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    // Stars Card
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [theme.primaryColor, Colors.blue.shade300],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(color: theme.primaryColor.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10)),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Bintang Tersedia', style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Text('${appState.stars}', style: const TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)),
                                    const SizedBox(width: 8),
                                    const Icon(Icons.star, color: Colors.yellow, size: 32),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: const Text('Satu langkah lagi menuju target!', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          ),
                          // Piggy Bank / Money
                          Column(
                            children: [
                              const Icon(Icons.savings, color: Colors.white, size: 40),
                              const SizedBox(height: 8),
                              Text('Rp ${appState.balance.toStringAsFixed(0)}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                              TextButton(
                                onPressed: () {
                                  // Mock Add Money
                                  appState.addBalance(5000);
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ditambahkan Rp 5.000')));
                                },
                                style: TextButton.styleFrom(foregroundColor: Colors.white),
                                child: const Text('+ Tambah Uang', style: TextStyle(fontSize: 10)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    _buildTaskItem(context, 'Belajar 1 Jam', '+15 Menit TikTok', Icons.auto_stories, true),
                    _buildTaskItem(context, 'Bantu Cuci Piring', '1 Bintang', Icons.flatware, false),
                    const SizedBox(height: 32),
                    Center(
                      child: Column(
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(16),
                            child: ClipOval(
                              child: Image.network(
                                'https://lh3.googleusercontent.com/aida-public/AB6AXuDE4y0bBMGAjDmHK92pmWESkPp7PcXnHuA-8gOXOMOaO-IXM2u1LI58P1voWUBE4lotR_HXGsx-9Pu1JAUC168QV50EbbaVAbdZVlbLb_zE_NFaQNBtBNQgbSfdT8Xlrvk5Oyvr1HakgPYY3DQU5v38blqUk9gTl4XF70xBXbus9u_qmjF3hBcBEhi-fmCtbWu6Q5yDBW0yUtqu8Wrqpm_DMA7Dva_65SQXbgetyW6TxNogfHB9XNLsM0rmHN9S8d5nclyZZ3Z4YN4',
                                fit: BoxFit.cover,
                                errorBuilder: (c,e,s) => Icon(Icons.person, size: 60, color: theme.primaryColor),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.primaryColor,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.add_circle),
                                SizedBox(width: 8),
                                Text('Tambah Aturan Baru'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(active: 'rewards'),
    );
  }

  Widget _buildTaskItem(BuildContext context, String title, String reward, IconData icon, bool checked) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: theme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: theme.primaryColor),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.redeem, size: 12, color: theme.primaryColor),
                    const SizedBox(width: 4),
                    Text(reward, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: theme.primaryColor)),
                  ],
                ),
              ],
            ),
          ),
          Switch(value: checked, onChanged: (_) {}, activeColor: theme.primaryColor),
        ],
      ),
    );
  }
}
