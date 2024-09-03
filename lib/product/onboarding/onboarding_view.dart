import 'package:flutter/material.dart';
import '../../core/base/view/base_view.dart';
import '../../core/component/box/background_box.dart';
import '../../core/component/dot/onboard_dot.dart';
import 'onboarding_viewmodel.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});
  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends OnboardingViewmodel {
  @override
  Widget build(BuildContext context) {
    return BaseView(
      backgroundColor: colorScheme.primary,
      body: Stack(
        children: [
          BackgroundBox(),
          Padding(
            padding: paddings.h(sizes.s20),
            child: Column(
              children: [
                SizedBox(height: emptyTop - sizes.s20),
                Visibility(
                    visible: currentIndex != 2,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        onPressed: onSkipPressed,
                        child: Text(
                          "Atla",
                          style: textTheme.headlineSmall!.copyWith(color: colorScheme.onSurface),
                        ),
                      ),
                    )),
                body(),
                OnboardDot(length: itemLength, currentIndex: currentIndex),
                Visibility(
                    visible: currentIndex == 2,
                    replacement: SizedBox(
                      height: sizes.s50 + sizes.s20,
                    ),
                    child: Button()),
                SizedBox(
                  height: emptyBottom,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget body() {
    return Expanded(
      child: PageView.builder(
        controller: pageController,
        onPageChanged: onPageChanged,
        itemCount: itemLength,
        itemBuilder: (context, index) {
          return Column(
            children: [
              const Spacer(
                flex: 1,
              ),
              Text(
                controller.items[currentIndex].header,
                textAlign: TextAlign.center,
                style: textTheme.headlineLarge!.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),
              const Spacer(
                flex: 2,
              ),
              SizedBox(
                  height: (deviceWidth - sizes.s40) * 9 / 16,
                  child: Image.asset(
                    controller.items[currentIndex].image,
                    fit: BoxFit.contain,
                  )),
              const Spacer(
                flex: 3,
              ),
              Text(
                controller.items[currentIndex].description,
                style: textTheme.titleMedium!.copyWith(color: colorScheme.onSurface),
                textAlign: TextAlign.center,
              ),
              const Spacer(
                flex: 1,
              )
            ],
          );
        },
      ),
    );
  }

  Widget Button() {
    return Padding(
      padding: paddings.h(sizes.s20) + paddings.t(sizes.s20),
      child: InkWell(
        onTap: onButtonPressed,
        customBorder: const StadiumBorder(),
        child: Container(
          height: sizes.s50,
          decoration: ShapeDecoration(shape: const StadiumBorder(), color: colorScheme.background),
          child: Center(
            child: Text(
              "BAŞLAYALIM",
              style: textTheme.titleLarge!.copyWith(color: colorScheme.onSurface),
            ),
          ),
        ),
      ),
    );
  }
}

class OnboardingInfo {
  final String header;
  final String description;
  final String image;
  OnboardingInfo({
    required this.header,
    required this.description,
    required this.image,
  });
}

class OnboardingData {
  List<OnboardingInfo> items = [
    OnboardingInfo(header: "NextHabit'e\nHoş Geldiniz", description: "NextHabit ile daha güzel bir yaşam tarzına\nadım atın.", image: "assets/images/dailyRoutine.png"),
    OnboardingInfo(header: "NextHabit ile\nyeni alışkanlıklar", description: "Yeni alışkanlıkları keşfedin ve günlük rutininizi kolayca iyileştirin.", image: "assets/images/habit1.png"),
    OnboardingInfo(header: "Alışkanlıklarınızı yönetin", description: "Alışkanlıklarınızı kolayca takip edebilir ve yönetebilirsiniz.", image: "assets/images/shedule.png")
  ];
}
