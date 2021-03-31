import 'package:prayer_test/model/prayer_response.dart';
import 'package:prayer_test/model/user_response.dart';
import 'package:prayer_test/repository/user_api_provider.dart';

class UserRepository{
  UserApiProvider _apiProvider = UserApiProvider();

//  Future<UserResponse> getUser(){
//    return _apiProvider.getUser();
//    //return _apiProvider.getInformation();
//  }
  Future<PrayerResponse> getUser(){
    return _apiProvider.getInformation();
    //return _apiProvider.getInformation();
  }
}