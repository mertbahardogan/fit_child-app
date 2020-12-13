import 'package:cocuklar_icin_spor_app/models/haftalik.dart';
import 'package:cocuklar_icin_spor_app/utils/program.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ProgramSayfasi extends StatefulWidget {
  @override
  _ProgramSayfasiState createState() => _ProgramSayfasiState();
}

class _ProgramSayfasiState extends State<ProgramSayfasi> {
  static List<Haftalik> tumHaftalar;
  @override
  Widget build(BuildContext context) {
    tumHaftalar = verileriHazirla();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Spor Programınız",
          style: TextStyle(color: Colors.white),
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
        height: MediaQuery.of(context).size.height / 4,
        // color: Colors.blueGrey.shade300,
        decoration: BoxDecoration(
            color: Colors.blueGrey.shade300,
            border: Border.all(
              color: Colors.deepOrange.shade400,
              width: 3,
            ),
            borderRadius: BorderRadius.all(Radius.circular(14))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              "assets/images/" + oAnEklenecek.haftalikResim,
              width: 100,
              height: 100,
              alignment: Alignment.topCenter,
            ),
            Text(
              oAnEklenecek.haftalikAd + " Seviye",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w500),
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
