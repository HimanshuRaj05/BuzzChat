import 'package:flutter/material.dart';
import 'package:whatsapp_flutter/common/widgets/custom_button.dart';
import 'package:whatsapp_flutter/features/auth/screens/login_screen.dart';
import 'package:whatsapp_flutter/colors.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  void navigateToLoginScreen(BuildContext context) {
    Navigator.pushNamed(context, LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const SizedBox(
            height: 50,
          ),
          const Text(
            'Welcome to BuzzChat',
            style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600,
                color: Colors.black87),
          ),
          SizedBox(height: size.height / 9),
          Image.asset(
            'assets/fp.jpg',
            height: 310,
            width: 310,
          ),
          SizedBox(
            height: size.height / 9,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: const Text(
              'Read our Privacy Policy. Tap "Agree and continue" to accept the Terms of Service.',
              style: TextStyle(color: greyColor),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: size.width * 0.75,
            child: CustomButton(
              

                text: 'AGREE AND CONTINUE',
                onPressed: () => navigateToLoginScreen(context)),
          )
        ]),
      ),
    );
  }
}
