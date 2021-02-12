import 'package:cocuklar_icin_spor_app/models/haftalik.dart';
import 'package:cocuklar_icin_spor_app/utils/program.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ProgramSayfasi extends StatelessWidget {
  static List<Haftalik> tumHaftalar;
  @override
  Widget build(BuildContext context) {
    double en = MediaQuery.of(context).size.width;
    double boy = MediaQuery.of(context).size.width;
    tumHaftalar = verileriHazirla();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Haftalık Spor Programı",
          style: TextStyle(
              color: Colors.blueGrey.shade900, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: listeHazirla(en, boy),
    );
  }

  List<Haftalik> verileriHazirla() {
    List<Haftalik> haftalar = [];

    for (int i = 0; i < 4; i++) {
      String resim = Program.PROGRAM_DOSYA[i] + ".png";

      Haftalik eklenecekAdim = Haftalik(
        Program.PROGRAM_AD[i],
        Program.PROGRAM_DOSYA[i],
        Program.PROGRAM_ACIKLAMA[i],
        resim,
      );
      haftalar.add(eklenecekAdim);
    }
    return haftalar;
  }

  Widget listeHazirla(en, boy) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return tekSatirContainer(context, index, en, boy);
      },
      itemCount: tumHaftalar.length,
    );
  }

  Widget tekSatirContainer(BuildContext context, int index, double en, boy) {
    Haftalik oAnEklenecek = tumHaftalar[index];

    return GestureDetector(
      child: Container(
        margin: EdgeInsets.all(10),
        alignment: Alignment.center,
        width: en,
        height: boy / 2.9,
        decoration: BoxDecoration(
            color: Colors.blueGrey.shade200,
            borderRadius: BorderRadius.all(
              Radius.circular(14),
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.blueGrey.shade900,
                  blurRadius: 1,
                  offset: Offset(0, 5))
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              "assets/images/levels/" + oAnEklenecek.haftalikResim,
              width: en / 3,
              height: boy / 3.1,
              alignment: Alignment.topCenter,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  oAnEklenecek.haftalikAd + " Seviye",
                  style: TextStyle(
                      color: Colors.blueGrey.shade900,
                      fontSize: en / 16,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: en / 20,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 6, left: 6),
                      child: Icon(
                        Icons.info,
                        size: en / 25,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                        "Egzersizler " +
                            oAnEklenecek.haftalikAciklama +
                            " saniye 3-4 set yapılabilir.",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: en / 40,
                            fontWeight: FontWeight.w400)),
                  ],
                )
              ],
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, "/programDetay/$index");
      },
    );
  }
}
