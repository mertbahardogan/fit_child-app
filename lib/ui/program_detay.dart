import 'dart:async';

import 'package:cocuklar_icin_spor_app/admob/admob_islemleri.dart';
import 'package:cocuklar_icin_spor_app/methods/egzersiz_verileri_hazirla.dart';
import 'package:cocuklar_icin_spor_app/models/egzersiz.dart';
import 'package:cocuklar_icin_spor_app/models/gunler.dart';
import 'package:cocuklar_icin_spor_app/models/haftalik.dart';
import 'package:cocuklar_icin_spor_app/models/program_durum.dart';
import 'package:cocuklar_icin_spor_app/ui/program_sayfasi.dart';
import 'package:cocuklar_icin_spor_app/utils/database_helper.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ProgramDetay extends StatefulWidget {
  int gelenIndex;
  ProgramDetay(this.gelenIndex);

  @override
  _ProgramDetayState createState() => _ProgramDetayState();
}

class _ProgramDetayState extends State<ProgramDetay> {
  DatabaseHelper _databaseHelper;
  List<ProgramDurum> tumKaydedilenlerListesi;
  bool secilenDurum = false;
  Color renk = Colors.grey.shade300;
  Haftalik secilenHafta;
  static List<Egzersiz> tumEgzersizler;
  static List<Gunler> tumGunler;

  @override
  void initState() {
    super.initState();
    secilenHafta = ProgramSayfasi.tumHaftalar[widget.gelenIndex];
    tumGunler = verileriDondur();
    tumKaydedilenlerListesi = List<ProgramDurum>();
    _databaseHelper = DatabaseHelper();
    _databaseHelper.tumProgramDurumlar().then((value) {
      for (Map okunanHareketListesi in value) {
        tumKaydedilenlerListesi.add(
            ProgramDurum.dbdenOkudugunDegeriObjeyeDonustur(
                okunanHareketListesi));
      }
      for (int i = 0; i < tumKaydedilenlerListesi.length; i++) {
        if (tumKaydedilenlerListesi[i].haftaID ==
            widget.gelenIndex.toString()) {
          secilenDurum = true;
          break;
        }
      }
      debugPrint(secilenDurum.toString());
      setState(() {});
    }).catchError((hata) => print("İnit state hata alındı: " + hata));

    // AdmobIslemleri.admobInitialize();

    // odulReklamYukle();

    // RewardedVideoAd.instance.listener =
    //     (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
    //   if (event == RewardedVideoAdEvent.rewarded) {
    //     setState(() {
    //       print("**************ÖDÜL KAZANDINIZ*****************" +
    //           AdmobIslemleri.odulSayac.toString());
    //       AdmobIslemleri.odulSayac++;
    //       odulReklamYukle();
    //     });
    //   } else if (event == RewardedVideoAdEvent.loaded) {
    //     RewardedVideoAd.instance.show();
    //     print("**************REKLAM YÜKLENDİ GELECEK*****************");
    //   } else if (event == RewardedVideoAdEvent.closed) {
    //     print("**************REKLAM KAPANDI*****************" +
    //         AdmobIslemleri.odulSayac.toString()); //bool
    //   } else if (event == RewardedVideoAdEvent.failedToLoad) {
    //     print("**************REKLAM BULUNAMADI*****************");
    //     odulReklamYukle();
    //   }
    // };
  }

