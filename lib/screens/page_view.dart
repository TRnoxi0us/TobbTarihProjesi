import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ilkuyg/screens/kaynakca.dart';
import 'package:ilkuyg/screens/ogrenme_oyunlari.dart';
import 'package:vibration/vibration.dart';
import 'ana_ekran.dart';
import 'podcast_ekran.dart';

class SayfaView extends StatefulWidget {
  const SayfaView({super.key});

  @override
  State<SayfaView> createState() => _SayfaViewState();
}

class _SayfaViewState extends State<SayfaView> {
  final PageController _pageController =
      PageController(initialPage: 1, keepPage: true);

  @override
  Widget build(BuildContext context) {
    return PageView(
      onPageChanged: (int pageIndex) {
        switch (pageIndex) {
          case 1:
            if (kDebugMode) print("AnaEkran");
            Vibration.vibrate(amplitude: 180, duration: 700);

            break;
          case 2:
            if (kDebugMode) print("PodcastEkran");
            Vibration.vibrate(amplitude: 100, duration: 400);
            break;
          default:
        }
      },
      controller: _pageController,
      scrollDirection: Axis.vertical,
      children: [
        const OgrenmeOyunlari(),
        const AnaEkran(),
        const PodcastEkran(),
        Kaynakca(),
        //YENİ EKRANLAR
      ],
    );
  }
}
