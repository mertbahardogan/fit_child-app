import 'package:cocuklar_icin_spor_app/admob/admob_islemleri.dart';
import 'package:cocuklar_icin_spor_app/models/haftalik.dart';
import 'package:cocuklar_icin_spor_app/utils/program.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ProgramSayfasi extends StatefulWidget {
  static List<Haftalik> tumHaftalar;

  @override
  _ProgramSayfasiState createState() => _ProgramSayfasiState();
}

class _ProgramSayfasiState extends State<ProgramSayfasi> {
  InterstitialAd myInterstitialAd;

  @override
  void initState() {
    super.initState();
    AdmobIslemleri.admobInitialize();
    if (AdmobIslemleri.programGosterimSayac < 2) {
      myInterstitialAd = AdmobIslemleri.buildInterstitialAd();
      myInterstitialAd
        ..load()
        ..show();
      AdmobIslemleri.programGosterimSayac++;
    }
  }

  @override
  void dispose() {
    if (myInterstitialAd != null) myInterstitialAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double en = MediaQuery.of(context).size.width;
    double boy = MediaQuery.of(context).size.width;
    ProgramSayfasi.tumHaftalar = verileriHazirla();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Haftalık Spor Programı",
          style: Theme.of(context).appBarTheme.textTheme.headline1,
        ),
      ),
      body: listeHazirla(en, boy),
    );
  }

  List<Haftalik> verileriHazirla() {
    List<Haftalik> haftalar = [];

    for (int i = 0; i < 4; i++) {
      String resim = Program.PROGRAM_DOSYA[i] + ".png";

      Haftalik eklenecekAdim = Haftalik(
        Program.PROGRAM_AD[i],
        Program.PROGRAM_DOSYA[i],
        Program.PROGRAM_ACIKLAMA[i],
        resim,
      );
      haftalar.add(eklenecekAdim);
    }
    return haftalar;
  }

  Widget listeHazirla(en, boy) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return tekSatirContainer(context, index, en, boy);
      },
      itemCount: ProgramSayfasi.tumHaftalar.length,
    );
  }

  Widget tekSatirContainer(BuildContext context, int index, double en, boy) {
    Haftalik oAnEklenecek = ProgramSayfasi.tumHaftalar[index];

    return GestureDetector(
      child: Container(
        margin: EdgeInsets.all(10),
        alignment: Alignment.center,
        width: en,
        height: boy / 2.9,
        decoration: BoxDecoration(
          color: Colors.grey.shade500, //blue.shade400
          borderRadius: BorderRadius.all(
            Radius.circular(14),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              "assets/images/levels/" + oAnEklenecek.haftalikResim,
              width: en / 3,
              height: boy / 3.1,
              alignment: Alignment.topCenter,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  oAnEklenecek.haftalikAd + " Seviye",
                  style: TextStyle(
                      color: renkUret(oAnEklenecek.haftalikAd),
                      fontSize: en / 16,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: en / 20,
                ),
                Text(
                    "Egzersizler " +
                        oAnEklenecek.haftalikAciklama +
                        " saniye 3-4 set yapılabilir.",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: en / 40,
                        fontWeight: FontWeight.w400)),
              ],
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, "/programDetay/$index");
      },
    );
  }

  Color renkUret(String level) {
    Color renk;
    if (level == "Başlangıç") renk = Colors.greenAccent;
    if (level == "Orta") renk = Colors.yellowAccent;
    if (level == "İyi") renk = Colors.redAccent;
    if (level == "Üst") renk = Colors.black;

    return renk;
  }
}
