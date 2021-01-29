import 'package:cocuklar_icin_spor_app/models/egzersiz.dart';
import 'package:cocuklar_icin_spor_app/utils/strings.dart';
import 'package:flutter/material.dart';

class EgzersizSayfasi extends StatelessWidget {
  static List<Egzersiz> tumEgzersizler;

  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.of(context).size.height;
    final sizeWidth = MediaQuery.of(context).size.width;
    tumEgzersizler = verileriHazirla();
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
          crossAxisCount: 2, childAspectRatio: sizeHeight / (sizeWidth * 2.5)),
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
        // color: Colors.cyan.shade100,
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        boxShadow: [
          BoxShadow(
              color: Colors.cyan.shade200,
              offset: Offset(1.0, 1.0),
              blurRadius: 1.0),
        ],
        color: Colors.deepOrange[200 * (index % 3)],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, "/egzersizDetay/$index");
            print(Colors.deepOrange[200 * (index % 3)]);
          },
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  "assets/images/exercises/" + oAnEklenecek.egzersizResim,
                  width: 140,
                  height: 140,
                ),
                Text(
                  oAnEklenecek.egzersizAdi,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.blueGrey.shade900,
                      fontWeight: FontWeight.bold),
                ),
              ]),
        ),
      ),
    );
  }
}
