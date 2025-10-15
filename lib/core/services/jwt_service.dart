import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class JWTService {
  // In production, store this securely (environment variables, secure storage, etc.)
  static const String _secretKey = 'your-secret-key-change-in-production';
  static const Duration _tokenExpiry = Duration(days: 7);

  /// Generate a JWT token for a user
  static String generateToken({
    required String userId,
    required String phoneNumber,
    Map<String, dynamic>? additionalClaims,
  }) {
    final now = DateTime.now();
    final expiry = now.add(_tokenExpiry);

    // Create the header
    final header = {
      'alg': 'HS256',
      'typ': 'JWT',
    };

    // Create the payload
    final payload = {
      'sub': userId,
      'phone': phoneNumber,
      'iat': now.millisecondsSinceEpoch ~/ 1000,
      'exp': expiry.millisecondsSinceEpoch ~/ 1000,
      ...?additionalClaims,
    };

    // Encode header and payload
    final headerEncoded = base64Url.encode(utf8.encode(json.encode(header)));
    final payloadEncoded = base64Url.encode(utf8.encode(json.encode(payload)));

    // Create signature
    final dataToSign = '$headerEncoded.$payloadEncoded';
    final signature = _createSignature(dataToSign);

    // Return complete token
    return '$dataToSign.$signature';
  }

  /// Verify and decode a JWT token
  static Map<String, dynamic>? verifyToken(String token) {
    try {
      // Check if token is expired
      if (JwtDecoder.isExpired(token)) {
        print('Token has expired');
        return null;
      }

      // Split token
      final parts = token.split('.');
      if (parts.length != 3) {
        print('Invalid token format');
        return null;
      }

      final headerEncoded = parts[0];
      final payloadEncoded = parts[1];
      final signature = parts[2];

      // Verify signature
      final dataToVerify = '$headerEncoded.$payloadEncoded';
      final expectedSignature = _createSignature(dataToVerify);

      if (signature != expectedSignature) {
        print('Invalid token signature');
        return null;
      }

      // Decode and return payload
      return JwtDecoder.decode(token);
    } catch (e) {
      print('Error verifying token: $e');
      return null;
    }
  }

  /// Decode token without verification (use carefully)
  static Map<String, dynamic> decodeToken(String token) {
    return JwtDecoder.decode(token);
  }

  /// Check if token is expired
  static bool isTokenExpired(String token) {
    return JwtDecoder.isExpired(token);
  }

  /// Get token expiry date
  static DateTime? getExpiryDate(String token) {
    try {
      return JwtDecoder.getExpirationDate(token);
    } catch (e) {
      print('Error getting expiry date: $e');
      return null;
    }
  }

  /// Get remaining time until token expires
  static Duration? getRemainingTime(String token) {
    try {
      final expiryDate = getExpiryDate(token);
      if (expiryDate == null) return null;

      final now = DateTime.now();
      if (expiryDate.isBefore(now)) return Duration.zero;

      return expiryDate.difference(now);
    } catch (e) {
      print('Error getting remaining time: $e');
      return null;
    }
  }

  /// Refresh token if it's about to expire
  static String? refreshTokenIfNeeded(String token) {
    try {
      final remaining = getRemainingTime(token);
      if (remaining == null) return null;

      // Refresh if less than 1 day remaining
      if (remaining.inDays < 1) {
        final payload = decodeToken(token);
        return generateToken(
          userId: payload['sub'],
          phoneNumber: payload['phone'],
          additionalClaims: Map<String, dynamic>.from(payload)
            ..remove('sub')
            ..remove('phone')
            ..remove('iat')
            ..remove('exp'),
        );
      }

      return token;
    } catch (e) {
      print('Error refreshing token: $e');
      return null;
    }
  }

  /// Create HMAC-SHA256 signature
  static String _createSignature(String data) {
    final key = utf8.encode(_secretKey);
    final bytes = utf8.encode(data);
    final hmac = Hmac(sha256, key);
    final digest = hmac.convert(bytes);
    return base64Url.encode(digest.bytes);
  }
}



