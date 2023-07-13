import 'dart:io';

import 'package:flutter/material.dart';
import 'package:whatsapp_clone/features/auth/repository/auth_repository.dart';
import 'package:riverpod/riverpod.dart';

import '../../../models/user_model.dart';

final authControllerProvider = Provider(
  (ref) {
    final authRepository = ref.watch(authRepositoryProvider);

    return AuthController(authRepository: authRepository, ref: ref);
  },
);

final userDataAuthProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider);

 return authController.getUserData();
},);

class AuthController {
  final AuthRepository authRepository;
  final ProviderRef ref;
  AuthController({required this.authRepository, required this.ref});

  Future<UserModel?> getUserData() async {
    UserModel? user = await authRepository.getCurrentUserData();
    return user;
  }

  void signInWithPhoneNumber(BuildContext context, String phoneNumber) {
    authRepository.signInWithPhone(phoneNumber, context);
  }

  void otp(BuildContext context, String verification, String userOTP) {
    authRepository.verifyOTP(context, verification, userOTP);
  }

  void saveUserDataToFirebase(String name, File? file, BuildContext context) {
    authRepository.saveUserDataToFirebase(name, ref, file, context);
  }
}
