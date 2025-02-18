import 'package:flutter_test/flutter_test.dart';

import 'package:forui/widgets/time_picker.dart';

void main() {
  group('FLocalTime', () {
    test('default values', () {
      const time = FTime();

      expect(time.hour, 0);
      expect(time.minute, 0);
    });

    test('given values', () {
      const time = FTime(12, 30);

      expect(time.hour, 12);
      expect(time.minute, 30);
    });

    test('hour is less than 0', () => expect(() => FTime(-1), throwsAssertionError));

    test('hour is greater than 23', () => expect(() => FTime(24), throwsAssertionError));

    test(' minute is less than 0', () => expect(() => FTime(0, -1), throwsAssertionError));

    test('minute is greater than 59', () => expect(() => FTime(0, 60), throwsAssertionError));

    test('given DateTime', () {
      final time = FTime.fromDateTime(DateTime(2022, 1, 1, 12, 30));

      expect(time.hour, 12);
      expect(time.minute, 30);
    });

    test('hour and/or minute replaced', () {
      final time = const FTime(12, 31).copyWith(hour: 15, minute: 32);

      expect(time, const FTime(15, 32));
    });

    test('combine date and local time', () {
      final date = const FTime(12, 30).withDate(DateTime(2022));
      expect(date, DateTime(2022, 1, 1, 12, 30));
    });

    test('compare times', () {
      const time1 = FTime(12, 30);
      const time2 = FTime(12, 31);

      expect(time1 < time2, true);
      expect(time1 <= time2, true);
      expect(time1 > time2, false);
      expect(time1 >= time2, false);
    });
  });
}
