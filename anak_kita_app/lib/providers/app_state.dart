import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState extends ChangeNotifier {
  // State variables
  int _dailyLimitSeconds = 5 * 3600; // 5 hours default
  int _usageSecondsToday = 0;
  bool _isStudyModeActive = false;
  double _balance = 0.0;
  int _stars = 12;
  DateTime _lastOpenDate = DateTime.now();
  bool _isParentLoggedIn = false;

  // Timer for tracking usage
  Timer? _usageTimer;

  // Getters
  int get dailyLimitSeconds => _dailyLimitSeconds;
  int get usageSecondsToday => _usageSecondsToday;
  bool get isStudyModeActive => _isStudyModeActive;
  double get balance => _balance;
  int get stars => _stars;
  bool get isParentLoggedIn => _isParentLoggedIn;

  // Derived state
  bool get isLocked => _usageSecondsToday >= _dailyLimitSeconds && !_isStudyModeActive;
  String get formattedUsage {
    final hours = _usageSecondsToday ~/ 3600;
    final minutes = (_usageSecondsToday % 3600) ~/ 60;
    return '${hours}h ${minutes}m';
  }

  String get formattedLimit {
    final hours = _dailyLimitSeconds ~/ 3600;
    final minutes = (_dailyLimitSeconds % 3600) ~/ 60;
    return '${hours}h ${minutes}m';
  }

  // Initialization
  Future<void> init() async {
    await _loadState();
    _startUsageTimer();
    _checkDailyReset();
  }

  void _startUsageTimer() {
    _usageTimer?.cancel();
    _usageTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!isLocked) {
        _usageSecondsToday++;
        if (_usageSecondsToday % 10 == 0) {
          _saveState(); // Save every 10 seconds
        }
        notifyListeners();
      }
    });
  }

  void _checkDailyReset() {
    final now = DateTime.now();
    if (now.day != _lastOpenDate.day || now.month != _lastOpenDate.month || now.year != _lastOpenDate.year) {
      _usageSecondsToday = 0;
      _lastOpenDate = now;
      _saveState();
      notifyListeners();
    }
  }

  // Methods to modify state
  void setParentLoggedIn(bool value) {
    _isParentLoggedIn = value;
    notifyListeners();
  }

  void setStudyMode(bool active) {
    _isStudyModeActive = active;
    notifyListeners();
  }

  void addBalance(double amount) {
    _balance += amount;
    _saveState();
    notifyListeners();
  }

  void addStars(int amount) {
    _stars += amount;
    _saveState();
    notifyListeners();
  }

  void claimRewardTime(int minutes) {
    // Reduce usage to "add time" effectively
    _usageSecondsToday -= (minutes * 60);
    if (_usageSecondsToday < 0) _usageSecondsToday = 0;
    _saveState();
    notifyListeners();
  }

  void setDailyLimit(int hours, int minutes) {
    _dailyLimitSeconds = (hours * 3600) + (minutes * 60);
    _saveState();
    notifyListeners();
  }

  // Persistence
  Future<void> _loadState() async {
    final prefs = await SharedPreferences.getInstance();
    _dailyLimitSeconds = prefs.getInt('dailyLimitSeconds') ?? 5 * 3600;
    _usageSecondsToday = prefs.getInt('usageSecondsToday') ?? 0;
    _balance = prefs.getDouble('balance') ?? 0.0;
    _stars = prefs.getInt('stars') ?? 12;

    final lastDateMs = prefs.getInt('lastOpenDate');
    if (lastDateMs != null) {
      _lastOpenDate = DateTime.fromMillisecondsSinceEpoch(lastDateMs);
    }
    notifyListeners();
  }

  Future<void> _saveState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('dailyLimitSeconds', _dailyLimitSeconds);
    await prefs.setInt('usageSecondsToday', _usageSecondsToday);
    await prefs.setDouble('balance', _balance);
    await prefs.setInt('stars', _stars);
    await prefs.setInt('lastOpenDate', DateTime.now().millisecondsSinceEpoch);
  }

  @override
  void dispose() {
    _usageTimer?.cancel();
    super.dispose();
  }
}
