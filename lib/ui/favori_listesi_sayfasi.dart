import 'package:cocuklar_icin_spor_app/models/favori_durum.dart';
import 'package:cocuklar_icin_spor_app/ui/egzersiz_detay.dart';
import 'package:cocuklar_icin_spor_app/utils/database_helper.dart';
import 'package:flutter/material.dart';

class FavoriSayfasi extends StatefulWidget {
  @override
  _FavoriSayfasiState createState() => _FavoriSayfasiState();
}

class _FavoriSayfasiState extends State<FavoriSayfasi> {
  //
  DatabaseHelper _databaseHelper;
  List<FavoriDurum> tumKaydedilenlerListesi;
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    tumKaydedilenlerListesi = List<FavoriDurum>();
    _databaseHelper = DatabaseHelper();
    _databaseHelper.tumFavoriDurumlar().then((value) {
      for (Map okunanListe in value) {
        tumKaydedilenlerListesi
            .add(FavoriDurum.dbdenObjeyeDonustur(okunanListe));
      }
      setState(() {});
    }).catchError((hata) => print("init state hata alındı: " + hata));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text("Favori Hareketler"),
        centerTitle: true,
      ),
      body: listeHazirla(),
    );
  }

  Widget listeHazirla() {
    return ListView.builder(
        itemCount: tumKaydedilenlerListesi.length,
        itemBuilder: (BuildContext context, int index) {
          return cardGetir(context, index);
        });
  }

  Widget cardGetir(BuildContext context, int index) {
    return Container(
      child: Column(
        children: [
          Card(
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    tumKaydedilenlerListesi[index].hareketAd.toString(),
                    style: TextStyle(fontSize: 20),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    color: Colors.redAccent,
                    onPressed: () {
                      _favoriSil(tumKaydedilenlerListesi[index].id, index);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _favoriSil(int forDBtoDeleteID, int forListtoDeleteIndex) async {
    var sonuc = await _databaseHelper.favoriSil(forDBtoDeleteID);
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: Colors.red.shade800,
      content: Text("Favori listesinden silme işlemi başarılı."),
      duration: Duration(seconds: 2),
    ));
    if (sonuc == 1) {
      setState(() {
        tumKaydedilenlerListesi.removeAt(forListtoDeleteIndex);
      });
    }
  }
}
