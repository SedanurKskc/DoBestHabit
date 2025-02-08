import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../core/modules/alert/manager.dart';
import '../../core/modules/alert/snack.dart';
import '../../core/modules/memory/prefs/prefs_manager.dart';
import '../../core/modules/navigate/manager.dart';

class AuthManager {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Giriş yapma
  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      PreferencesManager.setBoolVal(PrefsKeys.userLoggedIn, true);
      NavigationManager.instance.clear(path: NavPath.home);
    } catch (e) {
      AlertManager.instance.showSnack(SnackType.error, message: "Giriş yapılamadı: ${e.toString()}");
    }
  }

  // Şifre doğrulama
  String? validatePassword(String password, String passwordAgain) {
    if (password != passwordAgain) {
      return "Şifreler uyuşmuyor";
    }
    if (password.length < 8) {
      return "Şifre en az 8 karakter uzunluğunda olmalıdır.";
    }
    if (!RegExp(r"(?=.*[a-z])").hasMatch(password)) {
      return "Şifre en az bir küçük harf içermelidir.";
    }
    if (!RegExp(r"(?=.*[A-Z])").hasMatch(password)) {
      return "Şifre en az bir büyük harf içermelidir.";
    }
    if (!RegExp(r"(?=.*\d)").hasMatch(password)) {
      return "Şifre en az bir rakam içermelidir.";
    }
    return null;
  }

  // Kayıt olma
  Future<void> register(String email, String password, String passwordAgain) async {
    if (!_isEmailValid(email)) {
      AlertManager.instance.showSnack(SnackType.error, message: "Geçersiz e-posta adresi");
      return;
    }

    String? passwordError = validatePassword(password, passwordAgain);

    if (passwordError != null) {
      AlertManager.instance.showSnack(SnackType.error, message: passwordError);
      return;
    }

    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      AlertManager.instance.showSnack(SnackType.success, message: "Kayıt başarılı!");
    } catch (e) {
      AlertManager.instance.showSnack(SnackType.error, message: "Kayıt yapılamadı: ${e.toString()}");
    }
  }


Future<void> updateEmail(String newEmail) async {
  User? user = _auth.currentUser;

  if (user == null) {
    AlertManager.instance.showSnack(SnackType.error, message: "Kullanıcı oturumu açık değil");
    return;
  }

  if (!_isEmailValid(newEmail)) {
    AlertManager.instance.showSnack(SnackType.error, message: "Geçersiz e-posta adresi");
    return;
  }

  try {
    await user.updateEmail(newEmail);
    await user.sendEmailVerification();
    AlertManager.instance.showSnack(SnackType.success, message: "Yeni e-posta adresine doğrulama e-postası gönderildi.");
  } catch (e) {
    AlertManager.instance.showSnack(SnackType.error, message: "E-posta güncellenemedi: ${e.toString()}");
  }
}


  // Şifre güncelleme
  Future<void> updatePassword(String newPassword, String passwordAgain) async {
    User? user = _auth.currentUser;

    if (user == null) {
      AlertManager.instance.showSnack(SnackType.error, message: "Kullanıcı oturumu açık değil");
      return;
    }

    String? passwordError = validatePassword(newPassword, passwordAgain);
    if (passwordError != null) {
      AlertManager.instance.showSnack(SnackType.error, message: passwordError);
      return;
    }

    try {
      await user.updatePassword(newPassword);
      AlertManager.instance.showSnack(SnackType.success, message: "Şifre güncellendi");
    } catch (e) {
      AlertManager.instance.showSnack(SnackType.error, message: "Şifre güncellenemedi: ${e.toString()}");
    }
  }


  bool _isEmailValid(String email) {
    RegExp emailRegExp = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    return emailRegExp.hasMatch(email);
  }

  // Şifre geçerliliğini kontrol etme
  bool _isPasswordValid(String password, String passwordAgain) {
    RegExp passwordRegExp = RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$");
    return password == passwordAgain && passwordRegExp.hasMatch(password);
  }
}
