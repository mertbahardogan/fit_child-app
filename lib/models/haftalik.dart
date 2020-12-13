class Haftalik {
  String _haftalikAd;
  String _haftalikAciklama;
  String _haftalikDosya;
  String _haftalikResim;

  Haftalik(
    this._haftalikAd,
    this._haftalikAciklama,
    this._haftalikDosya,
    this._haftalikResim,
  );

  String get haftalikAd => _haftalikAd;

  set haftalikAd(String value) => _haftalikAd = value;

  String get haftalikAciklama => _haftalikAciklama;

  set haftalikAciklama(String value) => _haftalikAciklama = value;

  String get haftalikDosya => _haftalikDosya;

  set haftalikDosya(String value) => _haftalikDosya = value;

  String get haftalikResim => _haftalikResim;

  set haftalikResim(String value) => _haftalikResim = value;
}
