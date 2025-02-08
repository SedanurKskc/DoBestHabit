import 'package:dobesthabit/modules/auth/manager.dart';
import 'package:flutter/material.dart';
import '../../core/base/state/base_state.dart';
import '../../core/modules/alert/manager.dart';
import 'profile_view.dart';

abstract class ProfileViewmodel extends BaseState<ProfileView> {
  final TextEditingController currentEmailController = TextEditingController();
  final TextEditingController newEmailController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController passwordAgainController = TextEditingController();

  final String currentEmailHintText = "Mevcut E-posta";
  final String newEmailHintText = "Yeni E-posta";
  final String newPasswordHintText = "Yeni Şifre";
  final String passwordAgainHintText = "Yeni Şifre (Tekrar)";

  final AuthManager _authManager = AuthManager();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    currentEmailController.dispose();
    newEmailController.dispose();
    newPasswordController.dispose();
    passwordAgainController.dispose();
    super.dispose();
  }

  Future<bool> updateProfile({
    required String currentEmail,
    required String newEmail,
    required String newPassword,
    required String passwordAgain,
  }) async {
    bool emailChanged = newEmail.isNotEmpty;
    bool passwordChanged = newPassword.isNotEmpty && newPassword == passwordAgain;

    if (!emailChanged && !passwordChanged) {
      AlertManager.instance.showSnack(SnackType.error, message: "E-posta veya şifre girilmelidir.");
      return false;
    }

    if (emailChanged && currentEmail.isEmpty) {
      AlertManager.instance.showSnack(SnackType.error, message: "Mevcut e-posta adresi boş bırakılamaz.");
      return false;
    }

    if (emailChanged && !emailChanged) {
      AlertManager.instance.showSnack(SnackType.error, message: "Yeni e-posta adresi boş olamaz.");
      return false;
    }

    if (passwordChanged && !passwordChanged) {
      AlertManager.instance.showSnack(SnackType.error, message: "Şifreler eşleşmiyor veya boş.");
      return false;
    }

    bool emailUpdated = false;
    bool passwordUpdated = false;

    try {
      if (emailChanged) {
        await _authManager.updateEmail(newEmail);
        emailUpdated = true;
      }
      if (passwordChanged) {
        await _authManager.updatePassword(newPassword,passwordAgain);
        passwordUpdated = true;
      }
    } catch (e) {
      if (e.toString().contains('requires-recent-login')) {
        AlertManager.instance.showSnack(SnackType.error, message: "Bu işlem için yeniden giriş yapmanız gerekiyor.");
      } else {
        AlertManager.instance.showSnack(SnackType.error, message: "Güncelleme yapılamadı: ${e.toString()}");
      }
    }

    return emailUpdated || passwordUpdated;
  }
}
