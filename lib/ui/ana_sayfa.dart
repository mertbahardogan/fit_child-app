import 'package:cocuklar_icin_spor_app/models/kisisel.dart';
import 'package:cocuklar_icin_spor_app/ui/bilgileri_guncelle.dart';
import 'package:cocuklar_icin_spor_app/ui/tekrar_kaydedici_liste.dart';
import 'package:cocuklar_icin_spor_app/ui/vucut_kitle_sayfasi.dart';
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
    // _databaseHelper.tumKayitlar().then((tumKayitlariTutanMapList) {
    //   for (Map okunanKayitListesi in tumKayitlariTutanMapList) {
    //     tumKisiselVerilerListesi
    //         .add(Kisisel.dbdenOkudugunDegeriObjeyeDonustur(okunanKayitListesi));
    //   }
    //   setState(() {});
    // }).catchError((hata) => print("Init state hata fonk: " + hata));

    //Bu doldurma olayını artık hep methoddan çağırmayı her sayfada deneyelim!!!!
  }

  @override
  Widget build(BuildContext context) {
    var ekranHeight = MediaQuery.of(context).size.height;

    return CustomScrollView(
      scrollDirection: Axis.vertical,
      slivers: [
        SliverAppBar(
          title: Text(
            "Fit Child",
            style: TextStyle(
                fontSize: 30, color: Colors.black,fontFamily: "Sansita",fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.grey.shade200,
          pinned: true,
          primary: true,
          expandedHeight: 55,
          elevation: 4,
        ),
        SliverFixedExtentList(
          delegate: SliverChildListDelegate(sabitCardElemanlari()),
          itemExtent: ekranHeight + 300,
        ),
      ],
    );
  }

  List<Widget> sabitCardElemanlari() {
    return [
      Column(
        children: [
          Padding(padding: EdgeInsets.only(top: 10)),
          // Image.asset(
          //   "assets/images/fitness.png",
          //   width: 70,
          //   height: 70,
          // ),
          // Text("Ana Sayfa",
          //     style: TextStyle(
          //         color: Colors.grey.shade800,
          //         fontSize: 35,
          //         fontWeight: FontWeight.w500)),
          // Divider(
          //   color: Colors.black87,
          //   indent: 15,
          //   endIndent: 15,
          // ),
          Card(
            shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.red, width: 0),
                borderRadius: BorderRadius.circular(6)),
            margin: EdgeInsets.fromLTRB(8, 10, 8, 0),
            elevation: 20,
            color: Colors.grey.shade700,
            child: ListTile(
              title: Text(
                "Kişisel Bilgiler",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              subtitle: Column(
                children: [
                  FutureBuilder(
                      //Yaş ve diğer bilgiler eklenebilir.
                      future: _databaseHelper.kisiselListesiniGetir(),
                      builder:
                          (context, AsyncSnapshot<List<Kisisel>> snapShot) {
                        if (snapShot.connectionState == ConnectionState.done) {
                          tumKisiselVerilerListesi = snapShot.data;
                          return Text(
                            tumKisiselVerilerListesi[0].adSoyad,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          );
                        } else {
                          return Text("Yükleniyor...");
                        }
                      }),
                  Text("Bilgilerini güncellemek için tıkla.",
                      style:
                          TextStyle(color: Colors.grey.shade400, fontSize: 15)),
                ],
              ),
              onTap: () {
                Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BilgileriGuncelle()))
                    .then((value) {
                  setState(() {});
                });
              },
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HareketKaydediciSayfasi()));
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.green.shade200,
                borderRadius: BorderRadius.all(Radius.circular(2)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade700,
                    offset: Offset(0.2, 0.2),
                    blurRadius: 6.0,
                  ),
                ],
              ),
              margin: EdgeInsets.fromLTRB(10, 25, 10, 0),
              child: Column(children: [
                Image.asset(
                  "assets/images/liste.png",
                  width: 60,
                  height: 60,
                ),
                Text(
                  "Anteman Programı",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Tekrar Sayılarınızı Kaydedin",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Listeye gitmek için tıklayınız.",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ]),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => VucutKitleSayfasi()));
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.brown.shade200,
                borderRadius: BorderRadius.all(Radius.circular(2)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade700,
                    offset: Offset(0.2, 0.2),
                    blurRadius: 6.0,
                  ),
                ],
              ),
              margin: EdgeInsets.fromLTRB(10, 25, 10, 0),
              child: Column(children: [
                Image.asset(
                  "assets/images/yag.png",
                  width: 60,
                  height: 60,
                ),
                Text(
                  "Vücut Kitle Endeksi",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Oranınızı Öğrenin",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Hesaplayıcıya gitmek için tıklayınız.",
                  style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 13,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ]),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 45)),
          Text("Sizin İçin Öneriler",
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 25,
                  fontWeight: FontWeight.w500)),
          Divider(
            color: Colors.black87,
            indent: 100,
            endIndent: 100,
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
        ],
      ),
    ];
  }
}

