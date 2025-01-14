import 'package:flutter/material.dart';
import 'package:ilkuyg/screens/intro_ekranlar/ekran_1.dart';
import 'package:ilkuyg/screens/intro_ekranlar/ekran_2.dart';
import 'package:ilkuyg/screens/intro_ekranlar/ekran_5.dart';
import 'package:ilkuyg/screens/page_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:audioplayers/audioplayers.dart';
import 'intro_ekranlar/ekran_4.dart';
import 'intro_ekranlar/ekran_3.dart';

class KarsilamaEkrani extends StatefulWidget {
  const KarsilamaEkrani({super.key});

  @override
  State<KarsilamaEkrani> createState() => _KarsilamaEkraniState();
}

class _KarsilamaEkraniState extends State<KarsilamaEkrani> {
  final PageController _controller = PageController();
  final AudioPlayer _audioPlayer = AudioPlayer(); // intit audio,

  bool onLastPage = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _sayfaBasinaSesCal(0);
    });
  }

  Future<void> _sayfaBasinaSesCal(int pageIndeks) async {
    final List<String> audioFiles = [
      'audio/intro1.2.wav',
      'audio/intro2.1.wav',
      'audio/intro3_ss1.1.wav',
      'audio/intro4.wav',
      'audio/intro5.wav',
    ];

    if (pageIndeks < audioFiles.length) {
      await _audioPlayer.stop();
      await _audioPlayer.play(AssetSource(audioFiles[pageIndeks]));

      //yeni sesi çal
    }
  }

  @override
  @override
  void dispose() {
    _audioPlayer.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onDoubleTap: () async {
          if (!onLastPage) {
            final aktifSayfa = _controller.page?.toInt() ?? 0;
            await _sayfaBasinaSesCal(aktifSayfa);
          } else {
            //TAMAM BUTONU GİBİ DAVRANIR
            final prefs = await SharedPreferences.getInstance();
            prefs.setBool('showHome', true);
            if (!mounted) return;
            // ignore: use_build_context_synchronously
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const SayfaView()),
            );
          }
        },
        onLongPress: () {
          _controller.animateToPage(
            5,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeIn,
          );
        },
        child: Stack(children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() => onLastPage = index == 4);
              _sayfaBasinaSesCal(index); // Sayfa değiştiğinde ses çal
            },
            children: const [
              IntroEkran1(),
              IntroEkran2(),
              IntroEkran3(),
              IntroEkran4(),
              IntroEkran5(),
            ],
          ),
          Container(
            alignment: const Alignment(0, 0.85),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    _controller.animateToPage(
                      5,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                    );
                  },
                  child: const Text(
                    'ATLA',
                    style: TextStyle(
                      color: Color.fromARGB(255, 233, 233, 233),
                    ),
                  ),
                ),
                SmoothPageIndicator(
                    controller: _controller,
                    count: 5,
                    effect: const ExpandingDotsEffect(
                      activeDotColor: Color.fromARGB(255, 138, 26, 26),
                    ),
                    onDotClicked: (index) => _controller.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        )),
                onLastPage
                    ? TextButton(
                        onPressed: () async {
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setBool('showHome', true);
                          if (!mounted) return;
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => const SayfaView()),
                          );
                        },
                        child: const Text(
                          'TAMAM',
                          style: TextStyle(
                            color: Color.fromARGB(255, 233, 233, 233),
                          ),
                        ),
                      )
                    : TextButton(
                        onPressed: () {
                          _controller.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        },
                        child: const Text(
                          'SONRAKI',
                          style: TextStyle(
                            color: Color.fromARGB(255, 233, 233, 233),
                          ),
                        ),
                      )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
