// ignore_for_file: avoid_print

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ilkuyg/services/kelime_service.dart';
import 'package:ilkuyg/models/kelime_model.dart';
import 'package:ilkuyg/services/permission_handler.dart';
import 'package:ilkuyg/services/tts_service.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:string_similarity/string_similarity.dart';
import 'package:vibration/vibration.dart';

class AnaEkran extends StatefulWidget {
  const AnaEkran({super.key});

  @override
  State<AnaEkran> createState() => _AnaEkranState();
}

class _AnaEkranState extends State<AnaEkran> {
  final SpeechToText _speechToText = SpeechToText();
  final TtsService _ttsService = TtsService();
  final AudioPlayer _audioPlayer = AudioPlayer();

  bool _speechEnabled = false;
  String _recognizedWords = '';
  String _kelimeTanim =
      'Dinlemeye başlamak için ekranın alt kısmındaki mikrofon ikonuna tıklayınız veya iki parmağınızı kullanarak ekranı sağa veya sola kaydırınız.';
  String _baslik = 'Dinlemeye\nBaşla';
  String _ortaBaslik = '';
  bool _isAcademic = false;
  int _aktifParmak = 0;
  bool _tanimBulundu = false;
  bool _isSynthesizing = false;
  bool _hapticEnabled = false;
  @override
  void initState() {
    super.initState();
    initSpeech();
    _initHapticFeedback();
  }

  void initSpeech() async {
    //Konuşma servisini başlat.

    bool microphoneIzni = await IzinYonetcisi.mikrofonIzniIste(context);
    if (microphoneIzni) {
      _speechEnabled = await _speechToText.initialize(
        onError: (error) {
          print('ERROR');
          print(error);
        },
        onStatus: (status) {
          if (status == 'notListening') {
            _speechToText.stop();

            setState(() {
              // Dinleme sona erdiğinde UI'yi güncelle
            });
          }
        },
      );

      setState(() {});
    }
  }

  void _initHapticFeedback() async {
    _hapticEnabled = (await Vibration.hasVibrator())!;
  }

  void _startListening() async {
    //Dinlemeye başlar.

    if (!_speechEnabled) return;

    await _speechToText.listen(
      onResult: _onSpeechResult,
      //  pauseFor: const Duration(seconds: 2),
      localeId: 'tr_TR',
      listenOptions: SpeechListenOptions(
          enableHapticFeedback: true,
          autoPunctuation: true, //PROBLEM ÇIKARTIRSA autoPunctuation KAPAT
          partialResults: false,
          cancelOnError: true),
    );
    setState(() {
      _tanimBulundu = false;

      _baslik = '';
      // _baslik = 'Dinlemeye\nBaşla';DEMODAN SONRA AKTIVE ET
      print('DinlemeyeBasla');
      _kelimeTanim =
          'Dinlemeye başlamak için ekranın alt kısmındaki mikrofon ikonuna tıklayınız veya iki parmağınızı kullanarak ekranı sağa veya sola kaydırınız.';

      _recognizedWords = '';
    });
    /* DEMODAN SONRA SİL*/
    timeoutCallback();
    /* DEMODAN SONRA SİL*/
  }

  Future<Null> timeoutCallback() {
    return Future.delayed(const Duration(milliseconds: 4000), () {
      if (_speechToText.isListening) {
        // Dinleme tamamlanmamışsa (ses alınamadıysa)
        setState(() {
          if (_recognizedWords.isEmpty) {
            _baslik = 'Dinlemeye\nBaşla'; // Başlık burada sıfırlanır
          }
        });
      }
    });
  }

