import 'package:cocuklar_icin_spor_app/models/haftalik.dart';
import 'package:cocuklar_icin_spor_app/utils/program.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ProgramSayfasi extends StatelessWidget {
  static List<Haftalik> tumHaftalar;
  @override
  Widget build(BuildContext context) {
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
      body: listeHazirla(),
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

  Widget listeHazirla() {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return tekSatirContainer(context, index);
      },
      itemCount: tumHaftalar.length,
    );
  }

  Widget tekSatirContainer(BuildContext context, int index) {
    Haftalik oAnEklenecek = tumHaftalar[index];

    return GestureDetector(
      child: Container(
        margin: EdgeInsets.all(10),
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width / 4,
        height: MediaQuery.of(context).size.height / 5.5,
        decoration: BoxDecoration(
            color: renkUret(index),
            borderRadius: BorderRadius.all(
              Radius.circular(14),
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12, blurRadius: 10, offset: Offset(0, 10))
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              "assets/images/levels/" + oAnEklenecek.haftalikResim,
              width: 150,
              height: 150,
              alignment: Alignment.topCenter,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  oAnEklenecek.haftalikAd + " Seviye",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.w500),
                ),
                Row(
                  children: [
                    Text(
                      " Hafta " + (index + 1).toString(),
                      style: TextStyle(
                          color: Colors.deepOrange.shade600,
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.check,
                      color: Colors.grey,
                      size: 17,
                    ),
                    Text(" " + oAnEklenecek.haftalikAciklama,
                        style: TextStyle(
                            color: Colors.blueGrey.shade800, fontSize: 11))
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

  Color renkUret(int index) {
    if (index == 0) return Colors.blueGrey.shade600;
    if (index == 1) return Colors.blueGrey.shade400;
    if (index == 2) return Colors.blueGrey.shade200;
    if (index == 3)
      return Colors.blueGrey.shade100;
    else
      return Colors.blueGrey;
  }
}
