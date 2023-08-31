import 'package:hive_flutter/hive_flutter.dart';

class CalculatorProvider {
  static Map<String, int> calculateAgeDifference(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    Duration difference = currentDate.difference(birthDate);

    int years = difference.inDays ~/ 365;
    int months = (difference.inDays % 365) ~/ 30;
    int days = difference.inDays % 30;

    return {
      'years': years,
      'months': months,
      'days': days,
    };
  }

  static calculateNextBirthday(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    DateTime nextBirthday;
    int nextBirthdayYear;

    if (birthDate.month > currentDate.month ||
        (birthDate.month == currentDate.month &&
            birthDate.day >= currentDate.day)) {
      nextBirthdayYear = currentDate.year;
    } else {
      nextBirthdayYear = currentDate.year + 1;
    }

    nextBirthday = DateTime(nextBirthdayYear, birthDate.month, birthDate.day);

    Duration difference = nextBirthday.difference(currentDate);
    int months = difference.inDays ~/ 30;
    int days = difference.inDays % 30;
    return {"month": months, "days": days};
  }

  static Map<String, int> calculateNextBirth(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    DateTime nextBirthday;
    int nextBirthdayYear;

    if (birthDate.month > currentDate.month ||
        (birthDate.month == currentDate.month &&
            birthDate.day >= currentDate.day)) {
      nextBirthdayYear = currentDate.year;
    } else {
      nextBirthdayYear = currentDate.year + 1;
    }

    nextBirthday = DateTime(nextBirthdayYear, birthDate.month, birthDate.day);

    Duration difference = nextBirthday.difference(currentDate);
    int nextBirthMonth = difference.inDays ~/ 30;
    int nextBirthDays = difference.inDays % 30;

    return {
      'months': nextBirthMonth,
      'days': nextBirthDays,
    };
  }

  static Map<String, int> calculateAgeDetails(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    Duration duration = currentDate.difference(birthDate);

    int years = duration.inDays ~/ 365;
    int months = (duration.inDays % 365) ~/ 30;
    int days = duration.inDays % 30;
    int weeks = duration.inDays ~/ 7;
    int hours = duration.inHours;

    return {
      'years': years,
      'months': months,
      'days': days,
      'weeks': weeks,
      'hours': hours,
    };
  }

  static final userlist = Hive.box("users_list");

  static createUserList(Map<String, dynamic> userInformations) async {
    await userlist.add(userInformations);
    print("users ${userlist.length}");
  }
}
