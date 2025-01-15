import 'package:flutter/material.dart';

class Kaynakca extends StatelessWidget {
  Kaynakca({super.key});
  final ScrollController _controller = ScrollController();
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
        body: SingleChildScrollView(
          controller: _controller,
          child: const Text(
            '''Uludağ, S. (2025). Avam. TDV İslâm Ansiklopedisi. https://islamansiklopedisi.org.tr/avam
          Yıldız, H. D. (2025). Avâsım. TDV İslâm Ansiklopedisi. https://islamansiklopedisi.org.tr/avasim
          Eyice, S. (2025). Bedesten. TDV İslâm Ansiklopedisi. https://islamansiklopedisi.org.tr/bedesten
          Fayda, M. (2025). Bedevî. TDV İslâm Ansiklopedisi. https://islamansiklopedisi.org.tr/bedevi
          Topaloğlu, B. (2025). Cihad. TDV İslâm Ansiklopedisi. https://islamansiklopedisi.org.tr/cihad#2-gunumuzde-cihad
          Yazıcı, T. (2025). Çav. TDV İslâm Ansiklopedisi. https://islamansiklopedisi.org.tr/cav
          ed-Dûrî, A. (2025). Divan. TDV İslâm Ansiklopedisi. https://islamansiklopedisi.org.tr/divan--devlet#1
          Algül, H. (2025). Ensar. TDV İslâm Ansiklopedisi. https://islamansiklopedisi.org.tr/ensar
          Kütükoğlu, M. S. (2025). Ferman. TDV İslâm Ansiklopedisi. https://islamansiklopedisi.org.tr/ferman
          Algül, H. (2025). Ficâr. TDV İslâm Ansiklopedisi. https://islamansiklopedisi.org.tr/ficar
          Kafadar, C. (2025). Gazâ. TDV İslâm Ansiklopedisi. https://islamansiklopedisi.org.tr/gaza
          Terzi, M. Z. (2025). Gulâm. TDV İslâm Ansiklopedisi. https://islamansiklopedisi.org.tr/gulam#1
          Özcan, A. (2025). Hatun. TDV İslâm Ansiklopedisi. https://islamansiklopedisi.org.tr/hatun
          Hamîdullah, M. (2025). Hilfü’l-Fudûl. TDV İslâm Ansiklopedisi. https://islamansiklopedisi.org.tr/hilful-fudul
          Aynural, S. (2025). Kapan. TDV İslâm Ansiklopedisi. https://islamansiklopedisi.org.tr/kapan
          Taşağıl, A. (2025). Kurultay. TDV İslâm Ansiklopedisi. https://islamansiklopedisi.org.tr/kurultay
          Gündüz, Ş. (2025). Maniheizm. TDV İslâm Ansiklopedisi. https://islamansiklopedisi.org.tr/maniheizm
          Hanioğlu, M. Ş. (2025). Meşrutiyet. TDV İslâm Ansiklopedisi. https://islamansiklopedisi.org.tr/mesrutiyet
          Yıldız, N. (2025). Papirüs. TDV İslâm Ansiklopedisi. https://islamansiklopedisi.org.tr/papirus
          Özgüdenli, O. G. (2025). Sultan. TDV İslâm Ansiklopedisi. https://islamansiklopedisi.org.tr/sultan
          Özcan, A. (2025). Bedergâh. TDV İslâm Ansiklopedisi. https://islamansiklopedisi.org.tr/bedergah
          Erkal, M. (2025). Cizye. TDV İslâm Ansiklopedisi. https://islamansiklopedisi.org.tr/cizye#1
          Özcan, A. (2025). Cülûs. TDV İslâm Ansiklopedisi. https://islamansiklopedisi.org.tr/culus
          Kütükoğlu, M. S. (2025). Defterdar. TDV İslâm Ansiklopedisi. https://islamansiklopedisi.org.tr/defterdar
          Özcan, A. (2025). Devşirme. TDV İslâm Ansiklopedisi. https://islamansiklopedisi.org.tr/devsirme
          İpşirli, M. (2025). Enderun. TDV İslâm Ansiklopedisi. https://islamansiklopedisi.org.tr/enderun
          Başar, F. (2025). Fetret Devri. TDV İslâm Ansiklopedisi. https://islamansiklopedisi.org.tr/fetret-devri
          Koç, Y. (2025). İskân. TDV İslâm Ansiklopedisi. https://islamansiklopedisi.org.tr/iskan#5-osmanlilar
          İlgürel, M. (2025). İstimâlet. TDV İslâm Ansiklopedisi. https://islamansiklopedisi.org.tr/istimalet
          Ortaylı, İ. (2025). Kadı. TDV İslâm Ansiklopedisi. https://islamansiklopedisi.org.tr/kadi#2-osmanli-devletinde-kadi
          Özcan, A. (2025). Pençik. TDV İslâm Ansiklopedisi. https://islamansiklopedisi.org.tr/pencik
          İpşirli, M. (2025). Sadrazam. TDV İslâm Ansiklopedisi. https://islamansiklopedisi.org.tr/sadrazam
          Mert, Ö. (2025). Âyan. TDV İslâm Ansiklopedisi. https://islamansiklopedisi.org.tr/ayan
          Mumcu, A. (2025). Dîvân-ı Hümâyun. TDV İslâm Ansiklopedisi. https://islamansiklopedisi.org.tr/divan-i-humayun
          Waardenburg, J. (2025). Protestanlık. TDV İslâm Ansiklopedisi. https://islamansiklopedisi.org.tr/protestanlik
          Waardenburg, J. (2025). Reform. TDV İslâm Ansiklopedisi. https://islamansiklopedisi.org.tr/reform#1
          İlgürel, M. (2025). Subaşı. TDV İslâm Ansiklopedisi. https://islamansiklopedisi.org.tr/subasi
          İpşirli, M. (2025). Şeyhülislâm. TDV İslâm Ansiklopedisi. https://islamansiklopedisi.org.tr/seyhulislam
          Sunar, M. M. (2025). Ulûfe. TDV İslâm Ansiklopedisi. https://islamansiklopedisi.org.tr/ulufe
          Bostan, İ. (2025). Azeb. TDV İslâm Ansiklopedisi. https://islamansiklopedisi.org.tr/azeb--asker
          Emecen, F. (2025). Cebelü. TDV İslâm Ansiklopedisi. https://islamansiklopedisi.org.tr/cebelu
          İpşirli, M. (2025). Çelebi. TDV İslâm Ansiklopedisi. https://islamansiklopedisi.org.tr/celebi
          Yetkin, Ş. (2025). Çini. TDV İslâm Ansiklopedisi. https://islamansiklopedisi.org.tr/cini
          Kütükoğlu, M. S. (2025). Ferman. TDV İslâm Ansiklopedisi. https://islamansiklopedisi.org.tr/ferman
          İpşirli, M. (2025). İlmiyye. TDV İslâm Ansiklopedisi. https://islamansiklopedisi.org.tr/ilmiye
          İnalcık, H. (2025). Kanunnâme. TDV İslâm Ansiklopedisi. https://islamansiklopedisi.org.tr/kanunname
          Baykara, T. (2025). Lala. TDV İslâm Ansiklopedisi. https://islamansiklopedisi.org.tr/lala
          Öz, M. (2025). Reâya. TDV İslâm Ansiklopedisi. https://islamansiklopedisi.org.tr/reaya
          Algül, H. (2025). Şura. TDV İslâm Ansiklopedisi. https://islamansiklopedisi.org.tr/sura
          ''',
          ),
        ));
  }
}
