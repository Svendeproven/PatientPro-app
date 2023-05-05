import 'package:exam_app/models/user.dart';
import 'package:exam_app/services/api.dart';
import 'package:flutter/material.dart';

/// View model for user
class UserViewModel extends ChangeNotifier {
  // This is the current user
  User? _user;

  /// Get user
  User? get user => _user;

  /// This is a setter that can be used to set the current user
  ///
  /// [user] is the user to set
  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  /// This is a method that can be used to get the current user async from the server
  ///
  /// Returns a [User]
  Future<User?> getUserAsync() async {
    if (_user == null) {
      var response = await Api.get("user/current");
      _user = User.fromJson(response);
      notifyListeners();
    }
    return _user;
  }
}
