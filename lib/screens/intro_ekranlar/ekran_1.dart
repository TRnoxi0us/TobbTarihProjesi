import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroEkran1 extends StatelessWidget {
  const IntroEkran1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 40, 40, 42),
      child: Padding(
        padding: const EdgeInsets.only(top: 200),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //
              //
              Image.asset(
                'assets/images/svg/undraw_podcast-audience_nkzj.png',
              ),
              const SizedBox(height: 48),
              Text(
                'Uygulamıza hoş geldiniz...',
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
                'Uygulamamıza hoş geldiniz! Bu uygulama tüm bireylerin tarih içeriğine erişebilirliğini arttırmak için geliştirilmiş bir sesli sözlük uygulamasıdır. \n Devam etmek için sağa kaydırınız. ',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
              )
            ],
          ),
        ),
      ),
    );
  }
}
