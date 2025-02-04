class Utility {
  static int calculateBatteryPercentage(num voltage) {
    double percentage = (1.1 - (11.1 - voltage)) / 1.1 * 100;
    return percentage.clamp(0, 100).toInt();
  }

  static int calculateRemainingFlightTime(num voltage) {
    const int fullChargeFlightTimeInMinutes = 10;

    int batteryPercentage = calculateBatteryPercentage(voltage);
    double remainingFlightTime =
        (fullChargeFlightTimeInMinutes * (batteryPercentage / 100.0));
    return remainingFlightTime.toInt();
  }

  static num parseNumber(String number) {
    try {
      num numberValue = num.parse(number);
      return numberValue;
    } catch (e) {
      return 0;
    }
  }
}
