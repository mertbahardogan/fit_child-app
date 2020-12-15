import 'package:cocuklar_icin_spor_app/main.dart';
import 'package:cocuklar_icin_spor_app/ui/giris_sayfasi.dart';
import 'package:flutter/material.dart';

class AnaSayfa extends StatefulWidget {
  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      scrollDirection: Axis.vertical,
      slivers: [
        SliverAppBar(
          title: Text(
            "Çocuklar için Spor App",
            style: TextStyle(
                fontSize: 23, color: Colors.white, fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
          backgroundColor: Colors.grey,
          pinned: true,
          primary: true,
          expandedHeight: 65,
        ),
        SliverFixedExtentList(
            delegate: SliverChildListDelegate(sabitCardElemanlari()),
            itemExtent: MediaQuery.of(context).size.height),
        // SliverGridDelegateWithFixedCrossAxisCount(),
      ],
    );
  }

  List<Widget> sabitCardElemanlari() {
    return [
      Column(
        children: [
          Padding(padding: EdgeInsets.only(top: 10)),
          Image.asset(
            "assets/images/fitness.png",
            width: 70,
            height: 70,
          ),
          Text("Hoşgeldin " + adSoyad,
              style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 35,
                  fontWeight: FontWeight.w500)),
          Divider(),
          Card(
            shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.white38, width: 2),
                borderRadius: BorderRadius.circular(6)),
            margin: EdgeInsets.fromLTRB(8, 10, 8, 0),
            elevation: 20,
            color: Colors.blueGrey.shade700,
            child: ListTile(
              title: Text(
                "Bilgilerim",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              subtitle: Column(
                children: [
                  Text(
                    "En sevdiğim spor: " + favSpor,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Text(
                    "Yaşım: " + yas.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Text("Bilgilerini güncellemek için tıkla.",
                      style:
                          TextStyle(color: Colors.grey.shade400, fontSize: 15)),
                ],
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GirisSayfasi()));
              },
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 45)),
          Text("Sizin İçin Öneriler",
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 25,
                  fontWeight: FontWeight.w500)),
          Divider(),
          Card(
            margin: EdgeInsets.fromLTRB(10, 25, 10, 0),
            elevation: 10,
            color: Colors.blueGrey.shade300,
            child: ListTile(
              leading: Icon(
                Icons.water_damage_outlined,
                color: Colors.grey.shade700,
                size: 36,
              ),
              title: Text(
                "Su Tüketimi",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              subtitle: Column(
                children: [
                  Text(
                    "Her gün yeteri kadar su içmelisin.",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Text(
                    "Düzenli olarak her 25 kg için 1 L su içmeniz önerilir.",
                    style: TextStyle(color: Colors.grey.shade700, fontSize: 10),
                  )
                ],
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.fromLTRB(10, 25, 10, 0),
            elevation: 10,
            color: Colors.blueGrey.shade200,
            child: ListTile(
              leading: Icon(
                Icons.food_bank_outlined,
                color: Colors.grey.shade700,
                size: 36,
              ),
              title: Text(
                "Beslenme",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              subtitle: Column(
                children: [
                  Text(
                    "Sebze ve meyve tüketimi vücut gelişimi açısından çok önemlidir.",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Divider(color: Colors.white),
                  Text(
                    "Dengeli ve sağlıklı beslenmeye özen gösterirseniz yaptığınız spordan daha çok verim alabilirsiniz.",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Text(
                    "Sporun büyük bir kısmı beslenmeden oluşur.",
                    style: TextStyle(color: Colors.grey.shade700, fontSize: 10),
                  )
                ],
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.fromLTRB(10, 25, 10, 0),
            elevation: 10,
            color: Colors.blueGrey.shade100,
            child: ListTile(
              leading: Icon(
                Icons.single_bed_outlined,
                color: Colors.grey.shade700,
                size: 36,
              ),
              title: Text(
                "Uyku Düzeni",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              subtitle: Column(
                children: [
                  Text(
                    "Her gün yeteri kadar uyumalısın.",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Text(
                    "Yaptığımız sporun verimli olması için 8 saat uyumalıyız.",
                    style: TextStyle(color: Colors.grey.shade700, fontSize: 10),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ];
  }
}
