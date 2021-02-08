// import 'dart:convert';

import 'dart:async';

import 'package:cocuklar_icin_spor_app/methods/egzersiz_verileri_hazirla.dart';
import 'package:cocuklar_icin_spor_app/models/egzersiz.dart';
import 'package:cocuklar_icin_spor_app/models/favori_durum.dart';
import 'package:cocuklar_icin_spor_app/utils/database_helper.dart';
import 'package:flutter/material.dart';

class EgzersizDetay extends StatefulWidget {
  int gelenIndex;
  EgzersizDetay(this.gelenIndex);
  @override
  _EgzersizDetayState createState() => _EgzersizDetayState();
}

class _EgzersizDetayState extends State<EgzersizDetay> {
  Egzersiz secilenEgzersiz;

  IconData iconMod = Icons.favorite_border;

  //
  static List<Egzersiz> tumEgzersizler;

  var _scaffoldKey = GlobalKey<ScaffoldState>();
  bool secilenDurum = false;
  DatabaseHelper _databaseHelper;
  List<FavoriDurum> tumKaydedilenlerListesi;
  @override
  void initState() {
    tumEgzersizler = egzersizVerileriHazirla();
    secilenEgzersiz = tumEgzersizler[widget.gelenIndex];
    super.initState();

    tumKaydedilenlerListesi = List<FavoriDurum>();
    _databaseHelper = DatabaseHelper();
    _databaseHelper.tumFavoriDurumlar().then((value) {
      for (Map okunanListe in value) {
        tumKaydedilenlerListesi
            .add(FavoriDurum.dbdenObjeyeDonustur(okunanListe));
      }
      for (int i = 0; i < tumKaydedilenlerListesi.length; i++) {
        if (tumKaydedilenlerListesi[i].hareketID ==
            widget.gelenIndex.toString()) {
          secilenDurum = true;
          break;
        }
      }
      debugPrint(secilenDurum.toString());
      setState(() {});
    }).catchError((hata) => print("İnit state hata alındı: " + hata));
  }

  int _counter = 20;
  Timer _timer;

  void _sureBaslat() {
    _counter = 20;
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > -1) {
          _counter--;
        } else {
          _counter = 20;
          tebrikAlertGoster(context, _counter);
          _timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double en = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      primary: true,
      body: CustomScrollView(slivers: [
        SliverAppBar(
          primary: true,
          pinned: true,
          title: Text(secilenEgzersiz.egzersizAdi),
          centerTitle: true,
          backgroundColor: Colors.blue[100 * ((widget.gelenIndex % 4) + 1)],
          expandedHeight: 200,
          actions: [
            IconButton(
              icon: Icon(
                secilenDurum == true
                    ? Icons.favorite
                    : Icons.favorite_border_outlined,
                size: 26,
              ),
              onPressed: () {
                setState(() {
                  if (tumKaydedilenlerListesi.length == 0 ||
                      secilenDurum == false) {
                    _favoriEkle(FavoriDurum(
                        secilenDurum.toString(),
                        widget.gelenIndex.toString(),
                        secilenEgzersiz.egzersizAdi));
                    secilenDurum = true;
                  }

                  for (int i = 0; i < tumKaydedilenlerListesi.length; i++) {
                    if (tumKaydedilenlerListesi[i].hareketID ==
                        widget.gelenIndex.toString()) {
                      _favoriSil(tumKaydedilenlerListesi[i].id, i);
                      secilenDurum = false;
                      break;
                    }
                  }
                });
              },
            )
          ],
          flexibleSpace: FlexibleSpaceBar(
            background: Image.asset(
              "assets/images/exercises/" + secilenEgzersiz.egzersizResim,
              fit: BoxFit.scaleDown,
              cacheHeight: (en / 1.5).round(),
              alignment: Alignment.bottomCenter,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(6)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _counter == -1 || _counter == 20
                          ? RaisedButton(
                              child: Text(
                                "Süreyi Başlat!",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: en / 21,
                                    fontWeight: FontWeight.bold),
                              ),
                              elevation: 0,
                              color: Colors.deepOrange.shade800,
                              onPressed: () {
                                _sureBaslat();
                              })
                          : Container(
                              color: Colors.deepOrange.shade300,
                              width: en / 2,
                              height: en / 7,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(_counter != -1 ? "Kalan Süre: " : "",
                                      style: TextStyle(
                                          color: Colors.blueGrey.shade900,
                                          fontWeight: FontWeight.bold,
                                          fontSize: en / 25)),
                                  Text(
                                      _counter == -1
                                          ? "20"
                                          : _counter.toString(),
                                      style: TextStyle(
                                          color: Colors.blueGrey.shade900,
                                          fontSize: en / 23)),
                                ],
                              ),
                            ),
                    ],
                  ),
                  SizedBox(
                    height: en / 20,
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Icon(
                          Icons.fitness_center,
                          size: 27,
                          color: Colors.deepOrange.shade800,
                        ),
                      ),
                      Text(
                        secilenEgzersiz.egzersizBolge +
                            "  bölgelerini çalıştırır.",
                        style: TextStyle(fontSize: 18),
                      ),
                      Divider(
                        height: 20,
                        thickness: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Icon(
                          Icons.repeat,
                          size: 27,
                          color: Colors.deepOrange.shade800,
                        ),
                      ),
                      Text(secilenEgzersiz.egzersizOneri,
                          style: TextStyle(fontSize: 18)),
                      Divider(
                        height: 20,
                        thickness: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          "Nasıl Yapabilirim?",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Colors.deepOrange.shade800,
                          ),
                        ),
                      ),
                      Text(
                        secilenEgzersiz.egzersizDetay,
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 18),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }

  void _favoriEkle(FavoriDurum favoriDurum) async {
    var eklenenID = await _databaseHelper.favoriEkle(favoriDurum);
    favoriDurum.id = eklenenID;
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: Colors.green.shade600,
      content: Text("${secilenEgzersiz.egzersizAdi} favori listesine eklendi."),
      duration: Duration(seconds: 2),
    ));
    setState(() {
      tumKaydedilenlerListesi.insert(0, favoriDurum);
    });
  }

  void _favoriSil(int forDBtoDeleteID, int forListtoDeleteIndex) async {
    var sonuc = await _databaseHelper.favoriSil(forDBtoDeleteID);
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: Colors.red.shade800,
      content:
          Text("${secilenEgzersiz.egzersizAdi} favori listesinden silindi."),
      duration: Duration(seconds: 2),
    ));
    if (sonuc == 1) {
      setState(() {
        tumKaydedilenlerListesi.removeAt(forListtoDeleteIndex);
      });
    }
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
