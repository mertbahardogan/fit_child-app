class Hareket {
  int _hareketID;
  String _hareketAd;
  String _hareketTarih;
  String _hareketTekrarSayisi;
  
 int get hareketID => _hareketID;

 set hareketID(int value) => _hareketID = value;

 String get hareketAd => _hareketAd;

 set hareketAd(String value) => _hareketAd = value;

 String get hareketTarih => _hareketTarih;

 set hareketTarih(String value) => _hareketTarih = value;

 String get hareketTekrarSayisi => _hareketTekrarSayisi;

 set hareketTekrarSayisi(String value) => _hareketTekrarSayisi = value;

  Hareket(
    this._hareketAd,
    this._hareketTarih,
    this._hareketTekrarSayisi,
  );

  Hareket.withID(
    this._hareketID,
    this._hareketAd,
    this._hareketTarih,
    this._hareketTekrarSayisi,
  );

  Map<String, dynamic> forWritingDbConvertMap() {
    var map = Map<String, dynamic>();

    map["hareketID"] = _hareketID;
    map["hareketAd"] = _hareketAd;
    map["hareketTarih"] = _hareketTarih;
    map["hareketTekrarSayisi"] = _hareketTekrarSayisi;
    return map;
  }

  Hareket.fromDbReadingConvertObject(Map<String, dynamic> map) {
    this._hareketID = map["hareketID"];
    this._hareketAd = map["hareketAd"];
    this._hareketTarih = map["hareketTarih"];
    this._hareketTekrarSayisi = map["hareketTekrarSayisi"];
  }

  @override
  String toString() {
    return "Hareket{id: $_hareketID, Ad: $_hareketAd, Tarih: $_hareketTarih, Tekrar Sayısı:$_hareketTekrarSayisi}";
  }
}
