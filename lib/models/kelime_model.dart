class Kelimeler {
  String? kelime;
  String? kisaTanim;
  String? akademikTanim;

  Kelimeler({this.kelime, this.kisaTanim, this.akademikTanim});

  Kelimeler.fromJson(Map<String, dynamic> json) {
    kelime = json['kelime'];
    kisaTanim = json['kisa_anlam'];
    akademikTanim = json['akademik_anlam'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['kelime'] = kelime;
    data['kisaTanim'] = kisaTanim;
    data['akademikTanim'] = akademikTanim;
    return data;
  }
}
