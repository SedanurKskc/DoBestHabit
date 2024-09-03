import 'package:flutter/material.dart';
import '../../core/base/view/base_view.dart';
import '../../core/component/button/app_button.dart';
import '../../core/component/field/text.dart';
import 'auth_viewmodel.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});
  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends AuthViewmodel {
  @override
  Widget build(BuildContext context) {
    return BaseView(
        extendBodyBehindAppBar: true,
        backgroundColor: colorScheme.primary,
        body: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: deviceHeight / 1.4,
                  decoration: BoxDecoration(color: colorScheme.background, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(sizes.s100), bottomRight: Radius.circular(sizes.s100))),
                ),
                Padding(
                  padding: paddings.t(sizes.s100),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        Text(
                          "NextHabit",
                          style: textTheme.headlineLarge!.copyWith(color: colorScheme.primary),
                        ),
                        SizedBox(
                          height: deviceWidth / 10,
                        ),
                        Image.asset(
                          "assets/images/lifestyle.png",
                          height: deviceWidth / 5,
                        ),
                        SizedBox(
                          height: deviceWidth / 10,
                        ),
                        Padding(
                          padding: paddings.h(sizes.s20),
                          child: CustomField(
                            controller: emailController,
                            hintText: emailHintText,
                          ),
                        ),
                        SizedBox(
                          height: deviceWidth / 15,
                        ),
                        Padding(
                          padding: paddings.h(sizes.s20),
                          child: CustomField(
                            controller: passController,
                            hintText: passHinttext,
                            obscureText: true,
                          ),
                        ),
                        SizedBox(
                          height: deviceWidth / 15,
                        ),
                        Visibility(
                          visible: !isLoginMode,
                          child: Padding(
                            padding: paddings.h(sizes.s20),
                            child: CustomField(
                              controller: passagainController,
                              hintText: passAgainHintText,
                              obscureText: true,
                            ),
                          ),
                        ),
                        SizedBox(height: sizes.s20),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              questionTitle,
                              style: textTheme.bodyMedium?.copyWith(color: colorScheme.primary, fontWeight: FontWeight.w700),
                            ),
                            TextButton(
                              onPressed: changeType,
                              child: Text(
                                changeButtonTitle,
                                style: textTheme.bodyMedium?.copyWith(color: colorScheme.onPrimary, fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: deviceWidth / 4,
            ),
            AppButton.zero(variant: ButtonVariant.secondary, title: buttonTitle.toUpperCase(), padding: sizes.s60, onPressed: save)
          ],
        ));
  }
}
