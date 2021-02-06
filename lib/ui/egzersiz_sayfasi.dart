import 'package:cocuklar_icin_spor_app/methods/egzersiz_verileri_hazirla.dart';
import 'package:cocuklar_icin_spor_app/models/egzersiz.dart';
import 'package:flutter/material.dart';

class EgzersizSayfasi extends StatelessWidget {
  static List<Egzersiz> tumEgzersizler;

  @override
  Widget build(BuildContext context) {
    final boy = MediaQuery.of(context).size.height;
    final en = MediaQuery.of(context).size.width;
    tumEgzersizler = egzersizVerileriHazirla();
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

  // Widget listeyiHazirla() {
  //   return ListView.builder(
  //     itemBuilder: (BuildContext context, int index) {
  //       return tekSatirCard(context, index);
  //     },
  //     itemCount: tumEgzersizler.length,
  //   );
  // }

  Widget listeyiHazirla(en, boy) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: boy / 800),
      itemBuilder: (BuildContext context, int index) {
        return tekSatirCard(context, index, en, boy);
      },
      itemCount: tumEgzersizler.length,
    );
  }

  Widget tekSatirCard(BuildContext context, int index, double en, boy) {
    Egzersiz oAnEklenecek = tumEgzersizler[index]; //object

    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        color: Colors.red[100 * ((index % 4) + 2)],
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
                  width: en/3,
                  height: boy/6.2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      oAnEklenecek.egzersizAdi,
                      style: TextStyle(
                          fontSize: en/24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Padding(
                          padding: EdgeInsets.all(4),
                          child: Text(
                            tumEgzersizler[index].egzersizSeviye,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: en/35,
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
