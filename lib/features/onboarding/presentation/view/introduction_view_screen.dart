import 'package:flutter/material.dart';
import 'package:flutter_tcc_base_source/core/di/injection_container.dart';
import 'package:flutter_tcc_base_source/core/helpers/app_navigator.dart';
import 'package:flutter_tcc_base_source/core/helpers/base_state.dart';
import 'package:flutter_tcc_base_source/core/helpers/secure_storage.dart';
import 'package:flutter_tcc_base_source/core/navigation/navigation_center.dart';
import 'package:flutter_tcc_base_source/features/authentication/presentation/view/login_screen.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroductionViewScreen extends StatefulWidget {
  const IntroductionViewScreen({Key? key}) : super(key: key);

  @override
  _IntroductionViewScreenState createState() => _IntroductionViewScreenState();
}

class _IntroductionViewScreenState extends BaseState<IntroductionViewScreen> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: 'Title of first page',
          body: 'Here you can write the description of the page, to explain something...',
          image: Center(
            child: Image.network(
              'https://ih1.redbubble.net/image.1057190259.1918/st,small,507x507-pad,600x600,f8f8f8.u1.jpg',
              height: 175.0,
            ),
          ),
        ),
        PageViewModel(
          title: 'Title of second page',
          body: 'Here you can write the description of the page, to explain something...',
          image: Center(
            child: Image.network(
              'https://ih1.redbubble.net/image.1057190259.1918/st,small,507x507-pad,600x600,f8f8f8.u1.jpg',
              height: 175.0,
            ),
          ),
        ),
        PageViewModel(
          title: 'Title of third page',
          body: 'Here you can write the description of the page, to explain something...',
          image: Center(
            child: Image.network(
              'https://ih1.redbubble.net/image.1057190259.1918/st,small,507x507-pad,600x600,f8f8f8.u1.jpg',
              height: 175.0,
            ),
          ),
        )
      ],
      onDone: () async => await goToLoginScreen(),
      onSkip: () async => await goToLoginScreen(),
      showBackButton: false,
      showSkipButton: true,
      next: const Text('Next'),
      skip: const Text('Skip'),
      done: const Text(
        'Done',
        style: TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Future<void> goToLoginScreen() async {
    await sl<SecureStorage>().saveCustomString(SecureStorage.isFirstTime, 'true');
    AppNavigator.goToScreen(
      this,
      const LoginScreen(),
      NavigationCenter.loginScreen,
    );
  }
}
