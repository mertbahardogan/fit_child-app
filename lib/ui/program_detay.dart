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
    return Scaffold(
      appBar: AppBar(
        title: Text(secilenHafta.haftalikAd + " Seviye"),
        centerTitle: true,
      ),
      body: listeyiHazirla(),
    );
  }

  List<Gunler> verileriDondur() {
    List<Gunler> gunler = [];

    gunler = [
      Gunler("Pazartesi", "Şınav", true),
      Gunler("Salı", degerDondur(), false),
      Gunler("Çarşamba", "Dinlenme zamanı", false),
      Gunler("Perşembe", "Squad", false),
      Gunler("Cuma", "Mekik", false),
      Gunler("Cumartesi", degerDondur(), false),
      Gunler("Pazar", "Dinlenme zamanı", false),
    ];
    return gunler;
  }

  List<Egzersiz> verileriHazirla() {
    List<Egzersiz> egzersizler = [];
    for (int i = 0; i < 8; i++) {
      String resim = Strings.EGZERSIZ_DOSYA_ADLARI[i] + "${i + 1}.png";
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
      backgroundColor: Colors.blueGrey.shade900,
      childrenPadding: EdgeInsets.all(10),
      tilePadding: EdgeInsets.all(MediaQuery.of(context).size.height / 57),
      title: Text(
        tumGunler[index].baslik,
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
        textAlign: TextAlign.center,
      ),
      initiallyExpanded: tumGunler[index].expanded,
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 7,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.blueGrey.shade200,
              border: Border.all(
                color: Colors.grey,
                width: 3,
              ),
              borderRadius: BorderRadius.all(Radius.circular(14))),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.star,
                    size: 26,
                    color: Colors.blueGrey.shade900,
                  ),
                  Text(
                    tumGunler[index].icerik,
                    style: TextStyle(fontSize: 22),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  String degerDondur() {
    tumEgzersizler = verileriHazirla();
    return tumEgzersizler[gunDondur()].egzersizAdi;
  }

  int gunDondur() {
    // tumGunler = verileriDondur();
    int deger = 7;
    if (widget.gelenIndex == 0) {
      deger = 2;
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
}

/*degerDondur metotu içinde gün listesi alınıp
günün başlığına göre farklı programlar üretilecek.

Childlar içine hareketlerin minik resimleri gelebilir
*/
