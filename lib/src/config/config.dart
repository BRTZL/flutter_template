// import 'package:dio/dio.dart';

class Config {
  // App title
  static const String title = 'flutter_template';
}

//+ For using custom backend service

// Production Api Url
// const String _prodUrl = 'https://api.flutter_template.com/';
// Development Api Url
// const String _devUrl = 'https://api.stage.flutter_template.com/';

// final BaseOptions _options = BaseOptions(
//   baseUrl: !kDebugMode ? _devUrl : _prodUrl,
//   connectTimeout: 10000,
//   receiveTimeout: 10000,
//   validateStatus: (status) => true,
// );

// final Dio _dio = Dio(_options);

// Dio get getDio => _dio;

class Links {
  static const String termsAndConditionsLink = 'http://flutter_template.com';
  static const String privacyPolicyLink = 'http://flutter_template.com';

  static const String onboardingPersonalInfoLink = 'http://flutter_template.com';
  static const String onboardingBodyStatsLink = 'http://flutter_template.com';
  static const String onboardingBodyGoalsLink = 'http://flutter_template.com';

  static const String paymentCheckoutTermsAndConditionLink = 'http://flutter_template.com';

  static const String newAnalysisTermsAndConditionLink = 'http://flutter_template.com';
}
