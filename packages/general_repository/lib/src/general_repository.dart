import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:developer' as developer;

import 'package:authentication_repository/authentication_repository.dart';
import 'package:general_repository/general_repository.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_image_compress/flutter_image_compress.dart' as img;

class GeneralRepository {
  GeneralRepository({
    http.Client? client,
  }) : _client = client ?? http.Client();

  final http.Client _client;
  AuthenticationRepository? _authRepository;

  AuthenticationRepository get authenticationRepository {
    if (_authRepository == null) {
      throw StateError(
          'AuthenticationRepository must be initialized before use.');
    }
    return _authRepository!;
  }

  void initialize(AuthenticationRepository authenticationRepository) {
    _authRepository = authenticationRepository;
  }

  String? get token => authenticationRepository.currentUser.token;

  Map<String, String>? addAuthorizationHeader(Map<String, String>? header) {
    header ??= {};
    if (token != null &&
        token!.isNotEmpty &&
        !header.containsKey('Authorization')) {
      header['Authorization'] = 'Bearer $token';
    }
    return header;
  }

  Map<String, String>? addContentTypeJsonHeader(Map<String, String>? header) {
    header ??= {};
    if (!header.containsKey('Content-Type')) {
      header['Content-Type'] = 'application/json';
    }
    return header;
  }

  Future<String?> fetchNewToken() async {
    final refreshHeader = <String, String>{
      "Authorization":
          "Bearer ${authenticationRepository.currentUser.refreshToken}",
    };

    final refreshUri = Uri.parse("${ApiConfig.baseUrl}refresh-token");
    final refreshTimeout = ApiConfig.responseTimeOut;

    try {
      final refreshResponse = await _client
          .get(refreshUri, headers: refreshHeader)
          .timeout(refreshTimeout);

      if (refreshResponse.statusCode == 200) {
        final responseJson = jsonDecode(refreshResponse.body);
        final newAccessToken = responseJson["accessToken"];
        final newRefreshToken = responseJson["refresh_token"];

        developer.log(
          "Token Successfully Refreshed: ${refreshResponse.statusCode}",
          name: 'fetchNewToken',
        );

        authenticationRepository.updateTokens(newAccessToken, newRefreshToken);

        return newAccessToken;
      } else {
        developer.log(
          "Failed to refresh token: ${refreshResponse.statusCode}",
          name: 'fetchNewToken',
        );
        authenticationRepository.clearUser();
        return null;
      }
    } on SocketException {
      throw FetchDataException("Network error while refreshing token.");
    } on TimeoutException {
      throw TimeOutExceptionC("Token refresh request timed out.");
    }
  }

  Future<dynamic> _handleRequest(
    Future<http.BaseResponse> Function() requestFunction,
    Map<String, String>? header,
    Duration finalTimeout,
    String handle, {
    bool enableLogs = true,
  }) async {
    if (enableLogs) {
      developer.log(
        'Request Header: ${jsonEncode(header)}',
        name: 'package.bloc_rest_api.$handle',
      );
    }

    http.BaseResponse? rawResponse;
    dynamic responseJson;

    try {
      rawResponse = await requestFunction().timeout(finalTimeout);

      if (rawResponse.statusCode == 401) {
        final newToken = await fetchNewToken();

        if (newToken != null) {
          header?.update("Authorization", (_) => "Bearer $newToken");
          rawResponse = await requestFunction().timeout(finalTimeout);
        } else {
          throw Exception("Failed to refresh token. Please login again.");
        }
      }

      responseJson = await _response(rawResponse);
    } on SocketException {
      throw FetchDataException();
    } on TimeoutException {
      throw TimeOutExceptionC();
    } finally {
      if (enableLogs) {
        developer.log(
          'Request Response Status: ${rawResponse?.statusCode}',
          name: 'package.bloc_rest_api.$handle',
        );
        developer.log(
          'Request Raw Response: ${rawResponse is http.Response ? rawResponse.body : ''}',
          name: 'package.bloc_rest_api.$handle',
        );
      }
    }

    return responseJson;
  }

  Future<dynamic> get({
    required String handle,
    String? baseUrl,
    Map<String, String>? header,
    Duration? timeOut,
    bool enableLogs = true,
  }) async {
    header = addAuthorizationHeader(header);
    var uri = Uri.parse((baseUrl ?? ApiConfig.baseUrl) + handle);
    var finalTimeout = timeOut ?? ApiConfig.responseTimeOut;

    return _handleRequest(
      () => _client.get(uri, headers: header),
      header,
      finalTimeout,
      handle,
      enableLogs: enableLogs,
    );
  }

  Future<dynamic> post({
    required String handle,
    dynamic body,
    String? baseUrl,
    Map<String, String>? header,
    Duration? timeOut,
    bool enableLogs = true,
  }) async {
    header = addAuthorizationHeader(header);
    header = addContentTypeJsonHeader(header);
    var uri = Uri.parse((baseUrl ?? ApiConfig.baseUrl) + handle);
    var finalTimeout = timeOut ?? ApiConfig.responseTimeOut;

    if (enableLogs) {
      developer.log(
        'Request Body: $body',
        name: 'package.bloc_rest_api.$handle',
      );
    }

    return _handleRequest(
      () => _client.post(uri, body: body, headers: header),
      header,
      finalTimeout,
      handle,
      enableLogs: enableLogs,
    );
  }