  void odulReklamYukle() {
    RewardedVideoAd.instance.load(
        adUnitId: AdmobIslemleri.odulIdTest,
        targetingInfo: AdmobIslemleri.targetingInfo);
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
                    activeColor: Colors.blueGrey.shade900,
                    value: secilenDurum,
                    onChanged: (value) {
                      setState(() {
                        if (tumKaydedilenlerListesi.length == 0 ||
                            secilenDurum == false) {
                          _programDurumEkle(ProgramDurum(
                              secilenDurum.toString(),
                              widget.gelenIndex.toString()));
                          secilenDurum = value;
                          alertTebrikGoster(context, widget.gelenIndex);
                        }
                        for (int i = 0;
                            i < tumKaydedilenlerListesi.length;
                            i++) {
                          if (tumKaydedilenlerListesi[i].haftaID ==
                              widget.gelenIndex.toString()) {
                            alertEminMi(context, i, value);
                            break;
                          }
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
          SliverFixedExtentList(
              delegate: SliverChildListDelegate(sabitListeElemanlari()),
              itemExtent: MediaQuery.of(context).size.height / 5),
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

  Widget listeyiHazirla() {
    return ListView.builder(
      itemBuilder: (BuildContext context, index) {
        return topluListe(context, index);
      },
      itemCount: 7,
    );
  }

  Widget topluListe(BuildContext context, int index) {
    double en = MediaQuery.of(context).size.width;
    double boy = MediaQuery.of(context).size.height;
    tumEgzersizler = egzersizVerileriHazirla();
    int isinmaIndex = index % 3;
    int fitIndex = index + 4;
    int fitIndex2 = index + 5;
    int id = 0;
    return ExpansionTile(
      backgroundColor: renk,
      childrenPadding: EdgeInsets.all(10),
      tilePadding: EdgeInsets.all(boy / 57),
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
        ],
      ),
      initiallyExpanded: tumGunler[index].expanded,
      children: [
        Container(
          height: tumGunler[index].icerik != "Dinlenme" &&
                  AdmobIslemleri.odulSayac >= 1
              ? boy / 2.15
              : boy / 11,
          width: en,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.grey.shade300,
                width: 3,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: AdmobIslemleri.odulSayac >= 1
              ? tumGunler[index].icerik != "Dinlenme"
                  ? Column(
                      children: [
                        Divider(),
                        //Sabit Isınma
                        InkWell(
                          onTap: () {
                            id = 1;
                            aciklamaAlertDialog(
                                context, tumEgzersizler[3].egzersizID, id, en);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.asset(
                                "assets/images/exercises/" +
                                    tumEgzersizler[3].egzersizResim,
                                width: en / 8,
                                height: boy / 15,
                              ),
                              Text(
                                tumEgzersizler[3].egzersizAdi,
                                style: TextStyle(
                                    fontSize: en / 24,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                        //Dinamik Isınma
                        InkWell(
                          onTap: () {
                            id = 1;
                            aciklamaAlertDialog(context,
                                tumEgzersizler[isinmaIndex].egzersizID, id, en);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.asset(
                                "assets/images/exercises/" +
                                    tumEgzersizler[isinmaIndex].egzersizResim,
                                width: en / 8,
                                height: boy / 15,
                              ),
                              Text(
                                tumEgzersizler[isinmaIndex].egzersizAdi,
                                style: TextStyle(
                                    fontSize: en / 24,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                        //Dinamik Fitness
                        InkWell(
                          onTap: () {
                            id = 1;
                            aciklamaAlertDialog(context,
                                tumEgzersizler[fitIndex].egzersizID, id, en);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.asset(
                                "assets/images/exercises/" +
                                    tumEgzersizler[fitIndex].egzersizResim,
                                width: en / 8,
                                height: boy / 15,
                              ),
                              Text(
                                tumEgzersizler[fitIndex].egzersizAdi,
                                style: TextStyle(
                                    fontSize: en / 24,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                        //Dinamik Fitness2
                        InkWell(
                          onTap: () {
                            id = 1;
                            aciklamaAlertDialog(context,
                                tumEgzersizler[fitIndex2].egzersizID, id, en);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.asset(
                                "assets/images/exercises/" +
                                    tumEgzersizler[fitIndex2].egzersizResim,
                                width: en / 8,
                                height: boy / 15,
                              ),
                              Text(
                                tumEgzersizler[fitIndex2].egzersizAdi,
                                style: TextStyle(
                                    fontSize: en / 24,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                        //Dinamik Yoga
                        InkWell(
                          onTap: () {
                            id = 0;
                            aciklamaAlertDialog(context, index, id, en);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.asset(
                                "assets/images/exercises/" +
                                    tumGunler[index].hareketResim,
                                width: en / 8,
                                height: boy / 15,
                              ),
                              Text(
                                tumGunler[index].icerik,
                                style: TextStyle(
                                    fontSize: en / 24,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                      ],
                    )
                  : InkWell(
                      onTap: () {
                        id = 0;
                        aciklamaAlertDialog(context, index, id, en);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset(
                            "assets/images/exercises/" +
                                tumGunler[index].hareketResim,
                            width: en / 8,
                            height: boy / 15,
                          ),
                          Text(
                            tumGunler[index].icerik,
                            style: TextStyle(
                                fontSize: en / 24, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    )
              : GestureDetector(
                  onTap: () {
                    print("TIKKK");
                    AdmobIslemleri.admobInitialize();

                    // odulReklamYukle();
                    RewardedVideoAd.instance.load(
                        adUnitId: AdmobIslemleri.odulIdTest,
                        targetingInfo: AdmobIslemleri.targetingInfo);

                    RewardedVideoAd.instance.listener =
                        (RewardedVideoAdEvent event,
                            {String rewardType, int rewardAmount}) {
                      if (event == RewardedVideoAdEvent.rewarded) {
                        setState(() {
                          print(
                              "**************ÖDÜL KAZANDINIZ*****************" +
                                  AdmobIslemleri.odulSayac.toString());
                          AdmobIslemleri.odulSayac++;
                          odulReklamYukle();
                        });
                      } else if (event == RewardedVideoAdEvent.loaded) {
                        RewardedVideoAd.instance.show();
                        print(
                            "**************REKLAM YÜKLENDİ GELECEK*****************");
                      } else if (event == RewardedVideoAdEvent.closed) {
                        print("**************REKLAM KAPANDI*****************" +
                            AdmobIslemleri.odulSayac.toString()); //bool
                      } else if (event == RewardedVideoAdEvent.failedToLoad) {
                        print(
                            "**************REKLAM BULUNAMADI*****************");
                        odulReklamYukle();
                      }
                    };
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Center(
                          child: Text(
                        "Programlara erişmek için buraya dokun, reklamı görüntüle.",
                        style: TextStyle(
                            color: Colors.deepOrange.shade700,
                            fontSize: en / 28),
                      )),
                    ),
                  )),
        ),
      ],
    );
  }

  String degerDondur(String s) {
    tumEgzersizler = egzersizVerileriHazirla(); //Nesne
    return tumEgzersizler[gunDondur(s)].egzersizAdi;
  }

  String degerDondur2(String s) {
    tumEgzersizler = egzersizVerileriHazirla(); //Nesne
    return tumEgzersizler[gunDondur(s) + 1].egzersizAdi;
  }

  String resimDondur([String s]) {
    tumEgzersizler = egzersizVerileriHazirla();
    return tumEgzersizler[gunDondur(s)].egzersizResim;
  }

  String detayDondur([String s]) {
    tumEgzersizler = egzersizVerileriHazirla();
    return tumEgzersizler[gunDondur(s)].egzersizDetay;
  }

  int gunDondur([String s]) {
    int deger = 7;
    if (widget.gelenIndex == 0) {
      deger = basProgramOlustur(s); //0
    }
    if (widget.gelenIndex == 1) {
      deger = ortaProgramOlustur(s);
    }
    if (widget.gelenIndex == 2) {
      deger = iyiProgramOlustur(s);
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
        value = 12;
        break;
      case "Sali":
        value = 26;
        break;
      case "Çarşamba":
        value = 16;
        break;
      case "Perşembe":
        value = 26;
        break;
      case "Cuma":
        value = 22;
        break;
      case "Cumartesi":
        value = 26;
        break;
      case "Pazar":
        value = 26;
        break;
    }
    return value;
  }

  int ortaProgramOlustur(String s) {
    int value = 0;
    if (s == "Pazartesi") value = 19;
    if (s == "Sali") value = 20;
    if (s == "Çarşamba") value = 26; //dinlenme
    if (s == "Perşembe") value = 21;
    if (s == "Cuma") value = 15;
    if (s == "Cumartesi") value = 26;
    if (s == "Pazar") value = 26;
    return value;
  }

  int iyiProgramOlustur(String s) {
    int value = 0;
    if (s == "Pazartesi") value = 13;
    if (s == "Sali") value = 17;
    if (s == "Çarşamba") value = 26; //dinlenme
    if (s == "Perşembe") value = 23;
    if (s == "Cuma") value = 24;
    if (s == "Cumartesi") value = 18;
    if (s == "Pazar") value = 26;
    return value;
  }

  int ustProgramOlustur(String s) {
    int value = 0;
    if (s == "Pazartesi") value = 21;
    if (s == "Sali") value = 14;
    if (s == "Çarşamba") value = 26;
    if (s == "Perşembe") value = 17;
    if (s == "Cuma") value = 18;
    if (s == "Cumartesi") value = 14;
    if (s == "Pazar") value = 26;
    return value;
  }

  Widget _dinamikElemanUret(BuildContext context, int index) {
    return topluListe(context, index);
  }

  List<Widget> sabitListeElemanlari() {
    double en = MediaQuery.of(context).size.width;
    double boy = MediaQuery.of(context).size.height;
    return [
      Container(
        margin: EdgeInsets.only(top: 15, bottom: 15, left: 5, right: 5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 20),
              child: Image.asset(
                "assets/images/levels/" + secilenHafta.haftalikResim,
                width: en / 4,
                height: boy / 9,
              ),
            ),
            Container(
              width: en / 1.6,
              height: boy / 10,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0, top: 2),
                    child: Text(
                      "Hatırlatma",
                      style: TextStyle(
                          color: Colors.blueGrey.shade700,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0, top: 0),
                    child: Text(
                      "Programınıza egzersizler bölümünden farklı yoga hareketleri ekleyebilirsiniz.",
                      style: TextStyle(
                          fontSize: en / 36, color: Colors.blueGrey.shade400),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ];
  }

  void aciklamaAlertDialog(BuildContext ctx, int index, id, double en) {
    int a = 20;
    if (secilenHafta.haftalikAciklama == "15") a = 15;
    if (secilenHafta.haftalikAciklama == "20") a = 20;
    if (secilenHafta.haftalikAciklama == "25") a = 25;
    if (secilenHafta.haftalikAciklama == "30") a = 30;

    // int counter = 20;
    Timer timer;
    showDialog(
        context: ctx,
        barrierDismissible: false,
        builder: (ctx) {
          return AlertDialog(
            title: Center(
              child: Text(
                id == 0
                    ? tumGunler[index].icerik
                    : tumEgzersizler[index].egzersizAdi,
                style: TextStyle(color: Colors.orange),
              ),
            ),
            backgroundColor: Colors.blueAccent.shade200,
            content: StatefulBuilder(
              builder: (ctx, StateSetter setState) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      a == -1 || a == int.parse(secilenHafta.haftalikAciklama)
                          ? RaisedButton(
                              child: Text(
                                "Süreyi Başlat!",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: en / 23,
                                    fontWeight: FontWeight.bold),
                              ),
                              elevation: 0,
                              color: Colors.orange,
                              onPressed: () {
                                setState(() {
                                  if (timer != null) {
                                    timer.cancel();
                                  }
                                  timer = Timer.periodic(Duration(seconds: 1),
                                      (timer) {
                                    setState(() {
                                      if (a > -1) {
                                        a--;
                                      } else {
                                        a = int.parse(
                                            secilenHafta.haftalikAciklama);
                                        tebrikAlertGoster(context, a);
                                        timer.cancel();
                                      }
                                    });
                                  });
                                });
                              })
                          : Container(
                              color: Colors.orange,
                              width: en / 1.45,
                              height: en / 9,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(a != -1 ? "Kalan Süre: " : "",
                                      style: TextStyle(
                                          color: Colors.blueGrey.shade900,
                                          fontWeight: FontWeight.bold,
                                          fontSize: en / 25)),
                                  Text(
                                    a == -1
                                        ? secilenHafta.haftalikAciklama
                                        : a.toString(),
                                    style: TextStyle(
                                        color: Colors.blueGrey.shade900,
                                        fontSize: en / 23),
                                  ),
                                ],
                              ),
                            ),
                      SizedBox(height: en / 11),
                      Text(
                        id == 0
                            ? tumGunler[index].hareketDetay
                            : tumEgzersizler[index].egzersizDetay,
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                );
              },
            ),
            actions: [
              RaisedButton(
                  color: Colors.white,
                  child: Text(
                    "Anladım",
                    style: TextStyle(color: Colors.blueGrey.shade900),
                  ),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    if (timer != null) {
                      timer.cancel();
                    }
                  }),
            ],
          );
        });
  }

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
                child: Column(
                  children: [
                    Text(
                      secilenHafta.haftalikAd + " Seviyeyi tamamladın.",
                      style:
                          TextStyle(color: Colors.green.shade100, fontSize: 14),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 23.0),
                      child: Image.asset(
                        gelenIndex == 3
                            ? "assets/images/general/trophy.png"
                            : "assets/images/general/check.png",
                        width: 50,
                        height: 50,
                      ),
                    )
                  ],
                ),
              ),
            ]),
            backgroundColor: Colors.blueGrey.shade900,
            content: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 10, left: 45),
                child: Row(
                  children: [
                    gelenIndex == 3
                        ? Text("Katılımın için teşekkürler! :)",
                            style: TextStyle(color: Colors.white, fontSize: 10))
                        : Text(
                            "Sıradaki Seviye: ",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                    Text(
                      gelenIndex == 3
                          ? ""
                          : ProgramSayfasi
                              .tumHaftalar[gelenIndex + 1].haftalikAd,
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
                  style: TextStyle(color: Colors.redAccent, fontSize: 12),
                ),
                onPressed: () => Navigator.of(ctx).pop(),
              ),
            ],
          );
        });
  }

  void alertEminMi(BuildContext ctx, int i, bool value) {
    showDialog(
        context: ctx,
        barrierDismissible: false,
        builder: (ctx) {
          return AlertDialog(
            title: Center(
              child: Text(
                "Emin misin?",
                style: TextStyle(color: Colors.yellow.shade800),
              ),
            ),
            backgroundColor: Colors.blueGrey.shade900,
            content: SingleChildScrollView(
                child: Text(
              "İlerleme durumun silinecek.",
              style: TextStyle(color: Colors.white),
            )),
            actions: [
              FlatButton(
                  child: Text(
                    "Eminim",
                    style: TextStyle(color: Colors.greenAccent, fontSize: 12),
                  ),
                  onPressed: () {
                    _programDurumSil(tumKaydedilenlerListesi[i].id, i);
                    secilenDurum = value;
                    Navigator.of(ctx).pop();
                  }),
              FlatButton(
                  child: Text(
                    "İptal",
                    style: TextStyle(color: Colors.redAccent, fontSize: 12),
                  ),
                  onPressed: () => Navigator.of(ctx).pop()),
            ],
          );
        });
  }

  void tebrikAlertGoster(BuildContext ctx, int count) {
    showDialog(
        context: ctx,
        barrierDismissible: false,
        builder: (ctx) {
          return AlertDialog(
            title: Column(children: [
              Text(
                "Tebrikler, Tamamladınız!",
                style: TextStyle(
                    color: Colors.green.shade400,
                    fontSize: MediaQuery.of(context).size.width / 22,
                    fontWeight: FontWeight.bold),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 23.0),
                  child: Image.asset(
                    "assets/images/general/energy.png",
                    width: MediaQuery.of(context).size.width / 4,
                    height: MediaQuery.of(context).size.height / 7,
                  ),
                ),
              ),
            ]),
            backgroundColor: Colors.blueGrey.shade900,
            content: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 10, left: 20),
                child: Center(
                  child: Text(
                    "Hareketiniz $count saniye sürdü.",
                    style: TextStyle(
                        color: Colors.green.shade100,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                ),
              ),
            ),
            actions: [
              FlatButton(
                child: Text(
                  "Kapat",
                  style: TextStyle(color: Colors.redAccent, fontSize: 12),
                ),
                onPressed: () => Navigator.of(ctx).pop(),
              ),
            ],
          );
        });
  }
}
