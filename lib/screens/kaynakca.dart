import 'package:flutter/material.dart';

class Kaynakca extends StatelessWidget {
  const Kaynakca({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kaynakça',
          style: TextStyle(
            color: Color.fromARGB(255, 233, 233, 233),
            fontFamily: 'PlayfairDisplay',
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 138, 26, 26),
        centerTitle: true,
      ),
      body: const Placeholder(),
    );
  }
}
