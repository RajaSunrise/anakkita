import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:anak_kita_app/providers/app_state.dart';
import 'package:anak_kita_app/widgets/common_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final List<int> _pin = [];
  final int _pinLength = 6;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final appState = context.read<AppState>();
    final unlocking = ModalRoute.of(context)?.settings.arguments as bool? ?? false;

    if (appState.isLocked && !unlocking && !appState.isParentLoggedIn) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/time-out');
      });
    }
  }

  void _onKeyPress(int number) {
    if (_pin.length < _pinLength) {
      setState(() {
        _pin.add(number);
      });
      if (_pin.length == _pinLength) {
        // Mock validation
        if (_pin.join() == '123456') { // Simple mock PIN
          final appState = context.read<AppState>();
          appState.setParentLoggedIn(true);
          Navigator.pushReplacementNamed(context, '/dashboard');
        } else {
          // Wrong PIN feedback
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('PIN Salah! Coba lagi.')),
          );
          setState(() {
            _pin.clear();
          });
        }
      }
    }
  }

  void _onBackspace() {
    if (_pin.isNotEmpty) {
      setState(() {
        _pin.removeLast();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const StatusBar(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: theme.primaryColor,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: theme.primaryColor.withOpacity(0.2),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Icon(Icons.family_restroom, color: Colors.white, size: 48),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Anak Kita',
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onBackground,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Pendamping Digital Keluarga',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onBackground.withOpacity(0.6),
                            ),
                          ),
                          const SizedBox(height: 32),
                          Text(
                            'Masukkan PIN Orang Tua',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(_pinLength, (index) {
                              final filled = index < _pin.length;
                              return Container(
                                margin: const EdgeInsets.symmetric(horizontal: 8),
                                width: 14,
                                height: 14,
                                decoration: BoxDecoration(
                                  color: filled ? theme.primaryColor : Colors.transparent,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: theme.primaryColor,
                                    width: 2,
                                  ),
                                ),
                              );
                            }),
                          ),
                          const SizedBox(height: 32),
                          TextButton(
                            onPressed: () {},
                            child: Text('Lupa PIN?', style: TextStyle(color: theme.primaryColor)),
                          ),
                        ],
                      ),
                    ),
                    // Numpad
                    Container(
                      constraints: const BoxConstraints(maxWidth: 400),
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                      child: GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 3,
                        childAspectRatio: 1.5,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          for (var i = 1; i <= 9; i++) _buildKey(i.toString(), () => _onKeyPress(i)),
                          _buildKeyIcon(Icons.face, () => Navigator.pushNamed(context, '/time-out'), color: theme.primaryColor),
                          _buildKey('0', () => _onKeyPress(0)),
                          _buildKeyIcon(Icons.backspace, _onBackspace, color: Colors.grey),
                        ],
                      ),
                    ),
                    const HomeIndicator(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildKey(String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Center(
        child: Container(
          width: 64,
          height: 64,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).cardColor,
          ),
          child: Text(
            label,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }

  Widget _buildKeyIcon(IconData icon, VoidCallback onTap, {Color? color}) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Center(
        child: Container(
          width: 64,
          height: 64,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).cardColor,
          ),
          child: Icon(icon, size: 28, color: color),
        ),
      ),
    );
  }
}