  Future<void> _onSpeechResult(result) async {
    setState(() {
      _tanimBulundu = false; // başka değişken ata k
      _recognizedWords = '${result.recognizedWords}'.toLowerCase();
      _baslik = '';
    });
    print(_recognizedWords);

    // Kelimeleri getir
    print('KELIMELER GETIRILECEK');
    List<Kelimeler> kelimelerListesi = await KelimeServisi.kelimeleriGetir();
    print('kelimeler getiridi');

    // Eşik değerini belirle (örneğin, %50 eşleşme)
    const double esikDegeri = 0.5;
    double enYuksekEslesmeOrani = 0;
    Kelimeler? enCokEslesenKelime;

    // En yüksek eşleşmeyi bul
    for (var kelime in kelimelerListesi) {
      final double benzerlik = StringSimilarity.compareTwoStrings(
        kelime.kelime?.toLowerCase() ?? '',
        _recognizedWords,
      );

      if (benzerlik > enYuksekEslesmeOrani) {
        enYuksekEslesmeOrani = benzerlik;
        enCokEslesenKelime = kelime;
      }
    }

    // Eşik değerini kontrol et

    if (enYuksekEslesmeOrani >= esikDegeri && enCokEslesenKelime != null) {
      /*   String sesDosyasi = _isAcademic
          ? 'assets/audio/akademikTanim.wav'
          : 'assets/audio/kisaTanim.wav';*/ //

      String tanim = _isAcademic
          ? enCokEslesenKelime.akademikTanim ?? 'Tanım mevcut değil.'
          : enCokEslesenKelime.kisaTanim ?? 'Tanım mevcut değil.';

      //   await _audioPlayer
      //      .play(AssetSource(sesDosyasi)); // "Akademik/Kısa Tanım" sesini oynat
      if (_hapticEnabled) Vibration.vibrate(amplitude: 100, duration: 600);
      _isSynthesizing = true;

      await _ttsService.playOrCacheAudio(' $tanim', _isAcademic);

      setState(() {
        _kelimeTanim = tanim;
        _ortaBaslik = enCokEslesenKelime?.kelime ?? '';
        _tanimBulundu = true;
        _baslik = _isAcademic ? 'Akademik\nTanım' : 'Kısa\nTanım';
        _isSynthesizing = false;
      });
    } else {
      setState(() {
        _kelimeTanim =
            'Kelime Bulunamadı. Lütfen konuştuğunuz ortamın gürültüsüz ve mikrofonunuzun sorunsuz olduğunu kontrol ettikten sonra tekrar deneyiniz.';
        _baslik = 'Kelime\nBulunamadı';
        _ortaBaslik = '';
        _tanimBulundu = false;
        _isSynthesizing = false;
        if (_hapticEnabled) Vibration.vibrate(amplitude: 100, duration: 200);
        print('KELIME BULUNAMADI');
      });
    }

    _recognizedWords = '';

    print(_kelimeTanim);
    print('${_baslik}merhaba');
  }

  void _stopListening() async {
    setState(
      () {
        _kelimeTanim =
            'Dinlemeye başlamak için ekranın alt kısmındaki mikrofon ikonuna tıklayınız veya iki parmağınızı kullanarak ekranı sağa veya sola kaydırınız.';

        _ortaBaslik = '';
        _baslik = 'Dinlemeye\nBaşla';
      },
    );
    await _speechToText.stop();
    setState(() {
      if (_recognizedWords.isEmpty == true) {
        _baslik = 'Dinlemeye\nBaşla';
        _recognizedWords = ''; // Önceki tanımı sıfırladık
      }
    });
  }

  @override
  void dispose() {
    _speechToText.stop();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? swipeDirection;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 40, 40, 42),

