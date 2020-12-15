class Gunler {
  String baslik;
  bool expanded;
  String icerik;

  String get getBaslik => baslik;

  set setBaslik(String baslik) => this.baslik = baslik;

  bool get getExpanded => expanded;

  set setExpanded(bool expanded) => this.expanded = expanded;

  String get getIcerik => icerik;

  set setIcerik(String icerik) => this.icerik = icerik;

  Gunler(this.baslik, this.icerik, this.expanded);
}
