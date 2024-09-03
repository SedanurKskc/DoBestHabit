import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import '../../../setup.dart';
import '../../alert/manager.dart';
import '../../connection/manager.dart';
import '../../memory/prefs/prefs_manager.dart';
import '../../navigate/manager.dart';
import 'api_path.dart';
export 'api_path.dart';

class ApiManager {
  static ApiManager? _instance;
  static ApiManager get instance {
    _instance ??= ApiManager._init();
    return _instance!;
  }

  ApiManager._init();

  Map<String, String> _headers(bool authRequired, {Map<String, String>? headers}) {
    Map<String, String> temp = {'content-type': 'application/json'};
    if (authRequired && (_userToken?.isNotEmpty ?? false)) {
      temp.addAll({"Authorization": 'Bearer $_userToken'});
    }
    if (headers != null) temp.addAll(headers);
    return temp;
  }

  String? get _userToken => PreferencesManager.getStringVal(PrefsKeys.token);

  Uri _url(ApiPath path, Map<String, dynamic>? params, dynamic endPath) {
    AppMode appMode = ApplicationSetup.instance.appMode;
    params = params?.map((key, value) => MapEntry(key, value.toString()));
    switch (appMode) {
      case AppMode.test:
        if (endPath == null) {
          return Uri.https(appMode.url, '${appMode.path}/${path.path}', params);
        } else {
          return Uri.https(appMode.url, '${appMode.path}/${path.path}/$endPath', params);
        }
      case AppMode.dev:
        if (endPath == null) {
          return Uri.https(appMode.url, '${appMode.path}/${path.path}', params);
        } else {
          return Uri.https(appMode.url, '${appMode.path}/${path.path}/$endPath', params);
        }
      case AppMode.product:
        if (endPath == null) {
          return Uri.https(appMode.url, '${appMode.path}/${path.path}', params);
        } else {
          return Uri.https(appMode.url, '${appMode.path}/${path.path}/$endPath', params);
        }
    }
  }

  dynamic _decodeBody(String body, bool hasResponse, bool showSnack) {
    if (!hasResponse) return true;
    if (body.isEmpty) return null;
    dynamic decodedBody = jsonDecode(body);
    if (decodedBody is Map || decodedBody is List || decodedBody is double || decodedBody is int) {
      return decodedBody;
    } else if (decodedBody['message'] != null && showSnack) {
      AlertManager.instance.showSnack(SnackType.error, message: decodedBody['message']);
      return null;
    } else {
      return null;
    }
  }

  Future<dynamic> create({required ApiPath path, Map<String, dynamic>? params, dynamic body, Map<String, String>? headers, ApiOptions? options, dynamic endPath}) async {
    return await _request(RequestTypes.create, path, options ?? const ApiOptions(), body: body, headers: headers, params: params, endPath: endPath);
  }

  Future<dynamic> read({required ApiPath path, Map<String, dynamic>? params, dynamic body, Map<String, String>? headers, ApiOptions? options, dynamic endPath}) async {
    return await _request(RequestTypes.read, path, options ?? const ApiOptions(), body: body, headers: headers, params: params, endPath: endPath);
  }

  Future<dynamic> update({required ApiPath path, Map<String, dynamic>? params, dynamic body, Map<String, String>? headers, ApiOptions? options, dynamic endPath}) async {
    return await _request(RequestTypes.update, path, options ?? const ApiOptions(), body: body, headers: headers, params: params, endPath: endPath);
  }

  Future<dynamic> delete({required ApiPath path, Map<String, dynamic>? params, dynamic body, Map<String, String>? headers, ApiOptions? options, dynamic endPath}) async {
    return await _request(RequestTypes.delete, path, options ?? const ApiOptions(), body: body, headers: headers, params: params, endPath: endPath);
  }

  Future<dynamic> _request(RequestTypes requestType, ApiPath path, ApiOptions options, {dynamic body, Map<String, String>? headers, Map<String, dynamic>? params, dynamic endPath}) async {
    Logger().d("Auth Required: ${options.authRequired}\nPATH: ${path.path}\nURL:${_url(path, params, endPath)}");
    try {
      bool connected = await ConnectionManager.instance.checkConnection();
      if (!connected) {
        bool? res = await NavigationManager.instance.nav(path: NavPath.splash);
        if (res ?? false) {
          return await _request(requestType, path, options, body: body, headers: headers, params: params, endPath: endPath);
        } else {
          exit(0);
        }
      }
      http.Response res;
      switch (requestType) {
        case RequestTypes.create:
          res = await http.post(_url(path, params, endPath), headers: _headers(options.authRequired, headers: headers), body: options.encode ? jsonEncode(body) : body);
          break;
        case RequestTypes.read:
          res = await http.get(_url(path, params, endPath), headers: _headers(options.authRequired, headers: headers));
          break;
        case RequestTypes.update:
          res = await http.put(_url(path, params, endPath), headers: _headers(options.authRequired, headers: headers), body: jsonEncode(body));
          break;
        case RequestTypes.delete:
          res = await http.delete(_url(path, params, endPath), headers: _headers(options.authRequired, headers: headers), body: jsonEncode(body));
          break;
      }
      if (res.statusCode == HttpStatus.ok) {
        Logger().d("STATUS CODE: ${res.statusCode}\nPATH: ${path.path}");
        return _decodeBody(res.body, options.hasResponse, options.showSnack);
      } else if (res.statusCode == HttpStatus.badRequest) {
        Logger().w("STATUS CODE: ${res.statusCode}\nPATH: ${path.path}");
        return null;
      } else if (res.statusCode == HttpStatus.unauthorized) {
        Logger().w("STATUS CODE: ${res.statusCode}\nPATH: ${path.path}");
        return await _request(requestType, path, options, body: body, headers: headers, params: params, endPath: endPath);
      } else {
        Logger().e("STATUS CODE: ${res.statusCode}\nBODY: ${res.body}");
        return null;
      }
    } on HttpException catch (e) {
      Logger().e("MESSAGE: ${e.message}\nURL: ${e.uri}");
      return null;
    } on TimeoutException catch (e) {
      Logger().e("MESSAGE: ${e.message}\nDURATION: ${e.duration}");
      return null;
    } on Exception catch (e) {
      Logger().e("ERROR: $e");
      return null;
    }
  }
}

enum RequestTypes { create, read, update, delete }

class ApiOptions {
  final bool authRequired;
  final bool hasResponse;
  final bool showSnack;
  final bool encode;

  const ApiOptions({this.authRequired = false, this.hasResponse = true, this.showSnack = true, this.encode = true});
}
