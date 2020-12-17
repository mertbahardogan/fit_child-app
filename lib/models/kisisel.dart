class Kisisel {
  int _id;
  String _adSoyad;
  int _yas;

  int get id => _id;

  set id(int value) => this._id = value;

  String get adSoyad => _adSoyad;

  set adSoyad(String value) => this._adSoyad = value;

  int get yas => _yas;

  set yas(int value) => this._yas = value;

  Kisisel(
    this._adSoyad,
    this._yas,
  );

  Kisisel.withID(
    this._id,
    this._adSoyad,
    this._yas,
  );

  Map<String, dynamic> dbyeYazmakIcinMapeDonustur() {
    var map = Map<String, dynamic>();

    map["id"] = _id;
    map["adSoyad"] = _adSoyad;
    map["yas"] = _yas;
    return map;
  }

  Kisisel.dbdenOkudugunDegeriObjeyeDonustur(Map<String, dynamic> map) {
    this._id = map["id"];
    this._adSoyad = map["adSoyad"];
    this._yas = map["yas"];
  }

  @override
  String toString() {
    return "Kisisel{id: $_id, Ad Soyad: $_adSoyad, Yaş: $_yas}";
  }
}
