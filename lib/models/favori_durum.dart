class FavoriDurum {
  int _id;
  String _durum;
  String _hareketID;
  String _hareketAd;

  int get id => _id;

  set id(int value) => this._id = value;

  String get durum => _durum;

  set durum(String value) => this._durum = value;

  String get hareketID => _hareketID;

  set hareketID(String value) => this._hareketID = value;

  String get hareketAd => _hareketAd;

  set hareketAd(String value) => this._hareketAd = value;

  FavoriDurum(
    this._durum,
    this._hareketID,
    this._hareketAd,
  );

  Map<String, dynamic> dbyeYazmakIcinMapeDonustur() {
    var map = Map<String, dynamic>();

    map["favoriID"] = _id;
    map["favoriDurum"] = _durum;
    map["favoriHareketID"] = _hareketID;
    map["favoriHareketAd"] = _hareketAd;
    return map;
  }

  FavoriDurum.dbdenObjeyeDonustur(Map<String, dynamic> map) {
    this._id = map["favoriID"];
    this._durum = map["favoriDurum"];
    this._hareketID = map["favoriHareketID"];
    this._hareketAd = map["favoriHareketAd"];
  }
}
