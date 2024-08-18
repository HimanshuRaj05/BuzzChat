import 'package:flutter/material.dart';
import 'package:whatsapp_flutter/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_flutter/features/auth/controller/auth_controller.dart';

class OTPScreen extends ConsumerWidget {
  static const String routeName = '/otp-screen';
  final String verificationId;
  const OTPScreen({
    Key? key,
    required this.verificationId,
  }) : super(key: key);

  void verifyOTP(WidgetRef ref, BuildContext context, String userOTP) {
    ref.read(authControllerProvider).verifyOTP(
          context,
          verificationId,
          userOTP,
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.grey.shade900),
        title: const Text('Verifying your number', style: TextStyle(color: blackColor),),
        elevation: 0,
        backgroundColor: backgroundColor,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
             Text('We have sent an SMS with a code.', style: TextStyle(color:Colors.grey.shade800),),
            SizedBox(
              width: size.width * 0.5,
              child: TextField(
                style: TextStyle(color: blackColor),
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: '- - - - - -',
                  hintStyle: TextStyle(
                    fontSize: 30,
                  ),
                ),
                keyboardType: TextInputType.number,
                onChanged: (val) {
                  if (val.length == 6) {
                    print('length is 6');
                    verifyOTP(ref, context, val.trim());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
