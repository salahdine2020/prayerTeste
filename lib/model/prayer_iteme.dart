import 'package:prayer_test/model/location.dart';
import 'package:prayer_test/model/name.dart';
import 'package:prayer_test/model/picture.dart';

class PrayerItem {
  final String Imsak;
  final String Sunrise;
  final String Fajr;
  final String Dhuhr;
  final String Asr;
  final String Sunset;
  final String Maghrib;
  final String Isha;
  final String Midnight;
  PrayerItem(
    this.Imsak,
    this.Sunrise,
    this.Fajr,
    this.Dhuhr,
    this.Asr,
    this.Sunset,
    this.Maghrib,
    this.Isha,
    this.Midnight,
  );

  PrayerItem.fromJson(Map<String, dynamic> json)
      : Imsak = json["Imsak"],
        Sunrise = json['Sunrise'],
        Fajr = json['Fajr'],
        Dhuhr = json['Dhuhr'],
        Asr = json['Asr'],
        Sunset = json['Sunset'],
        Maghrib = json['Maghrib'],
        Isha = json['Isha'],
        Midnight = json['Midnight'];
}
