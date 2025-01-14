import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroEkran5 extends StatelessWidget {
  const IntroEkran5({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 40, 40, 42),
      child: Padding(
        padding: const EdgeInsets.only(top: 128),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //
              //
              Image.asset(
                'assets/images/svg/undraw_mobile-app_qxev.png',
              ),
              const SizedBox(height: 32),
              Text(
                'Devam edelim!',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                'Devam etmek için tamam butonuna tıklayınız veya ekrana çift dokununuz.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
