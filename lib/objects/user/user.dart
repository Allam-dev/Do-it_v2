import 'package:do_it_flutter_v2/objects/user/responses/sign_in_response.dart';
import 'package:do_it_flutter_v2/objects/user/responses/sign_up_response.dart';
import 'package:do_it_flutter_v2/services/local/shared_preferences/shared_preferences_keys.dart';
import 'package:do_it_flutter_v2/services/local/shared_preferences/shared_preferences_services.dart';
import 'package:do_it_flutter_v2/services/remote/api/http_services.dart';
import 'package:do_it_flutter_v2/utils/log.dart';

class User {
  final HttpServices _httpServices = HttpServices.singleton;
  final SharedPreferencesServices _sharedPreferencesServices =
      SharedPreferencesServices.singleton;

  static int _id = 0;
  static String _jwt = "";


  save({required int id, required String jwt}) async {
    _id = id;
    _jwt = jwt;
    await _sharedPreferencesServices.setInt(
        key: SharedPreferencesKeys.userId, value: id);
    await _sharedPreferencesServices.setString(
        key: SharedPreferencesKeys.jwt, value: jwt);
  }

  // check if user is sorted
  check({Function()? found, Function()? notFound}) async {
    int? id = await _sharedPreferencesServices.getInt(
        key: SharedPreferencesKeys.userId);
    String? jwt = await _sharedPreferencesServices.getString(
        key: SharedPreferencesKeys.jwt);

    if (id == null && jwt == null) {
      if (notFound != null) notFound();
    } else {
      _id = id!;
      _jwt = jwt!;
      if (found != null) found();
    }
  }

  Future<void> signIn(
      {required String email,
      required String password,
      Function(SignInResponse)? onSuccess,
      Function(int)? onError,
      Function()? onConnectionError}) async {
    Map<String, String> body = {
      "identifier": "$email",
      "password": "$password",
    };
    if (email.isEmpty || password.isEmpty) {
      Log.error("email and password required");
    } else {
      await _httpServices.post<SignInResponse>(
        endpoint: "auth/local",
        requestName: "Sign In",
        responseModel: SignInResponse(),
        body: body,
        onSuccess: onSuccess,
        onError: onError,
        onConnectionError: onConnectionError,
      );
    }
  }

  Future<void> signUp(
      {required String email,
      required String password,
      required String name,
      Function(SignUpResponse)? onSuccess,
      Function(int)? onError,
      Function()? onConnectionError}) async {
    Map<String, String> body = {
      "username": "$name",
      "email": "$email",
      "password": "$password",
    };
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      Log.error("name , password and email are required");
    } else {
      await _httpServices.post<SignUpResponse>(
        endpoint: "auth/local/register",
        requestName: "Sign Up",
        responseModel: SignUpResponse(),
        body: body,
        onSuccess: onSuccess,
        onError: onError,
        onConnectionError: onConnectionError,
      );
    }
  }

  logOut() {}

  static int get id => _id;
  static String get jwt => _jwt;

}