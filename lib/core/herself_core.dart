import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserState extends ChangeNotifier {
  String _name;
  String _mood;
  int _energyLevel;
  List<String> _tasks;
  int _waterCups;
  
  // New Fields for missing functionality
  String _emergencyContacts;
  int _sleepHours;
  int _daysUntilCycle;
  bool _isSharingLocation;

  final SharedPreferences _prefs;
  
  String get name => _name;
  String get mood => _mood;
  int get energyLevel => _energyLevel;
  List<String> get tasks => _tasks;
  int get waterCups => _waterCups;
  String get emergencyContacts => _emergencyContacts;
  int get sleepHours => _sleepHours;
  int get daysUntilCycle => _daysUntilCycle;
  bool get isSharingLocation => _isSharingLocation;

  UserState(this._prefs)
      : _name = _prefs.getString('user_name') ?? 'Sreeharini',
        _mood = _prefs.getString('user_mood') ?? 'happy',
        _energyLevel = _prefs.getInt('user_energy') ?? 7,
        _tasks = _prefs.getStringList('user_tasks') ?? [],
        _waterCups = _prefs.getInt('user_water') ?? 0,
        _emergencyContacts = _prefs.getString('user_emergency') ?? 'Mom, Dad, Police',
        _sleepHours = _prefs.getInt('user_sleep') ?? 7,
        _daysUntilCycle = _prefs.getInt('user_cycle') ?? 12,
        _isSharingLocation = _prefs.getBool('user_location') ?? true;

  Future<void> updateName(String newName) async {
    _name = newName.trim();
    notifyListeners();
    await _prefs.setString('user_name', _name);
  }

  Future<void> updateMood(String newMood) async {
    _mood = newMood;
    notifyListeners();
    await _prefs.setString('user_mood', newMood);
  }

  Future<void> updateEnergy(int level) async {
    _energyLevel = level;
    notifyListeners();
    await _prefs.setInt('user_energy', level);
  }

  Future<void> addTask(String task) async {
    _tasks.add(task.trim());
    notifyListeners();
    await _prefs.setStringList('user_tasks', List.from(_tasks));
  }

  Future<void> removeTask(int index) async {
    _tasks.removeAt(index);
    notifyListeners();
    await _prefs.setStringList('user_tasks', List.from(_tasks));
  }

  Future<void> incrementWater() async {
    _waterCups++;
    notifyListeners();
    await _prefs.setInt('user_water', _waterCups);
  }

  // New Methods for persistence
  Future<void> updateEmergencyContacts(String contacts) async {
    _emergencyContacts = contacts;
    notifyListeners();
    await _prefs.setString('user_emergency', contacts);
  }

  Future<void> updateSleep(int hours) async {
    _sleepHours = hours;
    notifyListeners();
    await _prefs.setInt('user_sleep', hours);
  }

  Future<void> updateCycleDays(int days) async {
    _daysUntilCycle = days;
    notifyListeners();
    await _prefs.setInt('user_cycle', days);
  }

  Future<void> toggleLocation() async {
    _isSharingLocation = !_isSharingLocation;
    notifyListeners();
    await _prefs.setBool('user_location', _isSharingLocation);
  }

  String getSuggestedModule() {
    if (_energyLevel < 4) return 'Boost';
    if (_mood == 'stressed' || _mood == 'tired') return 'Safe Space';
    if (_tasks.isNotEmpty) return 'Daily Planner';
    return 'Health Care';
  }
}
