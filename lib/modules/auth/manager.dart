import 'package:dobesthabit/core/modules/alert/manager.dart';
import 'package:dobesthabit/core/modules/memory/prefs/prefs_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../core/modules/navigate/manager.dart';

class AuthManager {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      PreferencesManager.setBoolVal(PrefsKeys.userLoggedIn, true);
      NavigationManager.instance.clear(path: NavPath.home);
    } catch (e) {
      AlertManager.instance.showSnack(SnackType.error, message: "Giriş yapılamadı: ${e.toString()}");
    }
  }

  String? validetePassword(String password, String passwordAgain) {
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

  Future<void> register(String email, String password, String passwordAgain) async {
    if (!_isEmailValid(email)) {
      AlertManager.instance.showSnack(SnackType.error, message: "Geçersiz e-posta adresi");
      return;
    }

    String? passwordError = validetePassword(password, passwordAgain);

    if (passwordError != null) {
      AlertManager.instance.showSnack(SnackType.error, message: passwordError);
    }

    if (!_isPasswordValid(password, passwordAgain))
      try {
        await _auth.createUserWithEmailAndPassword(email: email, password: password);
        AlertManager.instance.showSnack(SnackType.success, message: "Kayıt başarılı!");
      } catch (e) {
        print("Kayıt sırasında hata: $e"); // Hata mesajını konsola yazdırır
        AlertManager.instance.showSnack(SnackType.error, message: "Kayıt yapılamadı: ${e.toString()}");
      }
  }

  bool _isEmailValid(String email) {
    RegExp emailRegExp = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    return emailRegExp.hasMatch(email);
  }

  bool _isPasswordValid(String password, String passwordAgain) {
    RegExp passwordRegExp = RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$");
    return password == passwordAgain && passwordRegExp.hasMatch(password);
  }
}
