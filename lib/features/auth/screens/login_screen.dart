import 'package:flutter/material.dart';
import 'package:whatsapp_flutter/common/utils/utils.dart';
import 'package:whatsapp_flutter/common/widgets/custom_button.dart';
import 'package:whatsapp_flutter/colors.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_flutter/features/auth/controller/auth_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const routeName = '/login-screen';
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final phoneController = TextEditingController();
  Country? country;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    phoneController.dispose();
  }

  void pickCountry() {
    showCountryPicker(
        context: context,
        onSelect: (Country _country) {
          setState(() {});
          country = _country;
        });
  }

  void sendPhoneNumber() {
    String phoneNumber = phoneController.text.trim();
    if (country != null && phoneNumber.isNotEmpty) {
      ref
          .read(authControllerProvider)
          .signInWithPhone(context, '+${country!.phoneCode}$phoneNumber');
    } else {
      showSnackBar(context: context, content: 'Fill out all the fields');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.grey.shade900),
        title: const Text(
          'Enter your phone number',
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
        elevation: 0,
        backgroundColor: backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('WhatApp will need to verify your phone number',
                  style: TextStyle(color: Colors.black54)),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: pickCountry,
                  child: Text(
                    'Pick Country',
                    style: TextStyle(color: tabColor),
                  )),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  if (country != null)
                    Text(
                      '+${country!.phoneCode}',
                      style: TextStyle(color: blackColor),
                    ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: size.width * 0.7,
                    child: TextField(
                      style: TextStyle(color: Colors.grey.shade900),
                      controller: phoneController,
                      decoration:
                          const InputDecoration(hintText: 'phone number'),
                    ),
                  )
                ],
              ),
              SizedBox(height: size.height * 0.59),
              SizedBox(
                width: 200,
                child: CustomButton(
                  onPressed: sendPhoneNumber,
                  text: 'NEXT',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
