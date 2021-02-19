import 'package:cocuklar_icin_spor_app/admob/admob_islemleri.dart';
import 'package:cocuklar_icin_spor_app/models/kisisel.dart';
import 'package:cocuklar_icin_spor_app/utils/database_helper.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';

class BilgileriGuncelle extends StatefulWidget {
  @override
  _BilgileriGuncelleState createState() => _BilgileriGuncelleState();
}

class _BilgileriGuncelleState extends State<BilgileriGuncelle> {
  var otomatikKontrol = AutovalidateMode.disabled;
  var _formKey = GlobalKey<FormState>();

  DatabaseHelper _databaseHelper;
  List<Kisisel> tumKisiselVerilerListesi;
  var _controller = TextEditingController();
  BannerAd myBannerAd;

  @override
  void initState() {
    super.initState();
    tumKisiselVerilerListesi = List<Kisisel>();
    _databaseHelper = DatabaseHelper();
    _databaseHelper.tumKayitlar().then((tumKayitlariTutanMapList) {
      for (Map okunanKayitListesi in tumKayitlariTutanMapList) {
        tumKisiselVerilerListesi
            .add(Kisisel.dbdenOkudugunDegeriObjeyeDonustur(okunanKayitListesi));
      }
      setState(() {
        _controller.text = tumKisiselVerilerListesi[0].adSoyad;
      });
    }).catchError((hata) => print("İnit state hata fonk: " + hata));
    AdmobIslemleri.admobInitialize();
    myBannerAd = AdmobIslemleri.buildBannerAd();
  }

  @override
  void dispose() {
    myBannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    myBannerAd
      ..load()
      ..show();
      
    double ekranHeight = MediaQuery.of(context).size.height;
    double ekranWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text("Yenilik Zamanı"),
        centerTitle: true,
      ),
      body: Padding(
          padding: EdgeInsets.only(
              top: ekranHeight / 7,
              left: ekranWidth / 10,
              right: ekranWidth / 10),
          child: Form(
            key: _formKey,
            autovalidateMode: otomatikKontrol,
            child: ListView(
              children: [
                Padding(
                  child: Image.asset(
                    "assets/images/general/user.png",
                    width: 100,
                    height: 100,
                  ),
                  padding: EdgeInsets.only(bottom: 40),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.account_box_rounded),
                    labelText: "Kullanıcı Adı",
                    border: OutlineInputBorder(),
                  ),
                  autofocus: false,
                  maxLength: 15,
                  controller: _controller,
                  validator: _isimKontrol,
                ),
                RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _kayitGuncelle(Kisisel.withID(1, _controller.text));
                    }
                  },
                  color: Colors.blueGrey.shade900,
                  child: Text(
                    "Güncelle",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  String _isimKontrol(String deger) {
    RegExp regex = RegExp("[a-zA-Z]+\$");
    if (!regex.hasMatch(deger))
      return 'Ad alanı geçersiz değer içermemeli.\n(Boşluk, Sayı vb.)';
    else
      return null;
  }

  void _kayitGuncelle(Kisisel kisisel) async {
    var sonuc = await _databaseHelper.kayitGuncelle(kisisel);
    debugPrint(sonuc.toString());
    if (sonuc == 1) {
      setState(() {
        tumKisiselVerilerListesi[0] = kisisel;
      });
      Navigator.of(context).pop();
    }
  }
}
