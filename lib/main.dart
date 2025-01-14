// ignore_for_file: avoid_print, unused_import

import 'package:flutter/material.dart';
import 'package:ilkuyg/screens/ana_ekran.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/page_view.dart';
import 'screens/hosgeldin_ekran.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// TEMA EKLE

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preferences = await SharedPreferences.getInstance();
  final showHome = preferences.getBool('showHome') ?? false;
  await dotenv.load(fileName: ".env");
  runApp(Uygulama(showHome: showHome));
}

class Uygulama extends StatelessWidget {
  final bool showHome;
  const Uygulama({super.key, this.showHome = false});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
            //  surface: Color(0xff28282a),
            //primary: Color.fromARGB(255, 112, 21, 21),
            ),
      ),

      //  home: showHome ? const SayfaView() : const KarsilamaEkrani(), ENABLE TO ONE TIME
      home: const KarsilamaEkrani(),
    );
  }
}
