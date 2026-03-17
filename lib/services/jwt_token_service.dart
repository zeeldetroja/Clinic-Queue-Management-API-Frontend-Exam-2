import 'package:frontend_exam_2/services/sharedpreference_service.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class JwtTokenService {
  JwtTokenService._();

  static Future<dynamic> getTokenData() async {
    String token = await PreferenceService().getToken();
    return JwtDecoder.isExpired(token) ? null : JwtDecoder.decode(token);
    // print(tokenData);
  }

  static Future<String?> userRole() async {
    String token = await PreferenceService().getToken();
    if (JwtDecoder.isExpired(token)) {
      return null;
    } else {
      dynamic userData = JwtDecoder.decode(token);

      return userData['role'];
    }

    // static Future<bool?> isAdmin() async {
    //   String token = await PreferenceService().getToken();
    //   if(JwtDecoder.isExpired(token)){
    //     return null;
    //   }else{
    //     dynamic userData = JwtDecoder.decode(token);
    //     dynamic userRole = userData['role'];
    //     return userRole == 'admin';
    //   }
  }
}
