import 'package:cocuklar_icin_spor_app/admob/admob_islemleri.dart';
import 'package:cocuklar_icin_spor_app/methods/egzersiz_verileri_hazirla.dart';
import 'package:cocuklar_icin_spor_app/models/egzersiz.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';

class EgzersizSayfasi extends StatefulWidget {
  static List<Egzersiz> tumEgzersizler;

  @override
  _EgzersizSayfasiState createState() => _EgzersizSayfasiState();
}

class _EgzersizSayfasiState extends State<EgzersizSayfasi> {
  InterstitialAd myInterstitialAd;

  @override
  void initState() {
    super.initState();
    if (AdmobIslemleri.gosterimSayac < 15) {
      AdmobIslemleri.admobInitialize();
      myInterstitialAd = AdmobIslemleri.buildInterstitialAd();
      myInterstitialAd
        ..load()
        ..show();
      AdmobIslemleri.gosterimSayac++;
    }
  }

  @override
  void dispose() {
    if (myInterstitialAd != null) myInterstitialAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double boy = MediaQuery.of(context).size.height;
    double en = MediaQuery.of(context).size.width;
    EgzersizSayfasi.tumEgzersizler = egzersizVerileriHazirla();
    return Scaffold(
      body: listeyiHazirla(en, boy),
      appBar: AppBar(
        title: Text(
          "Tüm Hareketler",
          style: TextStyle(
              color: Colors.blueGrey.shade900, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
    );
  }

  Widget listeyiHazirla(en, boy) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: boy / 900),
      itemBuilder: (BuildContext context, int index) {
        return tekSatirCard(context, index, en, boy);
      },
      itemCount: EgzersizSayfasi.tumEgzersizler.length,
    );
  }

  Widget tekSatirCard(BuildContext context, int index, double en, boy) {
    Egzersiz oAnEklenecek = EgzersizSayfasi.tumEgzersizler[index]; //object

    return Container(
      margin: EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(3)),
        color: Colors.blue[100 * ((index % 4) + 1)],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, "/egzersizDetay/$index");
          },
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  "assets/images/exercises/" + oAnEklenecek.egzersizResim,
                  width: en / 3,
                  height: boy / 6.2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      oAnEklenecek.egzersizAdi,
                      style: TextStyle(
                          fontSize: en / 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(6))),
                      child: Padding(
                          padding: EdgeInsets.all(4),
                          child: Text(
                            EgzersizSayfasi
                                .tumEgzersizler[index].egzersizSeviye,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: en / 35,
                                color: Colors.blueGrey.shade900),
                          )),
                    )
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}
