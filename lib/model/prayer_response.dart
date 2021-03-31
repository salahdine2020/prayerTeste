import 'package:prayer_test/model/prayer_iteme.dart';

class PrayerResponse {
  final List<PrayerItem> results;
  final String error;

  PrayerResponse(this.results, this.error);

  PrayerResponse.fromJson(Map<String, dynamic> json) : results =(json["results"] as List).map((i) => PrayerItem.fromJson(i)).toList(),
        error = "";

  PrayerResponse.withError(String errorValue) : results = List(), error = errorValue;
}