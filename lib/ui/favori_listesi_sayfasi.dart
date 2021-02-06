import 'package:cocuklar_icin_spor_app/models/favori_durum.dart';
import 'package:cocuklar_icin_spor_app/ui/egzersiz_detay.dart';
import 'package:cocuklar_icin_spor_app/utils/database_helper.dart';
import 'package:flutter/material.dart';

class FavoriSayfasi extends StatefulWidget {
  @override
  _FavoriSayfasiState createState() => _FavoriSayfasiState();
}

class _FavoriSayfasiState extends State<FavoriSayfasi> {
  DatabaseHelper _databaseHelper;
  List<FavoriDurum> tumKaydedilenlerListesi;
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    tumKaydedilenlerListesi = List<FavoriDurum>();
    _databaseHelper = DatabaseHelper();
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
    return FutureBuilder(
        future: _databaseHelper.favoriListesiniGetir(),
        builder: (context, AsyncSnapshot<List<FavoriDurum>> snapShot) {
          if (snapShot.connectionState == ConnectionState.done) {
            tumKaydedilenlerListesi = snapShot.data;
            return ListView.builder(
                itemCount: tumKaydedilenlerListesi.length,
                itemBuilder: (BuildContext context, int index) {
                  return cardGetir(context, index);
                });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget cardGetir(BuildContext context, int index) {
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
                tileColor: Colors.red[100 * ((index % 3) + 1)],
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 40,
                      height: MediaQuery.of(context).size.height / 18,
                      child: Center(child: Text((index + 1).toString())),
                      color: Colors.grey.withOpacity(0.3),
                    ),
                    Text(
                      tumKaydedilenlerListesi[index].hareketAd.toString(),
                      style: TextStyle(fontSize: 20),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 17,
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
