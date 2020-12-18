import 'package:cocuklar_icin_spor_app/main.dart';
import 'package:cocuklar_icin_spor_app/models/kisisel.dart';
import 'package:cocuklar_icin_spor_app/ui/bilgileri_guncelle.dart';
import 'package:cocuklar_icin_spor_app/utils/database_helper.dart';
import 'package:flutter/material.dart';

class AnaSayfa extends StatefulWidget {
  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  DatabaseHelper _databaseHelper;
  List<Kisisel> tumKisiselVerilerListesi;

  @override
  void initState() {
    super.initState();
    tumKisiselVerilerListesi = List<Kisisel>();
    _databaseHelper = DatabaseHelper();
    _databaseHelper.tumKayitlar().then((tumKayitlariTutanMapList) {
      for (Map okunanKayitListesi in tumKayitlariTutanMapList) {
        tumKisiselVerilerListesi
            .add(Kisisel.dbdenOkudugunDegeriObjeyeDonustur(okunanKayitListesi));
      }
      setState(() {});
    }).catchError((hata) => print("Init state hata fonk: " + hata));
  }

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
            itemExtent: MediaQuery.of(context).size.height + 100),
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
          Text("Ana Sayfa",
              style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 35,
                  fontWeight: FontWeight.w500)),
          Divider(
            color: Colors.black87,
          ),
          Card(
            shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.deepOrange, width: 2),
                borderRadius: BorderRadius.circular(6)),
            margin: EdgeInsets.fromLTRB(8, 10, 8, 0),
            elevation: 20,
            color: Colors.blueGrey.shade700,
            child: ListTile(
              title: Text(
                "Kişisel Bilgiler",
                style: TextStyle(
                    color: Colors.deepOrange,
                    fontSize: 30,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              subtitle: Column(
                children: [
                  Text(
                    tumKisiselVerilerListesi.length == 0
                        ? " "
                        : tumKisiselVerilerListesi[0].adSoyad, //hata var
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Text("Bilgilerini güncellemek için tıkla.",
                      style:
                          TextStyle(color: Colors.grey.shade400, fontSize: 15)),
                ],
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BilgileriGuncelle()));
              },
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 45)),
          Text("Sizin İçin Öneriler",
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 25,
                  fontWeight: FontWeight.w500)),
          Divider(
            color: Colors.black,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.all(Radius.circular(2)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade700,
                  offset: Offset(0.2, 0.2), //(x,y)
                  blurRadius: 6.0,
                ),
              ],
            ),
            margin: EdgeInsets.fromLTRB(10, 25, 10, 0),
            child: ListTile(
              leading: Image.asset("assets/images/su.png"),
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
                    style: TextStyle(color: Colors.grey.shade400, fontSize: 10),
                  )
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.all(Radius.circular(2)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade700,
                  offset: Offset(0.2, 0.2), //(x,y)
                  blurRadius: 6.0,
                ),
              ],
            ),
            margin: EdgeInsets.fromLTRB(10, 25, 10, 0),
            child: ListTile(
              leading: Image.asset("assets/images/beslenme.png"),
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
                    style: TextStyle(color: Colors.grey.shade400, fontSize: 10),
                  )
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.all(Radius.circular(2)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade700,
                  offset: Offset(0.2, 0.2), //(x,y)
                  blurRadius: 6.0,
                ),
              ],
            ),
            margin: EdgeInsets.fromLTRB(10, 25, 10, 0),
            child: ListTile(
              leading: Image.asset("assets/images/sleep.png"),
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
                    style: TextStyle(color: Colors.grey.shade400, fontSize: 10),
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BilgileriGuncelle()));
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.all(Radius.circular(2)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade700,
                    offset: Offset(0.2, 0.2), //(x,y)
                    blurRadius: 6.0,
                  ),
                ],
              ),
              margin: EdgeInsets.fromLTRB(10, 25, 10, 0),
              child: ListTile(
                leading: Image.asset("assets/images/sleep.png"),
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
                      style:
                          TextStyle(color: Colors.grey.shade400, fontSize: 10),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    ];
  }
}
