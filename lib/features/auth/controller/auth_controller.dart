import 'package:flutter/material.dart';
import 'package:whatsapp_clone/features/auth/repository/auth_repository.dart';
import 'package:riverpod/riverpod.dart';

final authControllerProvider = Provider(
  (ref) {
    final authRepository = ref.watch(authRepositoryProvider);

    return AuthController(authRepository: authRepository);
  },
);

class AuthController {
  final AuthRepository authRepository;

  AuthController({required this.authRepository});

  void signInWithPhoneNumber(BuildContext context, String phoneNumber) {
    authRepository.signInWithPhone(phoneNumber, context);
  }

  void otp(BuildContext context, String verification, String userOTP) {
    authRepository.verifyOTP(context, verification, userOTP);
  }
}
