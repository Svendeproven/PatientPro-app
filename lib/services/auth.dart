import 'package:exam_app/exceptions/unauthorized_exception.dart';
import 'package:exam_app/models/user.dart';
import 'package:exam_app/services/api.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Auth service for handling authentication and user data
class Auth {
  static const _storage = FlutterSecureStorage();

  /// Get token from secure storage
  ///
  /// returns a [String] that is the token
  static Future<String?> getToken() async {
    try {
      String? token = await _storage.read(key: "token");
      return token;
    } catch (e) {
      return null;
    }
  }

  /// Set token in secure storage
  static Future<void> setToken(String token) async {
    try {
      await _storage.write(key: "token", value: token);
      return;
    } catch (e) {
      return;
    }
  }

  /// Remove token from secure storage
  static Future<void> removeToken() async {
    try {
      await _storage.delete(key: "token");
    } catch (e) {
      return;
    }
  }

  /// Sign in user
  ///
  /// [email] is the email of the user
  /// [password] is the password of the user
  /// returns a [User] that is the user that is signed in
  static Future<User?> signIn(String email, String password) async {
    // Get token from FCM
    final fcmToken = await FirebaseMessaging.instance.getToken();

    // Send request to server
    var response = await Api.post("login",
        {"email": email, "password": password, "deviceToken": fcmToken});

    // switch on response code
    switch (response!.statusCode) {
      case 200:
        // Set token in secure storage
        await setToken(response.data["token"]);
        // Return user
        return User.fromJson(response.data["user"]);
      case 401:
        throw UnauthorizedException("Forkert email eller password");
      case 404:
        throw UnauthorizedException("Forkert email eller password");
      default:
        throw Exception("Der skete en fejl");
    }
  }

  /// Sign out user
  ///
  /// [User] is the user that is being signed out
  /// returns a [bool] that is true if sign out was successful
  static Future<bool> signOut(User user) async {
    // Get token from FCM
    final fcmToken = await FirebaseMessaging.instance.getToken();

    // Send request to server
    var response =
        await Api.post("signout", {"deviceToken": fcmToken, "userId": user.id});

    // Check if response is 204
    if (response!.statusCode == 204 || response.statusCode == 403) {
      // Remove token from secure storage
      await removeToken();
      // Sign out was successful return true
      return true;
    }
    // Sign out was not successful return false
    return false;
  }
}
