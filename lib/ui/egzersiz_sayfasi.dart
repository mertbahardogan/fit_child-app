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
        title: Text("Tüm Hareketler"),
        centerTitle: true,
      ),
    );
  }

  List<Egzersiz> verileriHazirla() {
    List<Egzersiz> egzersizler = [];

    for (int i = 0; i < 8; i++) {
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

  Widget listeyiHazirla() {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return tekSatirCard(context, index);
      },
      itemCount: tumEgzersizler.length,
    );
  }

  Widget tekSatirCard(BuildContext context, int index) {
    Egzersiz oAnEklenecek = tumEgzersizler[index];
    return Card(
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white, width: 3),
          borderRadius: BorderRadius.circular(6)),
      elevation: 10,
      color: Colors.grey[100],
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ListTile(
          onTap: () {
            Navigator.pushNamed(context, "/egzersizDetay/$index");
          },
          leading: Image.asset(
            "assets/images/" + oAnEklenecek.egzersizResim,
            width: 90,
            height: 90,
          ),
          title: Text(
            oAnEklenecek.egzersizAdi,
            style: TextStyle(fontSize: 22, color: Colors.black,fontWeight: FontWeight.w500),
          ),
          subtitle: Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text(
              "Detaylar için tıklayın.",
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.black38,
                  ),
            ),
          ),
          trailing: Icon(Icons.arrow_forward_ios, color: Colors.red),
        ),
      ),
    );
  }
}
