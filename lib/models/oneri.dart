class Oneri {
  String _oneriAd;
  String _oneriDosyaAd;
  String _oneriFayda;
  String _oneriResim;
  String _oneriBolge;
  String _oneriTavsiye;

  Oneri(
    this._oneriAd,
    this._oneriDosyaAd,
    this._oneriFayda,
    this._oneriResim,
    this._oneriBolge,
    this._oneriTavsiye,
  );

  String get oneriAd => _oneriAd;

  set oneriAd(String value) => this._oneriAd = value;

  String get oneriDosyaAd => _oneriDosyaAd;

  set oneriDosyaAd(String value) => this._oneriDosyaAd = value;

  String get oneriFayda => _oneriFayda;

  set oneriFayda(String value) => this._oneriFayda = value;

  String get oneriResim => _oneriResim;

  set oneriResim(String value) => this._oneriResim = value;

  String get oneriBolge => _oneriBolge;

  set oneriBolge(String value) => this._oneriBolge = value;

  String get oneriTavsiye => _oneriTavsiye;

  set oneriTavsiye(String value) => this._oneriTavsiye = value;
}
