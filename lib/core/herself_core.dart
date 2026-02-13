// This class handles the logic for suggesting which module to use.
// It uses simple rules based on the girl's current status.
class HerselfCore {
  String mood;          // e.g., 'happy', 'stressed', 'tired'
  int energyLevel;      // scale of 1-10
  String dayStatus;     // e.g., 'completed', 'pending tasks'
  bool isEmergency;     // true if the user is in immediate trouble

  // Constructor to initialize the values
  HerselfCore({
    required this.mood,
    required this.energyLevel,
    required this.dayStatus,
    this.isEmergency = false,
  });

  // This method checks the rules and suggests the best module name.
  String getSuggestedModule() {
    // 1. Priority Rule: Guardian for emergencies
    if (isEmergency) {
      return 'Guardian';
    }

    // 2. Low energy means she needs a Boost
    if (energyLevel < 5) {
      return 'Boost';
    }

    // 3. If she is stressed, suggest the Safe Space
    if (mood == 'stressed') {
      return 'Safe Space';
    }

    // 4. If there are things left to do, suggest the Daily Planner
    if (dayStatus == 'pending tasks') {
      return 'Daily Planner';
    }

    // 5. Default suggestion if she's doing okay and has energy
    if (energyLevel >= 5 && mood != 'stressed') {
      return 'Health Care';
    }

    // Fallback in case none of the above match
    return 'Boost';
  }
}
