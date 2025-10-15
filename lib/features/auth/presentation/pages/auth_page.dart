import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:islamic_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:islamic_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:islamic_app/core/theme/app_theme.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  bool _showOTPField = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppTheme.primaryColor,
              AppTheme.secondaryColor,
              AppTheme.accentColor,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is OTPSent) {
                    setState(() {
                      _showOTPField = true;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('OTP sent! Use: 123456'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else if (state is AuthError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo and Title
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const Icon(
                          Icons.mosque,
                          size: 80,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Islamic App',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Your Spiritual Companion',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 48),

                      // Auth Card
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              'Sign in with Phone',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.textPrimary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 24),

                            // Phone Number Field
                            TextField(
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              enabled: !_showOTPField,
                              decoration: const InputDecoration(
                                labelText: 'Phone Number',
                                hintText: '+1234567890',
                                prefixIcon: Icon(Icons.phone),
                              ),
                            ),
                            const SizedBox(height: 16),

                            // OTP Field
                            if (_showOTPField) ...[
                              TextField(
                                controller: _otpController,
                                keyboardType: TextInputType.number,
                                maxLength: 6,
                                decoration: const InputDecoration(
                                  labelText: 'OTP Code',
                                  hintText: 'Enter 6-digit code',
                                  prefixIcon: Icon(Icons.lock),
                                  counterText: '',
                                ),
                              ),
                              const SizedBox(height: 16),
                            ],

                            // Action Button
                            if (state is AuthLoading)
                              const Center(
                                child: CircularProgressIndicator(),
                              )
                            else
                              ElevatedButton(
                                onPressed: () {
                                  if (!_showOTPField) {
                                    // Send OTP
                                    if (_phoneController.text.isNotEmpty) {
                                      context.read<AuthBloc>().add(
                                            SendOTP(_phoneController.text),
                                          );
                                    }
                                  } else {
                                    // Verify OTP
                                    if (_otpController.text.isNotEmpty) {
                                      context.read<AuthBloc>().add(
                                            VerifyOTP(
                                              _phoneController.text,
                                              _otpController.text,
                                            ),
                                          );
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                ),
                                child: Text(
                                  _showOTPField ? 'Verify OTP' : 'Send OTP',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),

                            // Resend OTP
                            if (_showOTPField) ...[
                              const SizedBox(height: 16),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    _showOTPField = false;
                                    _otpController.clear();
                                  });
                                },
                                child: const Text('Change Phone Number'),
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Test Credentials Info
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Column(
                          children: [
                            Text(
                              'Test Mode',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Use any phone number\nOTP: 123456',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}



