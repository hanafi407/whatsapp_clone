import 'package:flutter/material.dart';
import 'package:whatsapp_clone/common/widgets/error_screen.dart';
import 'package:whatsapp_clone/features/auth/screen/login_screen.dart';
import 'package:whatsapp_clone/features/auth/screen/otp_screen.dart';
import 'package:whatsapp_clone/features/auth/screen/user_information_screen.dart';
import 'package:whatsapp_clone/features/select_contacts/screen/select_contact_screen.dart';
import 'package:whatsapp_clone/screens/mobile_chat_screen.dart';

Route<dynamic> generateRoute(RouteSettings setting) {
  switch (setting.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => LoginScreen(),
      );
    case OTPScreen.routeName:
      final verificationId = setting.arguments as String;
      return MaterialPageRoute(
        builder: (context) => OTPScreen(verification: verificationId),
      );
    case UserInformationScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => UserInformationScreen(),
      );
    case SelectContactScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => SelectContactScreen(),
      );
    case MobileChatScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => MobileChatScreen(),
      );
    default:
      return MaterialPageRoute(
          builder: (_) => ErrorScreen(contentError: 'This page doesn\'t exist'));
  }
}
