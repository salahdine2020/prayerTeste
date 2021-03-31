

import 'package:dio/dio.dart';
import 'package:prayer_test/model/prayer_model.dart';
import 'package:prayer_test/model/prayer_response.dart';
import 'package:prayer_test/utils/logging_interceptor.dart';

class PrayerProvider{
  final String _endpoint2 = "https://api.pray.zone/v2/times/today.json?city=mecca&fbclid=IwAR1NaVff729cKRBOWheoKHk_G1yI3QWe_C3po6h9g8xNTQh9xQYpKl5hfM8";
  Dio _dio;

  PrayerProvider() {
    BaseOptions options = BaseOptions(receiveTimeout: 5000, connectTimeout: 5000);
    _dio = Dio(options);
    _dio.interceptors.add(LoggingInterceptor());
  }

    Future<List<String>> getInformation() async { // PrayerResponse
    List<String> val_times = [];
    try {
      Response response = await _dio.get(_endpoint2);
      final respons_information = Autogenerated.fromJson(response.data);
      Results res = respons_information.results;
      List<Datetime> list_times = res.datetime;
      Times time_object = list_times[0].times;
      val_times.add(time_object.fajr);
      val_times.add(time_object.imsak);
      val_times.add(time_object.sunrise);
      val_times.add(time_object.dhuhr);
      val_times.add(time_object.asr);
      val_times.add(time_object.maghrib);
      val_times.add(time_object.isha);
      val_times.add(time_object.midnight);
      print(val_times);
      return val_times;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      //print('Error when call API'); 
      //PrayerResponse.withError(_handleError(error));
    }
  }

    String _handleError(Error error) {
    String errorDescription = "";
    if (error is DioError) {
      DioError dioError = error as DioError;
      switch (dioError.type) {
        case DioErrorType.CANCEL:
          errorDescription = "Request to API server was cancelled";
          break;
        case DioErrorType.CONNECT_TIMEOUT:
          errorDescription = "Connection timeout with API server";
          break;
        case DioErrorType.DEFAULT:
          errorDescription =
              "Connection to API server failed due to internet connection";
          break;
        case DioErrorType.RECEIVE_TIMEOUT:
          errorDescription = "Receive timeout in connection with API server";
          break;
        case DioErrorType.RESPONSE:
          errorDescription =
              "Received invalid status code: ${dioError.response.statusCode}";
          break;
        case DioErrorType.SEND_TIMEOUT:
          errorDescription = "Send timeout in connection with API server";
          break;
      }
    } else {
      errorDescription = "Unexpected error occured";
    }
    return errorDescription;
  }
}