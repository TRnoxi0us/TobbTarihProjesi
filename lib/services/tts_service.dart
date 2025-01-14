// ignore_for_file: non_constant_identifier_names, avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:googleapis/texttospeech/v1.dart' as tts;
import 'package:googleapis_auth/auth_io.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:audioplayers/audioplayers.dart';

class TtsService {
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<String> _getCacheDirectory() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<String> _getFilePath(String text, bool akademikMi) async {
    final dir = await _getCacheDirectory();
    final fileName =
        '${akademikMi ? "academic" : "short"}_${text.hashCode}.wav';
    return '$dir/$fileName';
  }

  Future<bool> _isFileCached(String filePath) async {
    return File(filePath).exists();
  }

  Future<void> _cacheAudio(String filePath, List<int> audioBytes) async {
    final file = File(filePath);
    await file.writeAsBytes(audioBytes);
  }

  Future<List<int>> _synthesizeAudio(String text) async {
    final credentialsJsonBase64 = dotenv.env['GOOGLE_CLOUD_CREDENTIALS'];
    if (credentialsJsonBase64 == null) {
      throw Exception("Google Application Credentials bulunamadı.");
    }

    final credentialsJson = utf8.decode(base64Decode(credentialsJsonBase64));
    final credentials =
        ServiceAccountCredentials.fromJson(jsonDecode(credentialsJson));

    final client = await clientViaServiceAccount(
      credentials,
      [tts.TexttospeechApi.cloudPlatformScope],
    );

    final ttsClient = tts.TexttospeechApi(client);

    var request = tts.SynthesizeSpeechRequest(
      input: tts.SynthesisInput(text: text),
      voice: tts.VoiceSelectionParams(
        languageCode: 'tr-TR',
        name: 'tr-TR-Standard-D',
      ),
      audioConfig: tts.AudioConfig(
        audioEncoding: 'LINEAR16',
        effectsProfileId: ['handset-class-device'],
        pitch: 0.0,
        speakingRate: 0.88,
      ),
    );

    try {
      final response = await ttsClient.text.synthesize(request);
      return base64Decode(response.audioContent!);
    } catch (e) {
      print('Text-to-Speech API error: $e');
      rethrow;
    } finally {
      client.close();
    }
  }

  Future<void> playOrCacheAudio(String text, bool akademikMi) async {
    final filePath = await _getFilePath(text, akademikMi);

    if (await _isFileCached(filePath)) {
      //cached mi
      // print("Önbellekten oynatılıyor: $filePath");
      await _audioPlayer.play(DeviceFileSource(filePath));
    } else {
      //   print("Önbellekte bulunamadı. Yeni ses üretiliyor...");
      final audioBytes = await _synthesizeAudio(text);
      await _cacheAudio(filePath, audioBytes);
      await _audioPlayer.play(DeviceFileSource(filePath));
    }
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
  }

  Future PauseOrResume() async {
    if (_audioPlayer.state == PlayerState.playing) {
      await _audioPlayer.pause();
      return false;
    } else if (_audioPlayer.state == PlayerState.paused) {
      await _audioPlayer.resume();
      return true;
    }
  }

  Future<void> modDegistirildi(bool yeniMod) async {
    await _audioPlayer.stop();
    if (!yeniMod) {
      //kısa
      await _audioPlayer.play(AssetSource('audio/kisa_mod.wav'));
    } else {
      //akadmeik
      await _audioPlayer.play(AssetSource('audio/akademik_mod2.wav'));
    }
  }

  Future<void> replay() async {
    if (_audioPlayer.source == null) {
      //     print('HATA ');
      return;
    } else {}

    Source audioSrc = _audioPlayer.source!;
    await _audioPlayer.stop();

    await _audioPlayer.play(audioSrc);
  }
}
