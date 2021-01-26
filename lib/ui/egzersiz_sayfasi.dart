import 'package:cocuklar_icin_spor_app/models/egzersiz.dart';
import 'package:cocuklar_icin_spor_app/utils/strings.dart';
import 'package:flutter/material.dart';

class EgzersizSayfasi extends StatelessWidget {
  static List<Egzersiz> tumEgzersizler;

  @override
  Widget build(BuildContext context) {
    tumEgzersizler = verileriHazirla();
    return Scaffold(
      body: listeyiHazirla(),
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

  Widget listeyiHazirla() {
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        return tekSatirCard(context, index);
      },
      itemCount: tumEgzersizler.length,
    );
  }

  Widget tekSatirCard(BuildContext context, int index) {
    Egzersiz oAnEklenecek = tumEgzersizler[index]; //object

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          // color: Colors.cyan.shade100,
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          boxShadow: [
            BoxShadow(
                color: Colors.cyan.shade100,
                offset: Offset(1.0, 1.0),
                blurRadius: 1.0),
          ],
          color: Colors.deepOrange[200 * (index % 3)],
          image: DecorationImage(
              image: AssetImage(
                "assets/images/exercises/" + oAnEklenecek.egzersizResim,
              ),
              fit: BoxFit.cover,
              alignment: Alignment.topRight),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, "/egzersizDetay/$index");
            },
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Opacity(
                opacity: 0.4,
                child: Container(
                  color: Colors.white,
                  child: Text(
                    oAnEklenecek.egzersizAdi,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.blueGrey.shade900,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
