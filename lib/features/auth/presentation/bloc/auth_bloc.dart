import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:islamic_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  // TODO: Replace with your production Twilio credentials from https://www.twilio.com/console
  static const String accountSid = 'YOUR_TWILIO_ACCOUNT_SID';
  static const String authToken = 'YOUR_TWILIO_AUTH_TOKEN';
  static const String twilioNumber = 'YOUR_TWILIO_PHONE_NUMBER';

  AuthBloc() : super(AuthInitial()) {
    on<CheckAuthStatus>(_onCheckAuthStatus);
    on<SendOTP>(_onSendOTP);
    on<VerifyOTP>(_onVerifyOTP);
    on<SignOut>(_onSignOut);
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatus event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      final userId = prefs.getString('user_id');

      if (token != null && userId != null) {
        emit(Authenticated(userId, token));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(Unauthenticated());
    }
  }

  Future<void> _onSendOTP(
    SendOTP event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      // In a real app, you would send OTP via Twilio
      // For now, using mock implementation
      
      // Mock Twilio API call
      // final response = await http.post(
      //   Uri.parse('https://api.twilio.com/2010-04-01/Accounts/$accountSid/Messages.json'),
      //   headers: {
      //     'Authorization': 'Basic ' + base64Encode(utf8.encode('$accountSid:$authToken')),
      //   },
      //   body: {
      //     'From': twilioNumber,
      //     'To': event.phoneNumber,
      //     'Body': 'Your OTP is: 123456',
      //   },
      // );

      await Future.delayed(const Duration(seconds: 1));
      
      // Store OTP for verification (in production, this would be server-side)
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('temp_otp_${event.phoneNumber}', '123456');
      
      emit(OTPSent(event.phoneNumber));
    } catch (e) {
      emit(AuthError('Failed to send OTP: ${e.toString()}'));
    }
  }

  Future<void> _onVerifyOTP(
    VerifyOTP event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final storedOTP = prefs.getString('temp_otp_${event.phoneNumber}');

      if (storedOTP == event.otp) {
        // Generate mock JWT token
        final token = 'mock_jwt_token_${DateTime.now().millisecondsSinceEpoch}';
        final userId = 'user_${event.phoneNumber.replaceAll('+', '')}';

        // Store credentials
        await prefs.setString('auth_token', token);
        await prefs.setString('user_id', userId);
        await prefs.setString('phone_number', event.phoneNumber);

        // Clean up temp OTP
        await prefs.remove('temp_otp_${event.phoneNumber}');

        emit(Authenticated(userId, token));
      } else {
        emit(const AuthError('Invalid OTP. Please try again.'));
      }
    } catch (e) {
      emit(AuthError('Verification failed: ${e.toString()}'));
    }
  }

  Future<void> _onSignOut(
    SignOut event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('auth_token');
      await prefs.remove('user_id');
      await prefs.remove('phone_number');
      
      emit(Unauthenticated());
    } catch (e) {
      emit(AuthError('Sign out failed: ${e.toString()}'));
    }
  }
}

