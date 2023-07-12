import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/colors.dart';
import 'package:whatsapp_clone/common/utils/utils.dart';
import 'package:whatsapp_clone/common/widgets/custom_button.dart';
import 'package:country_picker/country_picker.dart';
import 'package:whatsapp_clone/features/auth/controller/auth_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const String routeName = '/login-screen';
  LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  TextEditingController _phoneController = TextEditingController();
  Country? country;

  @override
  void dispose() {
    super.dispose();
    _phoneController.dispose();
  }

  void pickCountry() {
    showCountryPicker(
        context: context,
        showPhoneCode: true,
        onSelect: (Country _country) {
          setState(() {
            country = _country;
          });
        });
  }

  void sendPhoneNumber() {
    String phoneNumber = _phoneController.text.trim();

    if (phoneNumber.isNotEmpty && country != null) {
      ref.read(authControllerProvider).signInWithPhoneNumber(
            context,
            '+${country!.phoneCode}$phoneNumber',
          );
    } else {
      showSnacbar(context: context, content: 'Fill all the fields');
    }
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter your phone number'),
        elevation: 0,
        backgroundColor: backgroundColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 20,
                  width: double.infinity,
                ),
                Text(
                  'WhatsApp wil need to verify your phone number',
                ),
                SizedBox(
                  height: 20,
                ),
                TextButton(onPressed: pickCountry, child: Text('Pick Country')),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (country != null) Text('+${country!.phoneCode}'),
                    SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      width: size.width * 0.55,
                      child: TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Phone number',
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              width: size.width * 0.25,
              child: CustomButton(
                height: 50,
                text: 'next',
                onPressed: sendPhoneNumber,
              ),
            )
          ],
        ),
      ),
    );
  }
}
