import 'package:car_workshop_flutter/src/utils/config.dart';

class BasePaths {
  const BasePaths._();

  static const baseImagePath = "assets/images";
  static const baseAnimationPath = "assets/animations";
  static const baseIconPath = "assets/icons";
  static const basePlaceholderPath = "assets/placeholders";
  static const baseProdUrl = "https://car-workshop-fastapi.onrender.com/api/v1";
  static const baseTestUrl = "https://car-workshop-fastapi.onrender.com/api/v1";
  static const baseUrl = AppConfig.devMode ? baseTestUrl : baseProdUrl;
}
