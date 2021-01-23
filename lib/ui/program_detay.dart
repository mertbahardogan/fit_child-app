import 'package:cocuklar_icin_spor_app/models/egzersiz.dart';
import 'package:cocuklar_icin_spor_app/models/gunler.dart';
import 'package:cocuklar_icin_spor_app/models/haftalik.dart';
import 'package:cocuklar_icin_spor_app/ui/program_sayfasi.dart';
import 'package:cocuklar_icin_spor_app/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ProgramDetay extends StatefulWidget {
  int gelenIndex;
  ProgramDetay(this.gelenIndex);

  @override
  _ProgramDetayState createState() => _ProgramDetayState();
}

class _ProgramDetayState extends State<ProgramDetay> {
  bool deger = false;
  Color renk = Colors.grey.shade300;
  Haftalik secilenHafta;
  static List<Egzersiz> tumEgzersizler;
  static List<Gunler> tumGunler;

  @override
  void initState() {
    secilenHafta = ProgramSayfasi.tumHaftalar[widget.gelenIndex];

    tumGunler = verileriDondur();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var ekranHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
          SliverAppBar(
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            title: Text(
              secilenHafta.haftalikAd + " Seviye",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
            backgroundColor: Colors.grey.shade200,
            pinned: true,
            primary: true,
            expandedHeight: 55,
            elevation: 4,
          ),
          SliverList(
            delegate: SliverChildListDelegate(sabitListeElemanlari()),
          ),
          SliverList(
            delegate:
                SliverChildBuilderDelegate(_dinamikElemanUret, childCount: 7),
          ),
        ],
      ),
    );
  }

  List<Gunler> verileriDondur() {
    List<Gunler> gunler = [];

    gunler = [
      Gunler("Pazartesi", degerDondur("Pazartesi"), false, false,
          resimDondur("Pazartesi")),
      Gunler("Salı", degerDondur("Sali"), false, false, resimDondur("Sali")),
      Gunler(
          "Çarşamba", "Dinlenme zamanı", false, false, resimDondur("Dinlenme")),
      Gunler("Perşembe", "Squad", false, false, resimDondur()),
      Gunler("Cuma", "Mekik", false, false, resimDondur()),
      Gunler("Cumartesi", degerDondur("Cumartesi"), false, false,
          resimDondur("Cumartesi")),
      Gunler("Pazar", "Dinlenme zamanı", false, false, resimDondur("Dinlenme")),
    ];
    return gunler;
  }

  List<Egzersiz> verileriHazirla() {
    List<Egzersiz> egzersizler = [];
    for (int i = 0; i < 8; i++) {
      String resim = Strings.EGZERSIZ_DOSYA_ADLARI[i] + "${i + 1}.png";
      //Strings sınıfında bulunan veriler, Egzersiz sınıfında bulunan özellikler kullanılarak Liste oluşturuldu.
      Egzersiz eklenecekEgzersiz = Egzersiz(
        Strings.EGZERSIZ_ADLARI[i],
        Strings.EGZERSIZ_DOSYA_ADLARI[i],
        Strings.EGZERSIZ_CALISAN_BOLGELER[i],
        Strings.EGZERSIZ_ONERILEN_TEKRAR[i],
        Strings.EGZERSIZ_NASIL_YAPILIR[i],
        resim,
      );
      egzersizler.add(eklenecekEgzersiz);
    }
    return egzersizler;
  }

  Widget listeyiHazirla() {
    return ListView.builder(
      itemBuilder: (BuildContext context, index) {
        return topluListe(context, index);
      },
      itemCount: 7,
    );
  }

  Widget topluListe(BuildContext context, int index) {
    return ExpansionTile(
      backgroundColor: renk,
      childrenPadding: EdgeInsets.all(10),
      tilePadding: EdgeInsets.all(MediaQuery.of(context).size.height / 57),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            tumGunler[index].baslik,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 23,
            ),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Checkbox(
              value: tumGunler[index].gunCheck,
              onChanged: (value) {
                setState(() {
                  tumGunler[index].gunCheck == true
                      ? tumGunler[index].gunCheck = false
                      : tumGunler[index].gunCheck = true;

                  // tumGunler[index].gunCheck == true
                  //     ? renk = Colors.green.shade900
                  //     : renk = Colors.blue.shade900;
                });
              },
            ),
          )
        ],
      ),
      initiallyExpanded: tumGunler[index].expanded,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, "/egzersizDetay/1");
          },
          child: Container(
            height: MediaQuery.of(context).size.height / 13,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey.shade300,
                  width: 3,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset(
                  "assets/images/exercises/" + tumGunler[index].hareketResim,
                  width: MediaQuery.of(context).size.width / 8,
                  height: MediaQuery.of(context).size.height / 15,
                ),
                Text(
                  tumGunler[index].icerik,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String degerDondur(String s) {
    tumEgzersizler = verileriHazirla(); //Nesne
    return tumEgzersizler[gunDondur(s)].egzersizAdi;
  }

  String resimDondur([String s]) {
    tumEgzersizler = verileriHazirla();
    if (s == "Dinlenme")
      return "rest.png";
    else
      return tumEgzersizler[gunDondur(s)].egzersizResim;
  }

  int gunDondur([String s]) {
    int deger = 7;
    if (widget.gelenIndex == 0) {
      if (s == "Pazartesi") deger = 0;
      if (s == "Sali") deger = 1;
      if (s == "Cumartesi") deger = 2;
      if (s == null) deger = 7;
    }
    if (widget.gelenIndex == 1) {
      deger = 3;
    }
    if (widget.gelenIndex == 2) {
      deger = 4;
    }
    if (widget.gelenIndex == 3) {
      deger = 7;
    }
    return deger;
  }

  Widget _dinamikElemanUret(BuildContext context, int index) {
    return topluListe(context, index);
  }

  List<Widget> sabitListeElemanlari() {
    return [
      Container(
        margin: EdgeInsets.only(top: 10, bottom: 5, left: 5, right: 5),
        height: MediaQuery.of(context).size.height - 680,
        // width: 70,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.blueGrey.shade900,
            borderRadius: BorderRadius.circular(5),
            image: DecorationImage(
                // colorFilter: new ColorFilter.mode(
                //     Colors.blueGrey.shade900.withOpacity(0.6),
                //     BlendMode.dstATop),
                image: AssetImage(
                    "assets/images/programs/" + secilenHafta.haftalikResim),
                fit: BoxFit.contain)),
      ),
      Container(
        margin: EdgeInsets.only(top: 0, bottom: 10, left: 5, right: 5),
        height: MediaQuery.of(context).size.height / 25,
        // width: 50,
        // color: Colors.blueGrey.shade800,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              secilenHafta.haftalikAciklama,
              style: TextStyle(color: Colors.grey.shade400),
            )
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.blueGrey.shade900,
          borderRadius: BorderRadius.circular(5),
        ),
      )
    ];
  }
}
