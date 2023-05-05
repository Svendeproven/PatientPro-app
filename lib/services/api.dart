import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:exam_app/services/auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Api service for making requests to the backend
class Api {
  /// Base url for the backend
  static final String _baseUrl = dotenv.get('URL');

  /// Default headers for the requests
  static const defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  /// Creates a dio instance with the default headers and a custom interceptor
  static Dio _dio() {
    BaseOptions options = BaseOptions(
        baseUrl: _baseUrl,
        contentType: Headers.jsonContentType,
        headers: defaultHeaders);

    var dio = Dio(options);

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Get token from storage
        String? token = await Auth.getToken();
        if (token != null) {
          // Add token to headers
          options.headers = {
            ...defaultHeaders,
            'Authorization': 'Bearer $token'
          };
        }
        return handler.next(options);
      },
      onError: (e, handler) {
        return handler.next(e);
      },
      onResponse: (e, handler) {
        // If response is 401 (Unauthorized) remove token from storage
        if (e.statusCode == 401) {
          // Remove token from storage
          Auth.removeToken();
        }
        return handler.next(e);
      },
    ));

    // This is needed to allow self signed certificates
    (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return null;
    };

    return dio;
  }

  /// Get request
  ///
  /// [path] is the path to the endpoint
  /// returns a [Response.data] that is the response data from the server
  static Future<dynamic> get(String path) async {
    try {
      final response = await _dio().get(_baseUrl + path);
      return response.data;
    } catch (e) {
      return null;
    }
  }

  /// Post request
  ///
  /// [path] is the path to the endpoint
  /// [body] is the body of the request
  /// returns a [Response] that is the response from the server
  static Future<Response?> post(String path, dynamic body) async {
    try {
      final response = await _dio().post(
        _baseUrl + path,
        data: json.encode(body),
      );
      return response;
    } catch (e) {
      var error = e as DioError;
      return error.response;
    }
  }

  /// Put request
  ///
  /// [path] is the path to the endpoint
  /// [body] is the body of the request
  /// returns a [Response.data] that is the response data from the server
  static Future<dynamic> put(String path, dynamic body) async {
    try {
      final response = await _dio().put(
        _baseUrl + path,
        data: json.encode(body),
      );
      return response.data;
    } catch (e) {
      var error = e as DioError;
      return error.response;
    }
  }
}
