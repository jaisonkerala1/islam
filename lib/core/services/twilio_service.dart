import 'package:http/http.dart' as http;
import 'dart:convert';

class TwilioService {
  // TODO: Replace with your production credentials from https://www.twilio.com/console
  static const String accountSid = 'YOUR_TWILIO_ACCOUNT_SID';
  static const String authToken = 'YOUR_TWILIO_AUTH_TOKEN';
  static const String twilioNumber = 'YOUR_TWILIO_PHONE_NUMBER';
  static const String baseUrl = 'https://api.twilio.com/2010-04-01';

  /// Send OTP via SMS
  static Future<bool> sendOTP({
    required String phoneNumber,
    required String otp,
  }) async {
    try {
      final url = Uri.parse('$baseUrl/Accounts/$accountSid/Messages.json');
      
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Basic ${base64Encode(utf8.encode('$accountSid:$authToken'))}',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'From': twilioNumber,
          'To': phoneNumber,
          'Body': 'Your Islamic App verification code is: $otp\n\nThis code will expire in 10 minutes.',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('OTP sent successfully to $phoneNumber');
        return true;
      } else {
        print('Failed to send OTP: ${response.statusCode} - ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error sending OTP: $e');
      return false;
    }
  }

  /// Send verification code via Twilio Verify API (more secure)
  static Future<bool> sendVerificationCode(String phoneNumber) async {
    try {
      // Note: Requires Twilio Verify service SID
      // This is a placeholder for production implementation
      final url = Uri.parse('https://verify.twilio.com/v2/Services/YOUR_SERVICE_SID/Verifications');
      
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Basic ${base64Encode(utf8.encode('$accountSid:$authToken'))}',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'To': phoneNumber,
          'Channel': 'sms',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Verification code sent successfully');
        return true;
      } else {
        print('Failed to send verification code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error sending verification code: $e');
      return false;
    }
  }

  /// Verify code via Twilio Verify API
  static Future<bool> verifyCode({
    required String phoneNumber,
    required String code,
  }) async {
    try {
      // Note: Requires Twilio Verify service SID
      // This is a placeholder for production implementation
      final url = Uri.parse('https://verify.twilio.com/v2/Services/YOUR_SERVICE_SID/VerificationCheck');
      
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Basic ${base64Encode(utf8.encode('$accountSid:$authToken'))}',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'To': phoneNumber,
          'Code': code,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['status'] == 'approved';
      } else {
        print('Failed to verify code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error verifying code: $e');
      return false;
    }
  }

  /// Generate a random 6-digit OTP
  static String generateOTP() {
    return (100000 + (DateTime.now().millisecondsSinceEpoch % 900000)).toString();
  }
}



