import 'package:cocuklar_icin_spor_app/admob/admob_islemleri.dart';
import 'package:cocuklar_icin_spor_app/models/favori_durum.dart';
import 'package:cocuklar_icin_spor_app/ui/egzersiz_detay.dart';
import 'package:cocuklar_icin_spor_app/utils/database_helper.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';

class FavoriSayfasi extends StatefulWidget {
  @override
  _FavoriSayfasiState createState() => _FavoriSayfasiState();
}

class _FavoriSayfasiState extends State<FavoriSayfasi> {
  DatabaseHelper _databaseHelper;
  List<FavoriDurum> tumKaydedilenlerListesi;
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  InterstitialAd myInterstitialAd;
  @override
  void initState() {
    super.initState();
    AdmobIslemleri.admobInitialize();
    if (AdmobIslemleri.favoriGosterimSayac < 1) {
      myInterstitialAd = AdmobIslemleri.buildInterstitialAd();
      myInterstitialAd
        ..load()
        ..show();
      AdmobIslemleri.favoriGosterimSayac++;
    }
    tumKaydedilenlerListesi = List<FavoriDurum>();
    _databaseHelper = DatabaseHelper();
  }

  @override
  void dispose() {
    if (myInterstitialAd != null) myInterstitialAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double en = MediaQuery.of(context).size.width;
    double boy = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text(
          "Favori Hareketler",
          style: Theme.of(context).appBarTheme.textTheme.headline1,
        ),
      ),
      body: listeHazirla(en, boy),
    );
  }

  Widget listeHazirla(en, boy) {
    return FutureBuilder(
        future: _databaseHelper.favoriListesiniGetir(),
        builder: (context, AsyncSnapshot<List<FavoriDurum>> snapShot) {
          if (snapShot.connectionState == ConnectionState.done) {
            tumKaydedilenlerListesi = snapShot.data;
            return tumKaydedilenlerListesi.length == 0
                ? Center(
                    child: Text(
                    "Henüz favori hareket eklenmedi.",
                    style: TextStyle(
                        color: Colors.blueGrey.shade900, fontSize: en / 27),
                  ))
                : ListView.builder(
                    itemCount: tumKaydedilenlerListesi.length,
                    itemBuilder: (BuildContext context, int index) {
                      return cardGetir(context, index, en, boy);
                    });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget cardGetir(BuildContext context, int index, double en, boy) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EgzersizDetay(
                        int.parse(tumKaydedilenlerListesi[index].hareketID))))
            .then((value) {
          setState(() {});
        });
      },
      child: Container(
        child: Column(
          children: [
            Card(
              child: ListTile(
                tileColor: Colors.white,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: en / 10,
                      height: boy / 18,
                      child: Center(child: Text((index + 1).toString())),
                      color: Colors.deepOrange.withOpacity(0.3),
                    ),
                    Column(
                      children: [
                        Text(
                          tumKaydedilenlerListesi[index].hareketAd.toString(),
                          style: TextStyle(
                              fontSize: en / 24,
                              color: Colors.blueGrey.shade900),
                        ),
                        Text(
                          "Detaylar için dokunun.",
                          style:
                              TextStyle(fontSize: en / 37, color: Colors.grey),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.favorite,
                      color: Colors.deepOrange.shade800,
                      size: en / 16,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
