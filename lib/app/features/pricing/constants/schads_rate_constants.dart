class SchadsRateConstants {
  static const Map<String, List<String>> levelsForStream = {
    'Social & Community Services': [
      'Level 1',
      'Level 2',
      'Level 3',
      'Level 4',
      'Level 5',
      'Level 6',
      'Level 7',
      'Level 8',
    ],
    'Crisis Accommodation': ['Level 1', 'Level 2', 'Level 3', 'Level 4'],
    'Family Day Care': ['Level 1', 'Level 2', 'Level 3', 'Level 4', 'Level 5'],
    'Home Care (Disability)': [
      'Level 1',
      'Level 2',
      'Level 3',
      'Level 4',
      'Level 5',
    ],
    'Home Care (Aged)': [
      'Level 1',
      'Level 2',
      'Level 3',
      'Level 4',
      'Level 5',
      'Level 6',
    ],
  };

  static List<String> get streams => levelsForStream.keys.toList();

  static const List<String> employmentTypes = ['Permanent', 'Casual'];

  static const Map<String, double> rates = {
    // Social & Community Services
    'Social & Community Services - Level 1 - Pay Point 1': 26.30,
    'Social & Community Services - Level 1 - Pay Point 2': 27.15,
    'Social & Community Services - Level 1 - Pay Point 3': 28.12,
    'Social & Community Services - Level 2 - Pay Point 1': 34.58,
    'Social & Community Services - Level 2 - Pay Point 2': 35.67,
    'Social & Community Services - Level 2 - Pay Point 3': 36.75,
    'Social & Community Services - Level 2 - Pay Point 4': 37.73,
    'Social & Community Services - Level 3 - Pay Point 1': 38.65,
    'Social & Community Services - Level 3 - Pay Point 2': 39.77,
    'Social & Community Services - Level 3 - Pay Point 3': 40.62,
    'Social & Community Services - Level 3 - Pay Point 4': 41.45,
    'Social & Community Services - Level 4 - Pay Point 1': 44.58,
    'Social & Community Services - Level 4 - Pay Point 2': 45.75,
    'Social & Community Services - Level 4 - Pay Point 3': 46.93,
    'Social & Community Services - Level 4 - Pay Point 4': 47.97,
    'Social & Community Services - Level 5 - Pay Point 1': 51.00,
    'Social & Community Services - Level 5 - Pay Point 2': 52.10,
    'Social & Community Services - Level 5 - Pay Point 3': 53.31,
    'Social & Community Services - Level 6 - Pay Point 1': 55.72,
    'Social & Community Services - Level 6 - Pay Point 2': 56.95,
    'Social & Community Services - Level 6 - Pay Point 3': 58.19,
    'Social & Community Services - Level 7 - Pay Point 1': 60.27,
    'Social & Community Services - Level 7 - Pay Point 2': 61.53,
    'Social & Community Services - Level 7 - Pay Point 3': 62.79,
    'Social & Community Services - Level 8 - Pay Point 1': 65.39,
    'Social & Community Services - Level 8 - Pay Point 2': 66.67,
    'Social & Community Services - Level 8 - Pay Point 3': 67.96,

    // Crisis Accommodation
    'Crisis Accommodation - Level 1 - Pay Point 1': 38.65,
    'Crisis Accommodation - Level 1 - Pay Point 2': 39.77,
    'Crisis Accommodation - Level 1 - Pay Point 3': 40.62,
    'Crisis Accommodation - Level 1 - Pay Point 4': 41.45,
    'Crisis Accommodation - Level 2 - Pay Point 1': 44.58,
    'Crisis Accommodation - Level 2 - Pay Point 2': 45.75,
    'Crisis Accommodation - Level 2 - Pay Point 3': 46.93,
    'Crisis Accommodation - Level 2 - Pay Point 4': 47.97,
    'Crisis Accommodation - Level 3 - Pay Point 1': 51.00,
    'Crisis Accommodation - Level 3 - Pay Point 2': 52.10,
    'Crisis Accommodation - Level 3 - Pay Point 3': 53.31,
    'Crisis Accommodation - Level 4 - Pay Point 1': 55.72,
    'Crisis Accommodation - Level 4 - Pay Point 2': 56.95,
    'Crisis Accommodation - Level 4 - Pay Point 3': 58.19,

    // Family Day Care
    'Family Day Care - Level 1 - Pay Point 1': 26.33,
    'Family Day Care - Level 1 - Pay Point 2': 27.18,
    'Family Day Care - Level 1 - Pay Point 3': 28.16,
    'Family Day Care - Level 1 - Pay Point 4': 29.11,
    'Family Day Care - Level 2 - Pay Point 1': 29.94,
    'Family Day Care - Level 2 - Pay Point 2': 30.91,
    'Family Day Care - Level 2 - Pay Point 3': 31.89,
    'Family Day Care - Level 2 - Pay Point 4': 32.65,
    'Family Day Care - Level 3 - Pay Point 1': 33.48,
    'Family Day Care - Level 3 - Pay Point 2': 34.52,
    'Family Day Care - Level 3 - Pay Point 3': 35.59,
    'Family Day Care - Level 3 - Pay Point 4': 36.57,
    'Family Day Care - Level 4 - Pay Point 1': 37.62,
    'Family Day Care - Level 4 - Pay Point 2': 38.02,
    'Family Day Care - Level 4 - Pay Point 3': 38.91,
    'Family Day Care - Level 4 - Pay Point 4': 39.55,
    'Family Day Care - Level 5 - Pay Point 1': 42.38,
    'Family Day Care - Level 5 - Pay Point 2': 43.56,
    'Family Day Care - Level 5 - Pay Point 3': 44.74,
    'Family Day Care - Level 5 - Pay Point 4': 45.91,

    // Home Care (Disability)
    'Home Care (Disability) - Level 1 - Pay Point 1': 26.05,
    'Home Care (Disability) - Level 2 - Pay Point 1': 27.55,
    'Home Care (Disability) - Level 2 - Pay Point 2': 27.74,
    'Home Care (Disability) - Level 3 - Pay Point 1': 28.12,
    'Home Care (Disability) - Level 3 - Pay Point 2': 28.98,
    'Home Care (Disability) - Level 4 - Pay Point 1': 30.67,
    'Home Care (Disability) - Level 4 - Pay Point 2': 31.29,
    'Home Care (Disability) - Level 5 - Pay Point 1': 32.89,
    'Home Care (Disability) - Level 5 - Pay Point 2': 34.19,

    // Home Care (Aged)
    'Home Care (Aged) - Level 1 - Introductory': 31.13,
    'Home Care (Aged) - Level 2 - Home carer': 32.86,
    'Home Care (Aged) - Level 3 - Qualified': 34.59,
    'Home Care (Aged) - Level 4 - Senior': 35.97,
    'Home Care (Aged) - Level 5 - Specialist': 37.35,
    'Home Care (Aged) - Level 6 - Team leader': 38.74,
  };

  static const Map<String, double> allowances = {
    'First aid - Full-time': 20.46, // Per week
    'First aid - Casual': 0.54, // Per hour
    'Laundry': 0.32, // Per shift
    'Meal': 16.62, // Per occasion
    'Sleepover': 60.02, // Per sleepover
    'On call (Mon-Fri)': 24.50, // Per 24h
    'On call (Pub Hol/Other)': 48.51, // Per 24h
    'Uniform': 1.23, // Per shift
    'Vehicle': 0.99, // Per km
  };

  static List<String> getPayPoints(String stream, String level) {
    if (stream == 'Home Care (Aged)') {
      switch (level) {
        case 'Level 1':
          return ['Introductory'];
        case 'Level 2':
          return ['Home carer'];
        case 'Level 3':
          return ['Qualified'];
        case 'Level 4':
          return ['Senior'];
        case 'Level 5':
          return ['Specialist'];
        case 'Level 6':
          return ['Team leader'];
        default:
          return [];
      }
    }

    // Default logic for others
    // Simplified map for brevity, expanding based on the rates map above
    if (stream == 'Social & Community Services') {
      if (level == 'Level 1') {
        return ['Pay Point 1', 'Pay Point 2', 'Pay Point 3'];
      }
      if (level == 'Level 5' ||
          level == 'Level 6' ||
          level == 'Level 7' ||
          level == 'Level 8') {
        return ['Pay Point 1', 'Pay Point 2', 'Pay Point 3'];
      }
      return ['Pay Point 1', 'Pay Point 2', 'Pay Point 3', 'Pay Point 4'];
    }

    if (stream == 'Crisis Accommodation') {
      if (level == 'Level 3' || level == 'Level 4') {
        return ['Pay Point 1', 'Pay Point 2', 'Pay Point 3'];
      }
      return ['Pay Point 1', 'Pay Point 2', 'Pay Point 3', 'Pay Point 4'];
    }

    if (stream == 'Family Day Care') {
      if (level == 'Level 5') {
        return ['Pay Point 1', 'Pay Point 2', 'Pay Point 3', 'Pay Point 4'];
      }
      return ['Pay Point 1', 'Pay Point 2', 'Pay Point 3', 'Pay Point 4'];
    }

    if (stream == 'Home Care (Disability)') {
      if (level == 'Level 1') return ['Pay Point 1'];
      return ['Pay Point 1', 'Pay Point 2'];
    }

    return [];
  }
}
