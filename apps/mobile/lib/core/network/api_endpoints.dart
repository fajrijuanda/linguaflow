class ApiEndpoints {
  // Use 10.0.2.2 for Android Emulator to access localhost
  // Use localhost for iOS simulator
  static const String baseUrl = 'http://10.0.2.2:8000/api'; 
  
  // Auth
  static const String register = '/users/register/';
  static const String login = '/users/login/';
  static const String profile = '/users/profile/';
  
  // Content
  static const String courses = '/courses/';
}
