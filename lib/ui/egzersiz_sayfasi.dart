import 'package:cocuklar_icin_spor_app/methods/egzersiz_verileri_hazirla.dart';
import 'package:cocuklar_icin_spor_app/models/egzersiz.dart';
import 'package:flutter/material.dart';

class EgzersizSayfasi extends StatelessWidget {
  static List<Egzersiz> tumEgzersizler;

  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.of(context).size.height;
    final sizeWidth = MediaQuery.of(context).size.width;
    tumEgzersizler = egzersizVerileriHazirla();
    return Scaffold(
      body: listeyiHazirla(sizeHeight, sizeWidth),
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

  Widget listeyiHazirla(sizeHeight, sizeWidth) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: sizeHeight / (sizeWidth * 2.2)),
      itemBuilder: (BuildContext context, int index) {
        return tekSatirCard(context, index);
      },
      itemCount: tumEgzersizler.length,
    );
  }

  Widget tekSatirCard(BuildContext context, int index) {
    Egzersiz oAnEklenecek = tumEgzersizler[index]; //object

    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        // boxShadow: [
        //   BoxShadow(
        //       color: Colors.cyan.shade200,
        //       offset: Offset(1.0, 1.0),
        //       blurRadius: 1.0),
        // ],
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
                  width: 140,
                  height: 140,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      oAnEklenecek.egzersizAdi,
                      style: TextStyle(
                          fontSize: 16,
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
                                fontSize: 13,
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
