class Egzersiz {
  String _egzersizAdi;
  String _egzersizDosya;
  String _egzersizBolge;
  String _egzersizOneri;
  String _egzersizDetay;
  String _egzersizResim;

  Egzersiz(
    this._egzersizAdi,
    this._egzersizDosya,
    this._egzersizBolge,
    this._egzersizOneri,
    this._egzersizDetay,
    this._egzersizResim,
  );

  String get egzersizAdi => _egzersizAdi;

  set egzersizAdi(String value) => _egzersizAdi = value;

  String get egzersizDosya => _egzersizDosya;

  set egzersizDosya(String value) => _egzersizDosya = value;

  String get egzersizBolge => _egzersizBolge;

  set egzersizBolge(String value) => _egzersizBolge = value;

  String get egzersizOneri => _egzersizOneri;

  set egzersizOneri(String value) => _egzersizOneri = value;

  String get egzersizDetay => _egzersizDetay;

  set egzersizDetay(String value) => _egzersizDetay = value;

  String get egzersizResim => _egzersizResim;

  set egzersizResim(String value) => _egzersizResim = value;
}