      appBar: AppBar(
        title: const Text(
          'Sesli Tarih Projesi',
          style: TextStyle(
            color: Color.fromARGB(255, 233, 233, 233),
            fontFamily: 'PlayfairDisplay',
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 112, 21, 21),
        centerTitle: true,
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,

        onPanUpdate: (details) {
          if (_aktifParmak == 2) {
            // İki parmakla hareket
            double sensivity = MediaQuery.sizeOf(context).width / 3840;
            double movement = details.delta.dx;

            if (movement > sensivity) {
              swipeDirection = 'right';
            } else if (movement < -sensivity) {
              swipeDirection = 'left';
            }
            print("Hareket Algılandı: $swipeDirection");
          }
        },
        //kendi kendine nulluyor.

        onPanEnd: (details) {
          print("DİKKAT:" "$_aktifParmak");
          setState(() {
            if (swipeDirection == 'left') {
              _ttsService.modDegistirildi(false);
              _isAcademic = false;
              if (_hapticEnabled) Vibration.vibrate(amplitude: 50);
              _kaydirmaKontrolcusu(context, isAcademic: false);
              _speechToText.isListening ? _stopListening() : _startListening();
            } else if (swipeDirection == 'right') {
              _ttsService.modDegistirildi(true);
              _isAcademic = true;
              if (_hapticEnabled) Vibration.vibrate(amplitude: 50);
              _kaydirmaKontrolcusu(context, isAcademic: true);
              _speechToText.isListening ? _stopListening() : _startListening();
            }
            swipeDirection = null; // Yönü sıfırla
          });
        }, //diger kontroller
        onDoubleTap: () {
          try {
            _ttsService.replay();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Ses tekrar başlatıldı'),
                backgroundColor: Colors.indigo,
                showCloseIcon: true,
              ),
            );
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Ses oynatılırken bir hata oluştu.'),
                backgroundColor: Colors.pink,
                showCloseIcon: true,
              ),
            );
          }
        },

        onLongPress: () async {
          print('Uzun basıldı.');
          bool devamMi = await _ttsService.PauseOrResume();
          if (!mounted) return;
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(devamMi ? 'Ses devam ediyor' : 'Ses durduruldu'),
              backgroundColor: devamMi ? Colors.green : Colors.amber,
              showCloseIcon: true,
            ),
          );
        },
        child: Listener(
          behavior: HitTestBehavior.translucent,
          onPointerDown: (event) {
            setState(() {
              print('HOHOHOHLHOHOHOH');
              _aktifParmak++;
            });
          },
          onPointerUp: (event) {
            setState(() {
              _aktifParmak--;
            });
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 30,
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        SizedBox(
                          height: 114,
                          width: 300,
                          child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 500),
                              transitionBuilder:
                                  (Widget child, Animation<double> animation) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: SlideTransition(
                                    position: Tween<Offset>(
                                      begin: const Offset(0,
                                          1), // Başlangıç konumu (alttan yukarı)
                                      end: Offset.zero, // Bitiş konumu (merkez)
                                    ).animate(animation),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: child,
                                    ),
                                  ),
                                );
                              },
                              child: _speechToText.isListening
                                  ? Text(
                                      'Dinliyor..',
                                      key: const ValueKey(1),
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.poppins(
                                          color: Colors.white, fontSize: 40),
                                    )
                                  : Text(
                                      _baslik,
                                      // default hali = recognizedWords.isEmpty ve _isListening = false
                                      key: ValueKey(_baslik),
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.poppins(
                                          color: Colors.white, fontSize: 40),
                                    )),
                        )
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 32,
                  ),
                  Text(
                    _ortaBaslik,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.playfairDisplay(
                        fontSize: _tanimBulundu ? 36 : 0,
                        fontStyle: FontStyle.italic,
                        color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 32,
                  ),
                  Expanded(
                    child: Container(
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height *
                              0.52, // Maksimum yükseklikdart run flutter_launcher_icons:generate
                        ),
                        //singlechildscrollview
                        //         scrollDirection: Axis.vertical,
                        child: !_isSynthesizing
                            ? Text(
                                _speechToText.isListening
                                    ? 'Uygulama şu anda sizi dinliyor. Lütfen yüksek ve anlaşılır bir ses ile kelimenizi söyleyin ve ortam sesleriyle gürültünün en az olduğundan emin olun.'
                                    : _kelimeTanim,

                                overflow: TextOverflow.fade,
                                // : _kelimeTanim,
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    letterSpacing: 0.1,
                                    wordSpacing: 0.8,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300),
                              )
                            : Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const CircularProgressIndicator(
                                      color: Colors.redAccent,
                                    ),
                                    Text(
                                      'Yükleniyor..',
                                      style: GoogleFonts.poppins(
                                          color: Colors.white),
                                    )
                                  ],
                                ),
                              )),
                  ),
                  const SizedBox(
                    width: 24,
                  )
                ],
              )
            ],
          ),
        ),
      ),
      //alt bar
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: AvatarGlow(
        animate: _speechToText.isListening,
        glowColor: const Color.fromARGB(255, 184, 28, 28),
        child: FloatingActionButton.large(
            backgroundColor: const Color.fromARGB(255, 184, 28, 28),
            foregroundColor: Colors.white,
            elevation: 4.0,
            shape: const CircleBorder(),
            onPressed: () {
              print(_speechToText.isListening);
              _speechToText.isListening ? _stopListening() : _startListening();
            },
            child: _speechToText.isListening
                ? const Icon(Icons.record_voice_over)
                : const Icon(Icons.mic)),
      ),

      extendBody: true,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        height: 60,
        color: const Color.fromARGB(255, 112, 21, 21),
        notchMargin: 1.5,
        clipBehavior: Clip.antiAlias,
        // navigation
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //sol buton
            IconButton(
                onPressed: () {
                  if (!_isAcademic) return;
                  setState(() {
                    _isAcademic = false;
                    if (_hapticEnabled) {
                      Vibration.vibrate(amplitude: 150, duration: 350);
                    }
                    _kaydirmaKontrolcusu(context, isAcademic: false);
                  });
                },
                icon: Icon(
                  Icons.short_text,
                  color: !_isAcademic ? Colors.white : Colors.grey[400],
                )),
            // boşluk
            const SizedBox(
              width: 116,
            ),
            //sağ buton
            IconButton(
                onPressed: () {
                  if (_isAcademic) return;
                  setState(() {
                    _isAcademic = true;
                    if (_hapticEnabled) {
                      Vibration.vibrate(amplitude: 150, duration: 350);
                    }
                    _kaydirmaKontrolcusu(context, isAcademic: true);
                  });
                },
                icon: Icon(
                  _isAcademic ? Icons.school : Icons.school_outlined,
                  color: _isAcademic ? Colors.white : Colors.grey[400],
                ))
          ],
        ),
      ),
    );
  }
}

/*
*/
void _kaydirmaKontrolcusu(BuildContext context, {required bool isAcademic}) {
  //ScaffoldMessenger.of(context).clearSnackBars();

  if (isAcademic) {
    //AKADEMİK TANIM

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        showCloseIcon: true,
        content: Text('Akademik Mod Seçildi'),
        backgroundColor: Colors.green,
      ),
    );
  } else {
    //NORMAL TANIM
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        showCloseIcon: true,
        content: Text('Kısa Mod Seçildi'),
        backgroundColor: Colors.deepPurple,
      ),
    );
  }
}
