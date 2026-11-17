class AppConfig {
  const AppConfig._();

  static const googleMapsApiKey =
      String.fromEnvironment('GOOGLE_MAPS_API_KEY');
}
