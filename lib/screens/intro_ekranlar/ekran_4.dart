import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroEkran4 extends StatelessWidget {
  const IntroEkran4({super.key});

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
              Image.asset(
                "assets/images/resim.png",
                height: 240,
              ),
              const SizedBox(height: 14),
              Text(
                'Uygulamayı kullanmaya başlamak için ekranın alt kısmında bulunan mikrofon ikonuna tıklayabilir veya sağ ve sola iki parmağınızla kaydırarak otomatik olarak dinlemeyi başlatabilirsiniz. ',
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
