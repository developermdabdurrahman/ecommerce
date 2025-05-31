import 'dart:convert';
import 'package:ecommerce/feature/auth/ui/controller/auth_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';

class NetworkResponse {
  final int statusCode;
  final Map<String, dynamic>? responseData;
  final bool isSuccess;
  final String errorMessage;

  NetworkResponse({
    required this.isSuccess,
    required this.statusCode,
    this.responseData,
    this.errorMessage = 'Something went wrong!',
  });
}

class NetworkCaller {
  final Logger _logger = Logger();

  Future<NetworkResponse> getRequest({
    required String url,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      url += '?';
      for (String key in queryParams?.keys ?? {}) {
        url += '$key=${queryParams![key]}&';
      }

      Uri uri = Uri.parse(url);
      Map<String, String> headers = {'token':Get.find<AuthController>().token??''};

      _logRequest(url, headers);
      Response response = await get(uri, headers: headers);
      _logResponse(url, response);

      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodedResponse,
        );
      } else if (response.statusCode == 401) {
        await _clearUserData();
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: decodedResponse['msg'],
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: decodedResponse['msg'],
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  Future<NetworkResponse> postRequest({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {
        'content-type': 'application/json',
        'token':  Get.find<AuthController>().token??'',
      };

      _logRequest(url, headers, requestBody: body);
      Response response = await post(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );
      _logResponse(url, response);

      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodedResponse,
        );
      } else if (response.statusCode == 401) {
        await _clearUserData();
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: decodedResponse['msg'],
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: decodedResponse['msg'],
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  Future<NetworkResponse> putRequest({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {
        'content-type': 'application/json',
        'token':  Get.find<AuthController>().token??'',
      };

      _logRequest(url, headers);
      Response response = await put(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );
      _logResponse(url, response);

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodedResponse,
        );
      } else if (response.statusCode == 401) {
        await _clearUserData();
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  Future<NetworkResponse> patchRequest({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {
        'content-type': 'application/json',
        'token':  Get.find<AuthController>().token??'',
      };

      _logRequest(url, headers);
      Response response = await patch(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );
      _logResponse(url, response);

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodedResponse,
        );
      } else if (response.statusCode == 401) {
        await _clearUserData();
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  Future<NetworkResponse> deleteRequest({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'token': Get.find<AuthController>().token ?? '',
      };
      _logRequest(url, headers);
      Response response;
      if (body != null && body.isNotEmpty) {
        response = await delete(
          uri,
          headers: headers,
          body: jsonEncode(body),
        );
      } else {
        response = await delete(
          uri,
          headers: headers,
        );
      }
      _logResponse(url, response);

      // Process the response and return a NetworkResponse
      return NetworkResponse(
        isSuccess: response.statusCode == 200,
        statusCode: response.statusCode,
        responseData: jsonDecode(response.body),
      );
    } catch (e) {
      // Handle exceptions and return a NetworkResponse
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> _clearUserData() async {
    await Get.find<AuthController>().clearUserData();
  }

  void _logRequest(
    String url,
    Map<String, dynamic> headers, {
    Map<String, dynamic>? requestBody,
  }) {
    _logger.i("URL => $url\nHeaders: $headers\nBody: $requestBody");
  }

  void _logResponse(String url, Response response) {
    _logger.i(
      "URL => $url\nStatus Code: ${response.statusCode}\nHeaders: ${response.headers}\nBody: ${response.body}",
    );
  }
}
