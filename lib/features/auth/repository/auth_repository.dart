import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/common/repositories/common_firebase_storage_repositories.dart';
import 'package:whatsapp_clone/common/utils/utils.dart';
import 'package:whatsapp_clone/features/auth/screen/otp_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/features/auth/screen/user_information_screen.dart';
import 'package:whatsapp_clone/models/user_model.dart';
import 'package:whatsapp_clone/screens/mobile_layout_screen.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  ),
);

class AuthRepository {
  AuthRepository({
    required this.auth,
    required this.firestore,
  });
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  Future<UserModel?> getCurrentUserData() async {
    var userData = await firestore.collection('users').doc(auth.currentUser?.uid).get();

    UserModel? user;

    if (userData.data() != null) {
      user = UserModel.fromMap(userData.data()!);
    }

    print('user=${userData.data()}');

    return user;
  }

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

  saveUserDataToFirebase(
    String name,
    ProviderRef ref,
    File? file,
    BuildContext context,
  ) async {
    try {
      var uid = auth.currentUser!.uid;

      String photoUrl =
          'https://t4.ftcdn.net/jpg/02/15/84/43/360_F_215844325_ttX9YiIIyeaR7Ne6EaLLjMAmy4GvPC69.jpg';

      if (file != null) {
        photoUrl = await ref
            .read(commonFirebaseStorageRepositoriesProvider)
            .storeFileToFirebase('photoPic/$uid', file);
      }

      var user = UserModel(
        name: name,
        uid: uid,
        profilPic: photoUrl,
        isOnline: true,
        phoneNumber: auth.currentUser!.phoneNumber!,
        groupId: [],
      );

      await firestore.collection('users').doc(uid).set(user.toMap());

      Navigator.pushAndRemoveUntil(
          context, MaterialPageRoute(builder: (context) => MobileLayoutScreen()), (route) => false);
    } catch (e) {
      showSnacbar(context: context, content: e.toString());
    }
  }
}
