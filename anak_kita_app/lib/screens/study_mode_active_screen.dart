import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:anak_kita_app/providers/app_state.dart';
import 'package:anak_kita_app/widgets/common_widgets.dart';

class StudyModeActiveScreen extends StatefulWidget {
  const StudyModeActiveScreen({super.key});

  @override
  State<StudyModeActiveScreen> createState() => _StudyModeActiveScreenState();
}

class _StudyModeActiveScreenState extends State<StudyModeActiveScreen> {
  bool _showBlocked = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appState = context.watch<AppState>();

    return PopScope(
      canPop: false, // Prevent back navigation
      onPopInvoked: (didPop) {
        if (!didPop) {
          setState(() {
            _showBlocked = true;
          });
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            // Main Content
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    theme.primaryColor.withOpacity(0.1),
                    theme.scaffoldBackgroundColor,
                  ],
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    const StatusBar(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: theme.primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.auto_stories, size: 16, color: theme.primaryColor),
                                const SizedBox(width: 8),
                                Text(
                                  'MODE BELAJAR AKTIF',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: theme.primaryColor,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'Sedang Waktunya Belajar',
                            style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Ayo tetap fokus, Budi! Selesaikan tugasmu tepat waktu.',
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey),
                          ),
                          const SizedBox(height: 40),
                          // Timer Card
                          Container(
                            padding: const EdgeInsets.all(32),
                            decoration: BoxDecoration(
                              color: theme.primaryColor,
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: theme.primaryColor.withOpacity(0.3),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'SELESAI DALAM',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.8),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  '00:45:12',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 48,
                                    fontWeight: FontWeight.bold,
                                    fontFeatures: [FontFeature.tabularFigures()],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 40),
                          // Allowed Apps Grid
                          GridView.count(
                            shrinkWrap: true,
                            crossAxisCount: 3,
                            crossAxisSpacing: 24,
                            mainAxisSpacing: 24,
                            children: [
                              _buildAppIcon(context, 'Kalkulator', Icons.calculate, Colors.blue),
                              _buildAppIcon(context, 'Kamus', Icons.translate, Colors.green),
                              _buildAppIcon(context, 'Zoom', Icons.video_call, Colors.orange),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                      child: OutlinedButton(
                        onPressed: () {
                          // Request permission (mock)
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Permintaan terkirim ke orang tua.')),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.grey,
                          side: BorderSide(color: Colors.grey.withOpacity(0.5), style: BorderStyle.solid),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.contact_support),
                            SizedBox(width: 8),
                            Text('Minta Izin Buka Aplikasi'),
                          ],
                        ),
                      ),
                    ),
                    const HomeIndicator(),
                  ],
                ),
              ),
            ),
            // Blocked Overlay
            if (_showBlocked)
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    color: Colors.black.withOpacity(0.6),
                    child: Center(
                      child: Container(
                        margin: const EdgeInsets.all(32),
                        padding: const EdgeInsets.all(32),
                        decoration: BoxDecoration(
                          color: theme.scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: const [
                            BoxShadow(color: Colors.black26, blurRadius: 20, offset: Offset(0, 10)),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.block, color: Colors.red, size: 48),
                            ),
                            const SizedBox(height: 24),
                            Text(
                              'Akses Dibatasi',
                              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 16),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey),
                                children: [
                                  const TextSpan(text: 'Aplikasi ini diblokir selama '),
                                  TextSpan(
                                    text: 'Mode Belajar',
                                    style: TextStyle(fontWeight: FontWeight.bold, color: theme.primaryColor),
                                  ),
                                  const TextSpan(text: '. Fokus ya! Kamu bisa membukanya setelah waktu belajar usai.'),
                                ],
                              ),
                            ),
                            const SizedBox(height: 32),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _showBlocked = false;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.primaryColor,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                minimumSize: const Size(double.infinity, 50),
                              ),
                              child: const Text('Oke, Aku Fokus Lagi!'),
                            ),
                            const SizedBox(height: 16),
                            GestureDetector(
                              onTap: () {
                                appState.setStudyMode(false);
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Exit Study Mode (Parent Only)',
                                style: TextStyle(color: Colors.grey, fontSize: 12, decoration: TextDecoration.underline),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppIcon(BuildContext context, String name, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: color, size: 32),
        ),
        const SizedBox(height: 8),
        Text(name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
      ],
    );
  }
}
