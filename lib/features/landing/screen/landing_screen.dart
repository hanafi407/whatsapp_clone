import 'package:flutter/material.dart';
import 'package:whatsapp_clone/colors.dart';
import 'package:whatsapp_clone/common/widgets/custom_button.dart';
import 'package:whatsapp_clone/features/auth/screen/login_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    navigateToLoginScreen(BuildContext context) {
      Navigator.pushNamed(context, LoginScreen.routeName);
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: size.height / 15,
                ),
                const Text(
                  'Welcome to WhatssApp',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 33),
                ),
                SizedBox(
                  height: size.height / 15,
                ),
                Image.asset(
                  'assets/bg.png',
                  width: size.width * 0.9,
                ),
                SizedBox(
                  height: size.height / 15,
                ),
                const Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text(
                    'Read our Privacy Policy. Tap "Agree and Continue" to Accept Term of Services',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: greyColor),
                  ),
                ),
                SizedBox(
                  height: size.height / 20,
                ),
                SizedBox(
                    width: size.width * 0.75,
                    child: CustomButton(
                      height: 50,
                      text: 'Agree and Continue',
                      onPressed: () => navigateToLoginScreen(context),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
