import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:rankr_app/services/storage_service.dart';

import '../app/models/user.dart';

class JwtService {
  static Future<User?> decodeToken({String? tk}) async {
    try {
      final token = tk ?? await StorageService.getAccessToken();
      if (token == null) {
        return null;
      }
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      return User.fromJson(decodedToken);
    } catch (e) {
      return null;
    }
  }
}
