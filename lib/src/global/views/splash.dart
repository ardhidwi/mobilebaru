import 'package:car_workshop_flutter/src/feature/authentication/view/login_screen.dart';
import 'package:car_workshop_flutter/src/utils/asset_urls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:car_workshop_flutter/src/feature/home/view/home.dart';
import 'package:car_workshop_flutter/src/global/controller/init_controller.dart';
import 'package:car_workshop_flutter/src/global/providers/common_providers.dart';
import 'package:car_workshop_flutter/src/utils/config.dart';
import 'package:go_router/go_router.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  static const routePath = "/splash";

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  @override
  void initState() {
    super.initState();

    /// check if the app is running in dev mode
    if (AppConfig.devMode) {
      /// bypass authenticaion logic.
      /// Navigate to Home
      Future.delayed(const Duration(seconds: 3)).then((value) {
        context.go(LoginScreen.routePath);
      });
    } else {
      ref.read(initControllerProvider).initUserAndToken().then((value) {
        final user = ref.read(currentUserProvider);

        /// Check if both the [user] and [token] have value
        if (user == null) {
          /// Route the user to Authenticaion screen
        } else {
          /// Route the user to Home screen
          context.go(HomeView.routePath);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: height,
        width: width,
        child: Stack(
          children: [
            Center(
              child: Image.asset(AssetURL.appLogo),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    'By',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Image.asset(
                    AssetURL.companyLogo,
                    width: width * 0.5,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
