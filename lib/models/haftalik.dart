class Haftalik {
  String _haftalikAd;
  String _haftalikDosya;
  String _haftalikAciklama;
  String _haftalikResim;

  Haftalik(
    this._haftalikAd,
    this._haftalikDosya,
    this._haftalikAciklama,
    this._haftalikResim,
  );

  String get haftalikAd => this._haftalikAd;

  set haftalikAd(String value) => _haftalikAd = value;

  String get haftalikAciklama => this._haftalikAciklama;

  set haftalikAciklama(String value) => _haftalikAciklama = value;

  String get haftalikDosya => this._haftalikDosya;

  set haftalikDosya(String value) => _haftalikDosya = value;

  String get haftalikResim => this._haftalikResim;

  set haftalikResim(String value) => _haftalikResim = value;
}
