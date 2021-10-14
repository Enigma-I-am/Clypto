import 'package:clypto/data/config/exceptions.dart';
import 'package:clypto/utils/clypto_logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

abstract class BaseApi {
  late Dio dio;
  final url = dotenv.env['API_URL']!;
  final aipkey = dotenv.env['API_KEY']!;

  BaseApi() {
    final options = BaseOptions(
      baseUrl: "https://$url",
      receiveDataWhenStatusError: true,
      connectTimeout: 60 * 1000, // 60 seconds
      receiveTimeout: 60 * 1000, // 60 seconds
      headers: {'X-CoinAPI-Key': aipkey},
    );

    dio = Dio(options);
    if (kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90,
        ),
      );
    }
  }

  Future<Map<String, dynamic>> get(path, {Map<String, dynamic> headers = const {}}) => makeRequest(
        dio.get(
          "/$path",
          options: Options(
            headers: {
              ...headers, // set content-length
            },
          ),
        ),
      );

  Future<Map<String, dynamic>> post(path, {Map<String, dynamic>? data, Map<String, dynamic> headers = const {}}) =>
      makeRequest(
        dio.post(
          "/$path",
          data: data,
          options: Options(
            headers: {
              ...headers, // set content-length
            },
          ),
        ),
      );

  Future<Map<String, dynamic>> patch(path, {Map<String, dynamic>? data, Map<String, dynamic> headers = const {}}) =>
      makeRequest(
        dio.patch(
          "/$path",
          data: data,
          options: Options(
            headers: {
              ...headers, // set content-length
            },
          ),
        ),
      );

  Future<Map<String, dynamic>> put(path, {Map<String, dynamic>? data, Map<String, dynamic> headers = const {}}) =>
      makeRequest(
        dio.put(
          "/$path",
          data: data,
          options: Options(
            headers: {
              ...headers, // set content-length
            },
          ),
        ),
      );

  Future<Map<String, dynamic>> delete(path, {Map<String, dynamic> headers = const {}}) => makeRequest(
        dio.delete(
          "/$path",
          options: Options(
            headers: {
              ...headers, // set content-length
            },
          ),
        ),
      );

  Future<Map<String, dynamic>> makeRequest(Future<Response> future) async {
    try {
      var req = await future;

      var data = req.data;

      if ("${req.statusCode}".startsWith('2') || (data["success"] != null && data["success"])) {
        if (data is Map<String, dynamic>) {
          return data;
        } else {
          return {'data': data};
        }
      }

      if (data['error'] != null) {
        throw Exception(data["error"]);
      }

      throw Exception(data["message"]);
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout || e.type == DioErrorType.other) {
        throw CustomException("Connection  Timeout Exception");
      }

      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        if (e.response?.data != null && e.response!.data is Map) {
          if (e.response!.data['message'] != null) {
            throw CustomException(e.response!.data['message']);
          } else if (e.response!.data['error'] != null) {
            throw CustomException(e.response!.data['error']);
          } else {
            throw CustomException(e.message);
          }
        }
        throw CustomException(e.response?.data);
      } else if ("${e.response?.statusCode}".startsWith('5')) {
        throw CustomException("Connection  Timeout Exception");
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        throw CustomException(e.message);
      }
    } catch (err) {
      if (err is DioError) {
        //handle DioError here by error type or by error code

        MyLogger.logger.d("dio error => ${err.message}");
        throw CustomException(err.message);
      } else {
        // print("other error => $err");
        MyLogger.logger.d('Check here ${err.toString()}');
        throw CustomException('Something went wrong');
      }
    }
  }

  // dynamic getErrorMessage(err) {
  //   if (err != null && err.name != null && "${err.name}".isNotEmpty) {
  //     return err.name;
  //   }
  //   return "Unknown error";
  // }

  dynamic parseErrorMessage(Map<String, dynamic>? err) {
    if (err != null) {
      if (err['message'] != null) {
        return err['message'];
      }

      if (err['error'] != null) {
        return err['error'];
      }

      if (err['errors'] != null) {
        if (err['errors'] is Map) {
          var values = (err['errors'] as Map).values;
          return values.join(", ");
        }
        return err['errors'];
      }
    }
    return "Unknown error";
  }
}
