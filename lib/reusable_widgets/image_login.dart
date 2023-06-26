import 'package:flutter/material.dart';

class ImageGenrator extends StatelessWidget {
  const ImageGenrator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Image(image: AssetImage('assets/images/logo.png'),
    width: double.infinity,
    height:300.0);
  }
}
