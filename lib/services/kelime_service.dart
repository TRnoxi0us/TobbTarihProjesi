import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:ilkuyg/models/kelime_model.dart';

class KelimeServisi {
  static Future<List<Kelimeler>> kelimeleriGetir() async {
    final String jsonString =
        await rootBundle.loadString('assets/word_list.json');

    final Map<String, dynamic> jsonData = json.decode(jsonString);

    if (jsonData['kelimeler'] != null) {
      return (jsonData['kelimeler'] as List)
          .map((kelime) => Kelimeler.fromJson(kelime))
          .toList();
    } else {
      return [];
    }
  }
}
