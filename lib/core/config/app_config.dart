class AppConfig {
  const AppConfig._();

  static const demoMode =
      String.fromEnvironment('APP_DEMO_MODE', defaultValue: 'true') == 'true';

  static const googleMapsApiKey =
      String.fromEnvironment('GOOGLE_MAPS_API_KEY');
}
