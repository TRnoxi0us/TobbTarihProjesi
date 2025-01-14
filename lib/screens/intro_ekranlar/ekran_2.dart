import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroEkran2 extends StatelessWidget {
  const IntroEkran2({super.key});

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
                height: 200,
                'assets/images/svg/undraw_mobile-application_lhsq.png',
              ),
              const SizedBox(height: 54),

              Text(
                'Uygulamamız modüler bir yapıda tasarlanmış olup, aşağı ve yukarı kaydırarak ekranlar arasında geçiş yapabilirsiniz.',
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
