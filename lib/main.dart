// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

//TODO: PAGE VIEW VE MODUÜLER YAPIYI BİR ARADA KULLANARAK SAYFA MANTIĞIN IAMAMLA. KONTROLLERİ TARTIS VE DEMOYU GONDER.
//NOTLAR: PERMISSION HANDLER PACKAGE
void main() {
  runApp(const Uygulama());
}

class Uygulama extends StatelessWidget {
  const Uygulama({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
//    debugShowCheckedModeBanner: false,
      home: AnaEkran(),
    );
  }
}

class AnaEkran extends StatelessWidget {
  const AnaEkran({super.key});

  @override
  Widget build(BuildContext context) {
    String? swipeDirection;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 40, 40, 41),
      appBar: AppBar(
        title: const Text(
          'Sesli Tarih Projesi',
          style: TextStyle(
            color: Color.fromARGB(255, 233, 233, 233),
            fontFamily: 'PlayfairDisplay',
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 138, 26, 26),
        centerTitle: true,
      ),
      body: GestureDetector(
        onPanUpdate: (details) {
          int sensivity = 8; // Sensivity burdan değiştirilebilir.
          if (details.delta.dx > sensivity) {
            print(details.delta.dx);
            swipeDirection = 'right';
          } else if (details.delta.dx < -sensivity) {
            swipeDirection = 'left';
          }
          print("kaydirma haraketi");
        },
        //TODO: Swipe kontroller için TEK bir fonskiyon oluştur. ve onu çağır. anonim fonksiyon kullanma. parametre yerine isAcademic kullan.
        onPanEnd: (details) {
          if (swipeDirection == 'left') {
            _kaydirmaKontrolcusu(context, isAcademic: false);
          }
          if (swipeDirection == 'right') {
            _kaydirmaKontrolcusu(context, isAcademic: true);
          }
          swipeDirection = null; // Yönü sıfırla
        }, //diger kontroller
        onDoubleTap: () {
          print('Çift tıklandı.');
        },

        onLongPress: () {
          print('Uzun basıldı.');
        },
      ),
    );
  }
}

void _kaydirmaKontrolcusu(BuildContext context, {required bool isAcademic}) {
  if (isAcademic) {
    //AKADEMİK TANIM
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Sağa kaydırıldı.')),
    );
  } else {
    //NORMAL TANIM
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Sola kaydırıldı.')),
    );
  }
}
