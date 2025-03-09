import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static String baseUrl = dotenv.env['BASE_URL']!;


  static final String verifyUser = '$baseUrl/api/signInVerification';
  
}