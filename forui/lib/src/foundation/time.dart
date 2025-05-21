import 'package:meta/meta.dart';

/// Represents the time of day.
final class FTime implements Comparable<FTime> {
  /// The hour. Always in 24-hour format.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [hour] < 0 or 23 < [hour].
  final int hour;

  /// The minute.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [minute] < 0 or 59 < [minute].
  final int minute;

  /// Creates a [FTime].
  const FTime([this.hour = 0, this.minute = 0])
    : assert(hour >= 0 && hour <= 23, 'hour must be between 0 and 23'),
      assert(minute >= 0 && minute <= 59, 'minute must be between 0 and 59');

  /// Creates a [FTime] based on the given [DateTime].
  FTime.fromDateTime(DateTime dateTime) : this(dateTime.hour, dateTime.minute);

  /// Creates a [FTime] based on the current time.
  FTime.now() : this.fromDateTime(DateTime.now());

  /// Returns a new [FTime] with the hour and/or minute replaced.
  @useResult
  FTime copyWith({int? hour, int? minute}) => FTime(hour ?? this.hour, minute ?? this.minute);

  /// Returns a [DateTime] with the date part of [date] and the time part of this [FTime].
  @useResult
  DateTime withDate(DateTime date) => date.copyWith(hour: hour, minute: minute);

  /// Returns true if this time is before [other].
  bool operator <(FTime other) => compareTo(other) < 0;

  /// Returns true if this time is before or equal to [other].
  bool operator <=(FTime other) => compareTo(other) <= 0;

  /// Returns true if this time is after [other].
  bool operator >(FTime other) => compareTo(other) > 0;

  /// Returns true if this time is after or equal to [other].
  bool operator >=(FTime other) => compareTo(other) >= 0;

  @override
  int compareTo(FTime other) {
    if (hour != other.hour) {
      return hour.compareTo(other.hour);
    }

    return minute.compareTo(other.minute);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FTime && runtimeType == other.runtimeType && hour == other.hour && minute == other.minute;

  @override
  int get hashCode => hour.hashCode ^ minute.hashCode;

  @override
  String toString() => '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
}
