import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urbanculture/model/Streakmodel.dart';
import 'package:urbanculture/model/datamodel.dart';
import 'package:urbanculture/utills/comman_widgets.dart';

import '../model/chartmodel.dart';

class SkincareProvider with ChangeNotifier {
  SkincareRoutine _routine = SkincareRoutine();
  SkincareRoutine get routine => _routine;
  Streak _streak = Streak(currentStreak: 0, lastLoggedDate: DateTime.now());
  Streak get streak => _streak;
  int rewards = 0;
  bool get latestvalue => latestvalue;


  List<ChartData> getChartData() {
    return [
      ChartData('1D', _streak.currentStreak.toDouble()),
      ChartData('1W', (_streak.currentStreak / 7).clamp(0, 1) * 100),
      ChartData('1M', (_streak.currentStreak / 30).clamp(0, 1) * 100),
      ChartData('3M', (_streak.currentStreak / 90).clamp(0, 1) * 100),
      ChartData('1Y', (_streak.currentStreak / 365).clamp(0, 1) * 100),
    ];
  }

  SkincareProvider() {
    loadStreak();
  }

  void checkboxstepvalue(String step, BuildContext context) {
    switch (step) {
      case 'cleanser':
        _routine.cleanser = !_routine.cleanser;
        break;
      case 'toner':
        _routine.toner = !_routine.toner;
        break;
      case 'moisturizer':
        _routine.moisturizer = !_routine.moisturizer;
        break;
      case 'sunscreen':
        _routine.sunscreen = !_routine.sunscreen;
        break;
      case 'lipBalm':
        _routine.lipBalm = !_routine.lipBalm;
        break;
    }
    notifyListeners();
    if (_routine.isComplete()) {
      _updateStreak(context);
    }
  }

  void _resetCheckboxes() {
    _routine.cleanser = false;
    _routine.toner = false;
    _routine.moisturizer = false;
    _routine.sunscreen = false;
    _routine.lipBalm = false;

    notifyListeners();
  }

  bool getStepStatus(String step) {
    switch (step) {
      case 'cleanser':
        return _routine.cleanser;
      case 'toner':
        return _routine.toner;
      case 'moisturizer':
        return _routine.moisturizer;
      case 'sunscreen':
        return _routine.sunscreen;
      case 'lipBalm':
        return _routine.lipBalm;
      default:
        return false;
    }
  }

  void checkAndUpdateStreak(BuildContext context) {
    if (_routine.isComplete()) {
      print("called");
      _updateStreak(context);
      _saveStreak();
    }
  }

  bool isComplete() {
    return _routine.cleanser &&
        _routine.toner &&
        _routine.moisturizer &&
        _routine.sunscreen &&
        _routine.lipBalm;
  }

  void _updateStreak(BuildContext context) {
    DateTime now = DateTime.now();
    Duration difference = now.difference(_streak.lastLoggedDate);

    print('Current streak: ${_streak.currentStreak}');
    print('Days since last log: ${difference.inDays}');
    print('Current date: ${now}');
    print('Last logged date: ${_streak.lastLoggedDate}');

    if (difference.inDays == 1) {
      _streak.currentStreak += 1;
      _resetCheckboxes();
      CommanWidgets.streakSuccessMessage("Streak Point Added", context);
    } else if (difference.inDays > 1) {
      _streak.currentStreak = 1;
    } else if (difference.inDays == 0) {
      _streak.currentStreak += 1;

      if (_streak.currentStreak == 7 ||
          _streak.currentStreak == 30 ||
          _streak.currentStreak == 90 ||
          _streak.currentStreak == 365) {
        rewardsystem(context);
        CommanWidgets.rewardSuccessMessage("You've earned a reward!", context);
      }

      CommanWidgets.streakSuccessMessage("Streak Point Added", context);
      _resetCheckboxes();
      print('Already logged today');
    }

    _streak.lastLoggedDate = now;
    print('Updated streak: ${_streak.currentStreak}');
    _saveStreak();
    notifyListeners();
  }

  void rewardsystem(BuildContext context) {
    if (_streak.currentStreak == 7 ||
        _streak.currentStreak == 30 ||
        _streak.currentStreak == 90 ||
        _streak.currentStreak == 365) {
      rewards = rewards + 10;

      print(rewards);
    }
  }

  Future<void> _saveStreak() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('currentStreak', _streak.currentStreak);
    await prefs.setString(
        'lastLoggedDate', _streak.lastLoggedDate.toIso8601String());
    await prefs.setInt('rewards', rewards);
    print('Streak saved: ${_streak.currentStreak}');
    print('Rewards saved: $rewards');
  }

  Future<void> loadStreak() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _streak.currentStreak = prefs.getInt('currentStreak') ?? 0;
    _streak.lastLoggedDate = DateTime.parse(
        prefs.getString('lastLoggedDate') ?? DateTime.now().toIso8601String());
    rewards = prefs.getInt('rewards') ?? 0;
    print('Loaded streak: ${_streak.currentStreak}');
    print('Loaded rewards: $rewards');

    notifyListeners();
  }

  double getLast30DaysPercentage() {
    DateTime now = DateTime.now();
    DateTime thirtyDaysAgo = now.subtract(const Duration(days: 30));

    if (_streak.lastLoggedDate.isAfter(thirtyDaysAgo)) {
      double daysActive = _streak.currentStreak.toDouble();
      double daysPossible = 30.0;
      double percentage = (daysActive / daysPossible) * 100;
      return double.parse(percentage.toStringAsFixed(2));
    } else {
      double percentage = (_streak.currentStreak / 30).clamp(0, 1) * 100;
      return double.parse(percentage.toStringAsFixed(2));
    }
  }
}
