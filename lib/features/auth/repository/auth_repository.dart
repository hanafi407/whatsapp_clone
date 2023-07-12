import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/common/utils/utils.dart';
import 'package:whatsapp_clone/features/auth/screen/otp_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/features/auth/screen/user_information_screen.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  ),
);

class AuthRepository {
  AuthRepository({required this.auth, required this.firestore});
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  signInWithPhone(String phone, BuildContext context) async {
    try {
      auth.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (e) {
          print('failed');
          throw Exception(e.message);
        },
        codeSent: (String verificationId, int? forceResendingToken) {
          Navigator.pushNamed(context, OTPScreen.routeName, arguments: verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (err) {
      showSnacbar(context: context, content: err.toString());
    }
  }

  void verifyOTP(BuildContext context, String verifycationId, String userOTP) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verifycationId,
        smsCode: userOTP,
      );
      await auth.signInWithCredential(credential);

      Navigator.pushNamedAndRemoveUntil(context, UserInformationScreen.routeName, (route) => false);
    } on FirebaseAuthException catch (err) {
      showSnacbar(context: context, content: err.message!);
    }
  }
}
