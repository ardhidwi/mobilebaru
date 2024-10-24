import 'package:car_workshop_flutter/src/utils/config.dart';

class BasePaths {
  const BasePaths._();

  static const baseImagePath = "assets/images";
  static const baseAnimationPath = "assets/animations";
  static const baseIconPath = "assets/icons";
  static const basePlaceholderPath = "assets/placeholders";
  static const baseProdUrl = "http://192.168.0.108:8000/api/v1";
  static const baseTestUrl = "http://192.168.0.108:8000/api/v1";
  static const baseUrl = AppConfig.devMode ? baseTestUrl : baseProdUrl;
}