  Future<dynamic> put({
    required String handle,
    dynamic body,
    String? baseUrl,
    Map<String, String>? header,
    Duration? timeOut,
    bool enableLogs = true,
  }) async {
    header = addAuthorizationHeader(header);
    header = addContentTypeJsonHeader(header);
    var uri = Uri.parse((baseUrl ?? ApiConfig.baseUrl) + handle);
    var finalTimeout = timeOut ?? ApiConfig.responseTimeOut;

    return _handleRequest(
      () => _client.put(uri, body: body, headers: header),
      header,
      finalTimeout,
      handle,
      enableLogs: enableLogs,
    );
  }

  Future<dynamic> patch({
    required String handle,
    dynamic body,
    String? baseUrl,
    Map<String, String>? header,
    Duration? timeOut,
    bool enableLogs = true,
  }) async {
    header = addAuthorizationHeader(header);
    header = addContentTypeJsonHeader(header);
    var uri = Uri.parse((baseUrl ?? ApiConfig.baseUrl) + handle);
    var finalTimeout = timeOut ?? ApiConfig.responseTimeOut;

    return _handleRequest(
      () => _client.patch(uri, body: body, headers: header),
      header,
      finalTimeout,
      handle,
      enableLogs: enableLogs,
    );
  }

  Future<dynamic> delete({
    required String handle,
    String? baseUrl,
    Map<String, String>? header,
    Duration? timeOut,
    bool enableLogs = true,
  }) async {
    header = addAuthorizationHeader(header);
    header = addContentTypeJsonHeader(header);
    var uri = Uri.parse((baseUrl ?? ApiConfig.baseUrl) + handle);
    var finalTimeout = timeOut ?? ApiConfig.responseTimeOut;

    return _handleRequest(
      () => _client.delete(uri, headers: header),
      header,
      finalTimeout,
      handle,
      enableLogs: enableLogs,
    );
  }

  Future<dynamic> multipartPost({
    required String handle,
    Map<String, String>? fields,
    List<Map<String, dynamic>>? files,
    String? baseUrl,
    Map<String, String>? header,
    Duration? timeOut,
    bool enableLogs = true,
  }) async {
    header = addAuthorizationHeader(header);
    var uri = Uri.parse((baseUrl ?? ApiConfig.baseUrl) + handle);
    var finalTimeout = timeOut ?? ApiConfig.responseTimeOut;

    if (enableLogs) {
      developer.log(
        'Multipart Request Fields: $fields',
        name: 'package.bloc_rest_api.$handle',
      );
      developer.log(
        'Multipart Request Files: $files',
        name: 'package.bloc_rest_api.$handle',
      );
    }

    var request = await _buildMultipartRequest(uri, fields, files, header);

    return _handleRequest(
      () async => await _client.send(request),
      header,
      finalTimeout,
      handle,
      enableLogs: enableLogs,
    );
  }

  Future<http.MultipartRequest> _buildMultipartRequest(
    Uri uri,
    Map<String, String>? fields,
    List<Map<String, dynamic>>? files,
    Map<String, String>? header,
  ) async {
    var request = http.MultipartRequest('POST', uri)
      ..fields.addAll(fields ?? {})
      ..headers.addAll(header ?? {});

    // File categories
    const imageExtensions = ['jpeg', 'jpg', 'png', 'bmp', 'gif', 'tiff'];
    const documentExtensions = [
      'csv',
      'pdf',
      'kml',
      'kmz'
    ]; // ✅ No processing needed

    if (files != null) {
      for (var file in files) {
        String filePath = file['filePath'];
        String fileExtension = filePath.split('.').last.toLowerCase();

        if (imageExtensions.contains(fileExtension)) {
          // ✅ Validate images
          if (!await _isValidImage(filePath)) {
            throw Exception('Invalid image file: $filePath');
          }
        } else if (documentExtensions.contains(fileExtension)) {
          // ✅ Skip processing for CSV, PDF, KML, KMZ
          developer.log(
              'File type detected: $fileExtension - No processing needed',
              name: 'File Upload');
        } else {
          // ⚠️ Unsupported file type warning
          developer.log('⚠️ Unsupported file type: $filePath',
              name: 'File Upload');
        }

        // Create MultipartFile
        var multipartFile = await http.MultipartFile.fromPath(
          file['fieldName']!,
          filePath,
          filename: file['fileName']!,
        );
        request.files.add(multipartFile);
      }
    }
    return request;
  }

  Future<bool> _isValidImage(String filePath) async {
    final file = File(filePath);
    final bytes = await file.readAsBytes();

    try {
      // Check if file is a valid image
      final result = await img.FlutterImageCompress.compressWithList(
        bytes,
        quality: 1,
      );
      return result.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  Future<dynamic> _response(http.BaseResponse response) async {
    if (response is http.StreamedResponse) {
      var res = await http.Response.fromStream(response);
      return _response(res);
    }

    switch ((response as http.Response).statusCode) {
      case 200:
      case 201:
        return json.decode(response.body.toString());
      case 400:
      case 401:
      case 402:
      case 403:
      case 404:
      case 405:
      case 409:
        throw json.decode(response.body)["message"].toString();
      case 422:
        throw json.decode(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
          'Something went wrong, please try again later.\n\nStatus Code : ${response.statusCode}',
        );
    }
  }
}
