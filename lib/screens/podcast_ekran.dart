//  ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class PodcastEkran extends StatelessWidget {
  const PodcastEkran({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> podcastKonulari = [
      {
        "topic": "Osmanlı Tarihi",
        "podcasts": [
          {
            "title": "Osmanlı Kuruluş Dönemi",
            "youtubeUrl": "https://www.youtube.com/watch?v=I9FbicDRp5E",
          },
          {
            "title": "Osmanlı Yükselme Dönemi",
            "youtubeUrl": "https://www.youtube.com/watch?v=example2",
          },
          {
            "title": "Osmanlı Duraklama Dönemi",
            "youtubeUrl": "https://www.youtube.com/watch?v=example5",
          },
          {
            "title": "Osmanlı Çöküş Dönemi",
            "youtubeUrl": "https://www.youtube.com/watch?v=example6",
          },
        ],
      },
      {
        "topic": "Cumhuriyet Dönemi",
        "podcasts": [
          {
            "title": "Cumhuriyetin İlk Yılları",
            "youtubeUrl": "https://www.youtube.com/watch?v=example3",
          },
          {
            "title": "Atatürk Reformları",
            "youtubeUrl": "https://www.youtube.com/watch?v=example4",
          },
          {
            "title": "İkinci Dünya Savaşı ve Türkiye",
            "youtubeUrl": "https://www.youtube.com/watch?v=example7",
          },
        ],
      },
      {
        "topic": "Tarihsel Dönemler ve Kavramlar",
        "podcasts": [
          {
            "title": "Feodalizm ve Toplum Yapısı",
            "youtubeUrl": "https://www.youtube.com/watch?v=example18",
          },
          {
            "title": "Rönesans ve Aydınlanma",
            "youtubeUrl": "https://www.youtube.com/watch?v=example19",
          },
          {
            "title": "Sanayi Devrimi ve Sosyal Değişim",
            "youtubeUrl": "https://www.youtube.com/watch?v=example20",
          },
          {
            "title": "İlk Çağ Uygarlıkları",
            "youtubeUrl": "https://www.youtube.com/watch?v=example21",
          },
          {
            "title": "Orta Çağ Avrupası ve Feodalizm",
            "youtubeUrl": "https://www.youtube.com/watch?v=example22",
          },
          {
            "title": "İslam Medeniyeti ve Bilim",
            "youtubeUrl": "https://www.youtube.com/watch?v=example23",
          },
          {
            "title": "Coğrafi Keşifler ve Etkileri",
            "youtubeUrl": "https://www.youtube.com/watch?v=example24",
          },
          {
            "title": "Haçlı Seferleri ve Sonuçları",
            "youtubeUrl": "https://www.youtube.com/watch?v=example25",
          },
        ],
      },
    ];

    ScrollController _sWController = ScrollController(
      keepScrollOffset: false,
    );

    Future<void> _openUrl(String urlString) async {
      final Uri url = Uri.parse(urlString);
      if (await canLaunchUrl(url)) {
        await launchUrl(
          url,
          mode: LaunchMode.externalApplication,
        );
      } else {
        throw Exception('URL açılamadı: $url');
      }
    }
    //FRONTEND

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 40, 40, 42),
      appBar: AppBar(
        title: const Text(
          'Podcast Bölümü',
          style: TextStyle(
            color: Color.fromARGB(255, 233, 233, 233),
            fontFamily: 'PlayfairDisplay',
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 138, 26, 26),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 40,
          ),
          //    Padding(padding: EdgeInsets.only(left: 30)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const SizedBox(width: 30),
                  Text(
                    'Tarih ve\nPodcastler',
                    style:
                        GoogleFonts.poppins(fontSize: 40, color: Colors.white),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              SizedBox(
                height: 500,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: podcastKonulari.length,
                  itemBuilder: (BuildContext context, int index) {
                    final podcastKonusu = podcastKonulari[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Card(
                        color: Colors.white.withAlpha(0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        elevation: 8,
                        child: Container(
                          margin: const EdgeInsets.only(top: 10, bottom: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withAlpha(100),

                                blurRadius: 25,
                                offset: const Offset(0, 3), // Hafif gölge
                              ),
                            ],
                            gradient: LinearGradient(
                              colors: [
                                Colors.white.withAlpha(180),
                                Colors.white.withAlpha(220),
                                Colors.white.withAlpha(140),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    podcastKonusu["topic"],
                                    style: GoogleFonts.playfairDisplaySc(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height:
                                    1.0, // Başlık ile fotoğraflar arasında boşluk
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                controller: _sWController,
                                child: Row(
                                  children: [
                                    const SizedBox(
                                        width:
                                            8.0), // Fotoğrafların başındaki boşluk
                                    ...podcastKonusu["podcasts"].map<Widget>(
                                      (podcast) {
                                        return GestureDetector(
                                          onTap: () =>
                                              _openUrl(podcast["youtubeUrl"]),
                                          child: Container(
                                            width: 66,
                                            margin:
                                                const EdgeInsets.only(right: 2),
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: 64,
                                                  width: 64,
                                                  decoration: BoxDecoration(
                                                      color: Colors.green[300],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4.0),
                                                      image:
                                                          const DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: AssetImage(
                                                            'assets/images/podcastIcon.jpg'),
                                                      )),
                                                ),
                                                const SizedBox(
                                                  height:
                                                      .5, // Fotoğraf ile başlık arasında boşluk
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 7),
                                                  child: SizedBox(
                                                    height: 16.0,
                                                    child: Text(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      podcast["title"],
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: GoogleFonts
                                                          .playfairDisplay(
                                                              fontSize: 8,
                                                              color:
                                                                  Colors.black),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ).toList(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
