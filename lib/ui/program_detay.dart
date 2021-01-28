import 'package:cocuklar_icin_spor_app/models/egzersiz.dart';
import 'package:cocuklar_icin_spor_app/models/gunler.dart';
import 'package:cocuklar_icin_spor_app/models/haftalik.dart';
import 'package:cocuklar_icin_spor_app/models/program_durum.dart';
import 'package:cocuklar_icin_spor_app/ui/program_sayfasi.dart';
import 'package:cocuklar_icin_spor_app/utils/database_helper.dart';
import 'package:cocuklar_icin_spor_app/utils/strings.dart';
// import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ProgramDetay extends StatefulWidget {
  int gelenIndex;
  ProgramDetay(this.gelenIndex);

  @override
  _ProgramDetayState createState() => _ProgramDetayState();
}

class _ProgramDetayState extends State<ProgramDetay> {
  //
  DatabaseHelper _databaseHelper;
  List<ProgramDurum> tumKaydedilenlerListesi;
  bool secilenDurum = false;

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

    tumKaydedilenlerListesi = List<ProgramDurum>();
    _databaseHelper = DatabaseHelper();
    _databaseHelper.tumProgramDurumlar().then((value) {
      for (Map okunanHareketListesi in value) {
        tumKaydedilenlerListesi.add(
            ProgramDurum.dbdenOkudugunDegeriObjeyeDonustur(
                okunanHareketListesi));
      }
      for (int i = 0; i < tumKaydedilenlerListesi.length; i++) {
        //b
        if (tumKaydedilenlerListesi[i].haftaID ==
            widget.gelenIndex.toString()) {
          secilenDurum = true;
          break;
        }
      }
      debugPrint(secilenDurum.toString());
      setState(() {});
    }).catchError((hata) => print("İnit state hata alındı: " + hata));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
          SliverAppBar(
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  secilenHafta.haftalikAd + " Seviye",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Checkbox(
                    activeColor: Colors.deepOrange.shade800,
                    value: secilenDurum,
                    // value: valueDondur(widget.gelenIndex),
                    onChanged: (value) {
                      setState(() {
                        //b
                        while (secilenDurum == false) {
                          _programDurumEkle(ProgramDurum(
                              secilenDurum.toString(),
                              widget.gelenIndex.toString()));
                          secilenDurum = value;
                          alertTebrikGoster(context, widget.gelenIndex);
                          break;
                        }
                        debugPrint(widget.gelenIndex.toString());
                        if (tumKaydedilenlerListesi.length == 0) {
                          _programDurumEkle(ProgramDurum(
                              secilenDurum.toString(),
                              widget.gelenIndex.toString()));
                          secilenDurum = value;
                        }
                        for (int i = 0;
                            i < tumKaydedilenlerListesi.length;
                            i++) {
                          if (tumKaydedilenlerListesi[i].haftaID ==
                              widget.gelenIndex.toString()) {
                            _programDurumSil(tumKaydedilenlerListesi[i].id, i);
                            secilenDurum = value;
                            break;
                          }
                          // else {
                          //   debugPrint("durumekle çalıştı");
                          //   _programDurumEkle(ProgramDurum(
                          //       secilenDurum.toString(),
                          //       widget.gelenIndex.toString(),
                          //       "0"));
                          //   secilenDurum = value;
                          //   break;
                          // }
                        }
                      });
                    },
                  ),
                )
              ],
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
          resimDondur("Pazartesi"), detayDondur("Pazartesi")),
      Gunler("Salı", degerDondur("Sali"), false, false, resimDondur("Sali"),
          detayDondur("Sali")),
      Gunler("Çarşamba", degerDondur("Çarşamba"), false, false,
          resimDondur("Çarşamba"), detayDondur("Çarşamba")),
      Gunler("Perşembe", degerDondur("Perşembe"), false, false,
          resimDondur("Perşembe"), detayDondur("Perşembe")),
      Gunler("Cuma", degerDondur("Cuma"), false, false, resimDondur("Cuma"),
          detayDondur("Cuma")),
      Gunler("Cumartesi", degerDondur("Cumartesi"), false, false,
          resimDondur("Cumartesi"), detayDondur("Cumartesi")),
      Gunler("Pazar", degerDondur("Pazar"), false, false, resimDondur("Pazar"),
          detayDondur("Pazar")),
    ];
    return gunler;
  }

  List<Egzersiz> verileriHazirla() {
    List<Egzersiz> egzersizler = [];
    for (int i = 0; i < 9; i++) {
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
              fontWeight: FontWeight.w400,
              fontSize: 22,
            ),
            textAlign: TextAlign.center,
          ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 15),
          //   child: Checkbox(
          //     activeColor: Colors.yellow.shade800,
          //     value: valueDurum,
          //     onChanged: (value) {
          //       setState(() {
          //       });
          //     },
          //   ),
          // )
        ],
      ),
      initiallyExpanded: tumGunler[index].expanded,
      children: [
        InkWell(
          onTap: () {
            aciklamaAlertDialog(context, index);
          },
          child: Hero(
            tag: widget.gelenIndex,
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
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
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
    return tumEgzersizler[gunDondur(s)].egzersizResim;
  }

  String detayDondur([String s]) {
    tumEgzersizler = verileriHazirla();
    return tumEgzersizler[gunDondur(s)].egzersizDetay;
  }

  int gunDondur([String s]) {
    int deger = 7;
    if (widget.gelenIndex == 0) {
      deger = basProgramOlustur(s);
    }
    if (widget.gelenIndex == 1) {
      deger = iyiProgramOlustur(s);
    }
    if (widget.gelenIndex == 2) {
      deger = ortaProgramOlustur(s);
    }
    if (widget.gelenIndex == 3) {
      deger = ustProgramOlustur(s);
    }
    return deger;
  }

  int basProgramOlustur(String s) {
    int value = 7;
    switch (s) {
      case "Pazartesi":
        value = 0;
        break;
      case "Sali":
        value = 1;
        break;
      case "Çarşamba":
        value = 8;
        break;
      case "Perşembe":
        value = 0;
        break;
      case "Cuma":
        value = 1;
        break;
      case "Cumartesi":
        value = 8;
        break;
      case "Pazar":
        value = 8;
        break;
    }
    return value;
  }

  int iyiProgramOlustur(String s) {
    int value = 0;
    if (s == "Pazartesi") value = 0;
    if (s == "Sali") value = 1;
    if (s == "Çarşamba") value = 8; //dinlenme
    if (s == "Perşembe") value = 5;
    if (s == "Cuma") value = 1;
    if (s == "Cumartesi") value = 8;
    if (s == "Pazar") value = 8;
    return value;
  }

  int ortaProgramOlustur(String s) {
    int value = 0;
    if (s == "Pazartesi") value = 0;
    if (s == "Sali") value = 1;
    if (s == "Çarşamba") value = 8; //dinlenme
    if (s == "Perşembe") value = 5;
    if (s == "Cuma") value = 1;
    if (s == "Cumartesi") value = 0;
    if (s == "Pazar") value = 8;
    return value;
  }

  int ustProgramOlustur(String s) {
    int value = 0;
    if (s == "Pazartesi") value = 0;
    if (s == "Sali") value = 1;
    if (s == "Çarşamba") value = 0;
    if (s == "Perşembe") value = 5;
    if (s == "Cuma") value = 0;
    if (s == "Cumartesi") value = 5;
    if (s == "Pazar") value = 8;
    return value;
  }

  Widget _dinamikElemanUret(BuildContext context, int index) {
    return topluListe(context, index);
  }

  List<Widget> sabitListeElemanlari() {
    return [
      Container(
        margin: EdgeInsets.only(top: 15, bottom: 5, left: 5, right: 5),
        height: MediaQuery.of(context).size.height - 680,
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
        margin: EdgeInsets.only(top: 0, bottom: 15, left: 5, right: 5),
        height: MediaQuery.of(context).size.height / 24,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Tüm egzersizlerden önce ısınma hareketleri yapılmalıdır.",
              style: TextStyle(
                  color: Colors.blueGrey.shade900,
                  fontWeight: FontWeight.w500,
                  fontSize: 12),
            )
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.deepOrange.shade400,
          borderRadius: BorderRadius.circular(5),
        ),
      )
    ];
  }

  void aciklamaAlertDialog(BuildContext ctx, int index) {
    showDialog(
        context: ctx,
        barrierDismissible: false,
        builder: (ctx) {
          return Hero(
            tag: widget.gelenIndex,
            child: AlertDialog(
              title: Center(
                child: Text(
                  tumGunler[index].icerik,
                  style: TextStyle(color: Colors.yellow.shade800),
                ),
              ),
              backgroundColor: Colors.blueGrey.shade900,
              content: SingleChildScrollView(
                  child: Text(
                tumGunler[index].hareketDetay,
                style: TextStyle(color: Colors.white),
              )),
              actions: [
                RaisedButton(
                    color: Colors.white,
                    child: Text(
                      "Anladım",
                      style: TextStyle(color: Colors.blueGrey.shade900),
                    ),
                    onPressed: () => Navigator.of(ctx).pop()),
              ],
            ),
          );
        });
  }

  //int haftaIndex, int gunIndex
  void _programDurumEkle(ProgramDurum programDurum) async {
    var eklenenDurumID = await _databaseHelper.durumEkle(programDurum);
    programDurum.id = eklenenDurumID;
    setState(() {
      tumKaydedilenlerListesi.insert(0, programDurum);
    });
  }

  void _programDurumSil(int forDBtoDeleteID, int forListtoDeleteIndex) async {
    var sonuc = await _databaseHelper.programDurumSil(forDBtoDeleteID);
    if (sonuc == 1) {
      setState(() {
        tumKaydedilenlerListesi.removeAt(forListtoDeleteIndex);
      });
    }
  }

  void alertTebrikGoster(BuildContext ctx, int gelenIndex) {
    showDialog(
        context: ctx,
        barrierDismissible: false,
        builder: (ctx) {
          return AlertDialog(
            title: Column(children: [
              Text(
                "Tebrikler!",
                style: TextStyle(
                    color: Colors.green.shade400,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              Center(
                child: Text(
                  secilenHafta.haftalikAd + " Seviyesini tamamladın.",
                  style: TextStyle(color: Colors.green.shade100, fontSize: 14),
                ),
              ),
            ]),
            backgroundColor: Colors.blueGrey.shade900,
            content: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 10, left: 45),
                child: Row(
                  children: [
                    Text(
                      "Sıradaki Seviye: ",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    Text(
                      ProgramSayfasi.tumHaftalar[gelenIndex + 1].haftalikAd,
                      style: TextStyle(
                          color: Colors.green.shade100,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    )
                  ],
                ),
              ),
            ),
            actions: [
              FlatButton(
                child: Text(
                  "Kapat",
                  style: TextStyle(color: Colors.redAccent, fontSize: 10),
                ),
                onPressed: () => Navigator.of(ctx).pop(),
              ),
            ],
          );
        });
  }
}
//0-2
