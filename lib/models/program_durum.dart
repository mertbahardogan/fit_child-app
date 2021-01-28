class ProgramDurum {
  int _id;
  String _durum;
  String _haftaID;
  String _gunID;

  String get durum => _durum;

  set durum(String value) => this._durum = value;

  String get haftaID => this._haftaID;

  set haftaID(String value) => _haftaID = value;

  String get gunID => _gunID;

  set gunID(String value) => this._gunID = value;

  int get id => _id;

  set id(int value) => this._id = value;

  ProgramDurum(
    // this._id,
    this._durum,
    this._haftaID,
    this._gunID,
  );

  Map<String, dynamic> dbyeYazmakIcinMapeDonustur() {
    var map = Map<String, dynamic>();

    map["programID"] = _id;
    map["programDurum"] = _durum;
    map["programHaftaID"] = _haftaID;
    map["programGunID"] = _gunID;
    return map;
  }

  ProgramDurum.dbdenOkudugunDegeriObjeyeDonustur(Map<String, dynamic> map) {
    this._id = map["programID"];
    this._durum = map["programDurum"];
    this._haftaID = map["programHaftaID"];
    this._gunID = map["programGunID"];
  }

  @override
  String toString() {
    return "ProgramDurum{id: $_id, Hafta ID: $_haftaID, Gün ID: $_gunID,Durum: $_durum}";
  }
}
