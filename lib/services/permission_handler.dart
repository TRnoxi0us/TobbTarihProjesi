import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class IzinYonetcisi {
  static Future<bool> mikrofonIzniIste(BuildContext context) async {
    var status = await Permission.microphone.status;

    if (status.isGranted) {
      //MIKROFON IZNI VERILMIŞ.
      return true;
    } else {
      var result = await Permission.microphone.request();
      if (result.isGranted) {
        return true;
      } else if (result.isDenied && context.mounted) {
        _izinGerekliMesaji(context);
        return false;
      } else if (result.isPermanentlyDenied && context.mounted) {
        _izinGerekliMesaji(context, ayarEkraninaYonlendir: true);
        return false;
      }
    }
    return false;
  }

  static void _izinGerekliMesaji(BuildContext context,
      {bool ayarEkraninaYonlendir = false}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Mikrofon İzni Reddedildi.'),
          content: const Text(
              'Bu uygulaman işlevine uygun bir şekilde çalışabilmesi için mikrofon iznine ihtiyaç duyar.'
              'Lütfen ayarlardan mikrofon iznine izin verin.'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  if (ayarEkraninaYonlendir) {
                    openAppSettings();
                  }
                },
                child: const Text('Tamam'))
          ],
        );
      },
    );
  }
}
