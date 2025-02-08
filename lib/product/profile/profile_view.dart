import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../core/base/view/base_view.dart';
import '../../core/component/button/app_button.dart';
import '../../core/component/field/text.dart';
import '../../core/modules/alert/manager.dart';
import '../../core/modules/alert/snack.dart';
import 'profile_viewmodel.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});
  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends ProfileViewmodel {
  @override
  Widget build(BuildContext context) {
    return BaseView(
      appBar: CivcivAppBar(
        title: "Profili Güncelle",
      ),
      body: Padding(
        padding: paddings.v(sizes.s20),
        child: Column(
          children: [
            Padding(
              padding: paddings.h(sizes.s20) + paddings.b(sizes.s20),
              child: CustomField(
                controller: currentEmailController,
                hintText: currentEmailHintText,
              ),
            ),
            Padding(
              padding: paddings.h(sizes.s20) + paddings.b(sizes.s20),
              child: CustomField(
                controller: newEmailController,
                hintText: newEmailHintText,
              ),
            ),
            Padding(
              padding: paddings.h(sizes.s20) + paddings.b(sizes.s20),
              child: CustomField(
                controller: newPasswordController,
                hintText: newPasswordHintText,
                obscureText: true,
              ),
            ),
            Padding(
              padding: paddings.h(sizes.s20) + paddings.b(sizes.s20),
              child: CustomField(
                controller: passwordAgainController,
                hintText: passwordAgainHintText,
                obscureText: true,
              ),
            ),
            SizedBox(
              height: deviceWidth / 1.1,
            ),
            AppButton.zero(
              variant: ButtonVariant.primary,
              title: "Güncelle".toUpperCase(),
              padding: sizes.s60,
              onPressed: () async {
                final currentEmail = currentEmailController.text.trim();
                final newEmail = newEmailController.text.trim();
                final newPassword = newPasswordController.text;
                final passwordAgain = passwordAgainController.text;

                if (currentEmail.isEmpty || newEmail.isEmpty || newPassword.isEmpty || passwordAgain.isEmpty) {
                  AlertManager.instance.showSnack(SnackType.error, message: "Tüm alanları doldurmalısınız.");
                  return;
                }

                if (newPassword != passwordAgain) {
                  AlertManager.instance.showSnack(SnackType.error, message: "Şifreler eşleşmiyor.");
                  return;
                }

                try {
                  final user = FirebaseAuth.instance.currentUser;

                  if (user == null) {
                    AlertManager.instance.showSnack(SnackType.error, message: "Giriş yapılmış bir kullanıcı bulunmuyor.");
                    return;
                  }

                  if (user.email?.trim().toLowerCase() != currentEmail.toLowerCase()) {
                    AlertManager.instance.showSnack(SnackType.error, message: "Mevcut e-posta adresi yanlış.");
                    return;
                  }

                  final result = await updateProfile(
                    currentEmail: currentEmail,
                    newEmail: newEmail,
                    newPassword: newPassword,
                    passwordAgain: passwordAgain,
                  );

                  if (result) {
                    AlertManager.instance.showSnack(SnackType.success, message: "Profil başarıyla güncellendi.");
                  } else {
                    AlertManager.instance.showSnack(SnackType.error, message: "Profil güncellenmedi.");
                  }
                } catch (e) {
                  AlertManager.instance.showSnack(SnackType.error, message: "Bir hata oluştu: ${e.toString()}");
                }
              },
            )
          ],
        ),
      ),
    );
  }



}
