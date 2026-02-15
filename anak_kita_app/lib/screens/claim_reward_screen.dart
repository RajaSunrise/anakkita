import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:anak_kita_app/providers/app_state.dart';
import 'package:anak_kita_app/widgets/common_widgets.dart';

class ClaimRewardScreen extends StatelessWidget {
  const ClaimRewardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appState = context.read<AppState>();

    return Scaffold(
      body: Stack(
        children: [
          // Background decorations
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: theme.primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: theme.primaryColor.withOpacity(0.2), blurRadius: 100),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                const StatusBar(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 60),
                        // Star/Trophy
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                color: Colors.amber.withOpacity(0.2),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(color: Colors.amber.withOpacity(0.4), blurRadius: 60),
                                ],
                              ),
                            ),
                            Container(
                              width: 160,
                              height: 160,
                              decoration: BoxDecoration(
                                color: theme.scaffoldBackgroundColor,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.amber.withOpacity(0.3), width: 8),
                                boxShadow: [
                                  BoxShadow(color: Colors.amber.withOpacity(0.2), blurRadius: 20, offset: const Offset(0, 10)),
                                ],
                              ),
                              child: const Icon(Icons.star, size: 80, color: Colors.amber),
                            ),
                          ],
                        ),
                        const SizedBox(height: 48),
                        Text(
                          'Selamat!\nKamu Dapat Hadiah!',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headlineLarge?.copyWith(
                            fontWeight: FontWeight.w800,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Usaha hebatmu hari ini membuahkan hasil luar biasa.',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyLarge?.copyWith(color: Colors.grey),
                        ),
                        const SizedBox(height: 48),
                        // Reward Card
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: theme.cardColor,
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: theme.primaryColor.withOpacity(0.1)),
                            boxShadow: [
                              BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 10)),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.play_circle_filled, color: Colors.red, size: 32),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('REWARD TERBUKA', style: TextStyle(color: theme.primaryColor, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                                    const SizedBox(height: 4),
                                    const Text('Tambahan 20 Menit Youtube', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),
                        ElevatedButton(
                          onPressed: () {
                            appState.claimRewardTime(20);
                            Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (route) => false);
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Waktu ditambahkan!')));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.primaryColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                            elevation: 8,
                            shadowColor: theme.primaryColor.withOpacity(0.4),
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.bolt),
                              SizedBox(width: 8),
                              Text('Gunakan Sekarang', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        OutlinedButton(
                          onPressed: () {
                             Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (route) => false);
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: theme.primaryColor,
                            side: BorderSide(color: theme.primaryColor.withOpacity(0.3)),
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          child: const Text('Simpan untuk Nanti', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(height: 32),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.info_outline, size: 16, color: Colors.grey),
                            SizedBox(width: 4),
                            Text('Berlaku hingga pukul 21:00', style: TextStyle(color: Colors.grey, fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const HomeIndicator(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
