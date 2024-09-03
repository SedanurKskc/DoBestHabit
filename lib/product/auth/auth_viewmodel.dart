import 'package:dobesthabit/product/auth/auth_view.dart';
import 'package:dobesthabit/product/auth/text.dart';
import 'package:flutter/material.dart';
import '../../core/base/state/base_state.dart';
import '../../core/modules/navigate/manager.dart';
import '../../modules/auth/manager.dart';

abstract class AuthViewmodel extends BaseState<AuthView> with text {
  bool isLoginMode = true;
  String get questionTitle => isLoginMode ? "Hesabınız yok mu ?" : "Hesabınız var mı ?";
  String get changeButtonTitle => isLoginMode ? "Kayıt Ol" : "Giriş Yap";
  String get buttonTitle => !isLoginMode ? "Kayıt Ol" : "Giriş Yap";

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController passagainController = TextEditingController();

  changeType() {
    emailController.text = "";
    passController.text = "";
    passagainController.text = "";
    setState(() {
      isLoginMode = !isLoginMode;
    });
  }

  onInfoPressed() async {
    await NavigationManager.instance.nav(path: NavPath.onboarding);
  }

  save() async {
    AuthManager _manager = AuthManager();
    if (isLoginMode) {
      await _manager.login(emailController.text, passController.text);
    } else {
      await _manager.register(emailController.text, passController.text, passagainController.text);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
