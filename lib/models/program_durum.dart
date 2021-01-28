class ProgramDurum {
  int _id;
  String _durum;
  String _haftaID;

  String get durum => _durum;

  set durum(String value) => this._durum = value;

  String get haftaID => this._haftaID;

  set haftaID(String value) => _haftaID = value;

  int get id => _id;

  set id(int value) => this._id = value;

  ProgramDurum(
    this._durum,
    this._haftaID,
  );

  Map<String, dynamic> dbyeYazmakIcinMapeDonustur() {
    var map = Map<String, dynamic>();

    map["programID"] = _id;
    map["programDurum"] = _durum;
    map["programHaftaID"] = _haftaID;
    return map;
  }

  ProgramDurum.dbdenOkudugunDegeriObjeyeDonustur(Map<String, dynamic> map) {
    this._id = map["programID"];
    this._durum = map["programDurum"];
    this._haftaID = map["programHaftaID"];
  }

  @override
  String toString() {
    return "ProgramDurum{id: $_id, Hafta ID: $_haftaID,Durum: $_durum}";
  }
}
