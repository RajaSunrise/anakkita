import 'package:flutter/material.dart';
import 'package:anak_kita_app/widgets/common_widgets.dart';

class TimeOutScreen extends StatelessWidget {
  const TimeOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const StatusBar(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: theme.primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(Icons.family_restroom, color: theme.primaryColor, size: 20),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Anak Kita',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 48),
                      // Image Area with glow
                      Stack(
                        alignment: Alignment.center,
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: 280,
                            height: 280,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: theme.primaryColor.withOpacity(0.05),
                              boxShadow: [
                                BoxShadow(
                                  color: theme.primaryColor.withOpacity(0.1),
                                  blurRadius: 50,
                                  spreadRadius: 20,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 256,
                            height: 256,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(color: Colors.white, width: 4),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 20,
                                  offset: Offset(0, 10),
                                ),
                              ],
                              image: const DecorationImage(
                                image: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuA6HeSNhTBISerIxzBO7K4Ka8bY3UVnpbpnchasYiK_UA05PgaAzMJV63BUlbxn1Ic4zpJNRPvpOp9oxl0Yaap5G2HSwywpSDGu2u8tu-CoAQklFVUO_5CdM_2ueLfwvSb6ZXKqaRJfW_jySiZENUCagaqQrDnOU_LDPikn59CYL17VAByMKKac66tt2GAeMxh4jIjGersuKekOaqrAyg3ZtPaulFXLcw-nIptYclGbFhHMb-oAMEGcZYiwubC0qFO4jWYo2gjt8mk'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: -16,
                            right: -8,
                            child: GestureDetector(
                              onTap: () => Navigator.pushReplacementNamed(context, '/', arguments: true), // Exit for parent (unlocking)
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: theme.primaryColor,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 4),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 10,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: const Icon(Icons.timer_off, color: Colors.white, size: 32),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 48),
                      Text(
                        'Waktu Habis!',
                        style: theme.textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: theme.colorScheme.onBackground,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Kamu telah melebihi batas waktu penggunaan aplikasi ini. Saatnya istirahat sejenak dan melakukan aktivitas seru lainnya!',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onBackground.withOpacity(0.6),
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Row(
                        children: [
                          _buildActivitySuggestion(context, Icons.menu_book, 'Baca Buku'),
                          const SizedBox(width: 16),
                          _buildActivitySuggestion(context, Icons.sports_soccer, 'Main Bola'),
                          const SizedBox(width: 16),
                          _buildActivitySuggestion(context, Icons.brush, 'Menggambar'),
                        ],
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor,
                  border: Border(top: BorderSide(color: theme.dividerColor.withOpacity(0.1))),
                ),
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/rewards'), // Should be claim-reward but standard flow is rewards
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 4,
                    shadowColor: theme.primaryColor.withOpacity(0.4),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_circle_outline),
                      SizedBox(width: 8),
                      Text('Minta Tambahan Waktu', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivitySuggestion(BuildContext context, IconData icon, String label) {
    final theme = Theme.of(context);
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: theme.primaryColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Icon(icon, color: theme.primaryColor, size: 28),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: theme.primaryColor.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
