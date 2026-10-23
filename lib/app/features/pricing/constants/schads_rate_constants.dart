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

  static const List<String> employmentTypes = [
    'Permanent',
    'Part Time',
    'Casual',
  ];

  static const Map<String, double> rates = {
    // Source: Fair Work Pay Guide MA000100, published 18/09/2026,
    // effective the first full pay period on or after 01/12/2026.
    // Social & Community Services
    'Social & Community Services - Level 1 - Pay Point 1': 27.55,
    'Social & Community Services - Level 1 - Pay Point 2': 28.44,
    'Social & Community Services - Level 1 - Pay Point 3': 29.45,
    'Social & Community Services - Level 2 - Pay Point 1': 36.22,
    'Social & Community Services - Level 2 - Pay Point 2': 37.36,
    'Social & Community Services - Level 2 - Pay Point 3': 38.50,
    'Social & Community Services - Level 2 - Pay Point 4': 39.53,
    'Social & Community Services - Level 3 - Pay Point 1': 40.49,
    'Social & Community Services - Level 3 - Pay Point 2': 41.66,
    'Social & Community Services - Level 3 - Pay Point 3': 42.55,
    'Social & Community Services - Level 3 - Pay Point 4': 43.42,
    'Social & Community Services - Level 4 - Pay Point 1': 46.70,
    'Social & Community Services - Level 4 - Pay Point 2': 47.92,
    'Social & Community Services - Level 4 - Pay Point 3': 49.16,
    'Social & Community Services - Level 4 - Pay Point 4': 50.25,
    'Social & Community Services - Level 5 - Pay Point 1': 53.43,
    'Social & Community Services - Level 5 - Pay Point 2': 54.58,
    'Social & Community Services - Level 5 - Pay Point 3': 55.85,
    'Social & Community Services - Level 6 - Pay Point 1': 58.37,
    'Social & Community Services - Level 6 - Pay Point 2': 59.66,
    'Social & Community Services - Level 6 - Pay Point 3': 60.95,
    'Social & Community Services - Level 7 - Pay Point 1': 63.13,
    'Social & Community Services - Level 7 - Pay Point 2': 64.46,
    'Social & Community Services - Level 7 - Pay Point 3': 65.77,
    'Social & Community Services - Level 8 - Pay Point 1': 68.49,
    'Social & Community Services - Level 8 - Pay Point 2': 69.84,
    'Social & Community Services - Level 8 - Pay Point 3': 71.19,

    // Crisis Accommodation
    'Crisis Accommodation - Level 1 - Pay Point 1': 40.49,
    'Crisis Accommodation - Level 1 - Pay Point 2': 41.66,
    'Crisis Accommodation - Level 1 - Pay Point 3': 42.55,
    'Crisis Accommodation - Level 1 - Pay Point 4': 43.42,
    'Crisis Accommodation - Level 2 - Pay Point 1': 46.70,
    'Crisis Accommodation - Level 2 - Pay Point 2': 47.92,
    'Crisis Accommodation - Level 2 - Pay Point 3': 49.16,
    'Crisis Accommodation - Level 2 - Pay Point 4': 50.25,
    'Crisis Accommodation - Level 3 - Pay Point 1': 53.43,
    'Crisis Accommodation - Level 3 - Pay Point 2': 54.58,
    'Crisis Accommodation - Level 3 - Pay Point 3': 55.85,
    'Crisis Accommodation - Level 4 - Pay Point 1': 58.37,
    'Crisis Accommodation - Level 4 - Pay Point 2': 59.66,
    'Crisis Accommodation - Level 4 - Pay Point 3': 60.95,

    // Family Day Care
    'Family Day Care - Level 1 - Pay Point 1': 27.58,
    'Family Day Care - Level 1 - Pay Point 2': 28.47,
    'Family Day Care - Level 1 - Pay Point 3': 29.50,
    'Family Day Care - Level 1 - Pay Point 4': 30.49,
    'Family Day Care - Level 2 - Pay Point 1': 31.36,
    'Family Day Care - Level 2 - Pay Point 2': 32.38,
    'Family Day Care - Level 2 - Pay Point 3': 33.41,
    'Family Day Care - Level 2 - Pay Point 4': 34.20,
    'Family Day Care - Level 3 - Pay Point 1': 35.07,
    'Family Day Care - Level 3 - Pay Point 2': 36.16,
    'Family Day Care - Level 3 - Pay Point 3': 37.28,
    'Family Day Care - Level 3 - Pay Point 4': 38.30,
    'Family Day Care - Level 4 - Pay Point 1': 39.41,
    'Family Day Care - Level 4 - Pay Point 2': 39.83,
    'Family Day Care - Level 4 - Pay Point 3': 40.76,
    'Family Day Care - Level 4 - Pay Point 4': 41.43,
    'Family Day Care - Level 5 - Pay Point 1': 44.40,
    'Family Day Care - Level 5 - Pay Point 2': 45.62,
    'Family Day Care - Level 5 - Pay Point 3': 46.87,
    'Family Day Care - Level 5 - Pay Point 4': 48.09,

    // Home Care (Disability)
    'Home Care (Disability) - Level 1 - Pay Point 1': 31.38,
    'Home Care (Disability) - Level 2 - Pay Point 1': 33.19,
    'Home Care (Disability) - Level 2 - Pay Point 2': 33.41,
    'Home Care (Disability) - Level 3 - Pay Point 1': 33.87,
    'Home Care (Disability) - Level 3 - Pay Point 2': 34.92,
    'Home Care (Disability) - Level 4 - Pay Point 1': 36.95,
    'Home Care (Disability) - Level 4 - Pay Point 2': 37.68,
    'Home Care (Disability) - Level 5 - Pay Point 1': 39.62,
    'Home Care (Disability) - Level 5 - Pay Point 2': 40.58,

    // Home Care (Aged)
    'Home Care (Aged) - Level 1 - Introductory': 32.61,
    'Home Care (Aged) - Level 2 - Home carer': 34.42,
    'Home Care (Aged) - Level 3 - Qualified': 36.23,
    'Home Care (Aged) - Level 4 - Senior': 37.68,
    'Home Care (Aged) - Level 5 - Specialist': 39.13,
    'Home Care (Aged) - Level 6 - Team leader': 40.58,
  };

  static const Map<String, double> allowances = {
    'First aid - Full-time': 21.43, // Per week
    'First aid - Casual': 0.56, // Per hour, capped at $21.43/week
    'Laundry': 0.33, // Per shift, capped at $1.53/week
    'Meal': 17.30, // Per occasion, plus $17.30 after >4h overtime
    'Sleepover': 62.87, // Per sleepover
    'On call (Mon-Fri)': 25.66, // Per 24h
    'On call (Pub Hol/Other)': 50.81, // Per 24h
    'Uniform': 1.26, // Per shift, capped at $6.41/week
    'Vehicle': 1.05, // Per km (1 Sep 2026 – 28 Feb 2027)
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
