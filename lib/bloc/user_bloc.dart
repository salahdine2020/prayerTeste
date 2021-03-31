import 'package:prayer_test/model/prayer_response.dart';
import 'package:prayer_test/model/user_response.dart';
import 'package:prayer_test/repository/user_repository.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc {
  final UserRepository _repository = UserRepository();
//  final BehaviorSubject<UserResponse> _subject = BehaviorSubject<UserResponse>();
  final BehaviorSubject<PrayerResponse> _subject = BehaviorSubject<PrayerResponse>();

  getUser() async {
    //UserResponse response = await _repository.getUser();
    PrayerResponse response = await _repository.getUser();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

//  BehaviorSubject<UserResponse> get subject => _subject;
  BehaviorSubject<PrayerResponse> get subject => _subject;
}

final bloc = UserBloc();
