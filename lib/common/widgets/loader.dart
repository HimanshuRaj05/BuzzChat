import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
          valueColor:
              AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 24, 122, 250))),
    );
  }
}
