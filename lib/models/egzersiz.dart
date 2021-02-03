class Egzersiz {
  //Properties
  String _egzersizAdi;
  String _egzersizDosya;
  String _egzersizBolge;
  String _egzersizOneri;
  String _egzersizDetay;
  String _egzersizResim;
  String _egzersizSeviye;

  //Değişkenler Bu Değerlerde Saklanır, Dışarda Kullanılması İçin GET SET Oluşturulur
  //Değişkenler Private Türdedir, Direk Erişilemez

  Egzersiz(
    //Default Constructor: Çağırılıp nesne oluşturulurken alacağı değerler.
    this._egzersizAdi,
    this._egzersizDosya,
    this._egzersizBolge,
    this._egzersizOneri,
    this._egzersizDetay,
    this._egzersizResim,
    this._egzersizSeviye,
  );

  Egzersiz.kaydediciOzel(
    //Named Constructor
    this._egzersizAdi,
  );

  //Var Olan Değeri Geri Döndürür
  String get egzersizAdi => this._egzersizAdi;

  //Yeni Değer Atamak İçin, Değer Döndürmez, Burada fatArrow kullanmadan if else koşullarına göre atama yapabiliriz.
  set egzersizAdi(String value) => _egzersizAdi = value;

  String get egzersizDosya => this._egzersizDosya;

  set egzersizDosya(String value) => _egzersizDosya = value;

  String get egzersizBolge => this._egzersizBolge;

  set egzersizBolge(String value) => _egzersizBolge = value;

  String get egzersizOneri => this._egzersizOneri;

  set egzersizOneri(String value) => _egzersizOneri = value;

  String get egzersizDetay => this._egzersizDetay;

  set egzersizDetay(String value) => _egzersizDetay = value;

  String get egzersizResim => this._egzersizResim;

  set egzersizResim(String value) => _egzersizResim = value;

  String get egzersizSeviye => _egzersizSeviye;

  set egzersizSeviye(String value) => this._egzersizSeviye = value;
}
