import 'package:cocuklar_icin_spor_app/models/egzersiz.dart';
import 'package:cocuklar_icin_spor_app/models/favori_durum.dart';
import 'package:cocuklar_icin_spor_app/utils/database_helper.dart';
import 'package:cocuklar_icin_spor_app/utils/strings.dart';
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
    tumEgzersizler = verileriHazirla();
    // secilenEgzersiz = EgzersizSayfasi.tumEgzersizler[widget.gelenIndex];
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

  @override
  Widget build(BuildContext context) {
    //
    // tumEgzersizler = verileriHazirla();

    return Scaffold(
      key: _scaffoldKey,
      primary: true,
      body: CustomScrollView(slivers: [
        SliverAppBar(
          primary: true,
          pinned: true,
          title: Text(secilenEgzersiz.egzersizAdi),
          centerTitle: true,
          backgroundColor: Colors.deepOrange[200 * (widget.gelenIndex % 3)],
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
              cacheHeight: 130,
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

  //
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

  //
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

  //Bir methoddan hazır çekmeyi deneyelim ve işe yarayacak mı?
  List<Egzersiz> verileriHazirla() {
    List<Egzersiz> egzersizler = [];

    for (int i = 0; i < 9; i++) {
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
}
