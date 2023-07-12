import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/features/auth/controller/auth_controller.dart';

class OTPScreen extends ConsumerWidget {
  static const String routeName = '/otp-screen';
  final String verification;
  const OTPScreen({super.key, required this.verification});

  void verifyOTP(WidgetRef ref, BuildContext context, String userOTP) {
    ref.read(authControllerProvider).otp(context, verification, userOTP);
    //Provider.of<ControllerProvider>(context,listen:false).otp(context,verification,userOTP);
    //use ref.watch if you want listen: true.
  }

  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verifying your number'),
      ),
      body: Center(
        child: Column(children: [
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 20,
          ),
          const Text('We have sent a SMS with a code'),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: '- - - - - -',
                hintStyle: TextStyle(fontSize: 30),
              ),
              onChanged: (val) {
                if (val.length == 6) {
                  print('ok');
                  verifyOTP(ref, context, val.trim());
                }
              },
              keyboardType: TextInputType.number,
            ),
          )
        ]),
      ),
    );
  }
}
