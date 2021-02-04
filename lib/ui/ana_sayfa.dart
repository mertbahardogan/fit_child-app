import 'package:cocuklar_icin_spor_app/methods/oneri_verileri_hazirla.dart';
import 'package:cocuklar_icin_spor_app/models/kisisel.dart';
import 'package:cocuklar_icin_spor_app/models/oneri.dart';
import 'package:cocuklar_icin_spor_app/ui/bilgileri_guncelle.dart';
import 'package:cocuklar_icin_spor_app/ui/favori_listesi_sayfasi.dart';
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

  //
  static List<Oneri> tumOneriler;

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

    tumOneriler = oneriVerileriHazirla();

    return CustomScrollView(
      scrollDirection: Axis.vertical,
      slivers: [
        SliverAppBar(
          title: Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                  child: Text(
                    "Fit Child",
                    style: TextStyle(
                        fontSize: 33,
                        color: Colors.blueGrey.shade900,
                        fontFamily: "Indie",
                        fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                    icon: Icon(
                      Icons.account_circle_rounded,
                      color: Colors.blueGrey.shade700,
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BilgileriGuncelle()))
                          .then((value) {
                        setState(() {});
                      });
                    }),
              ],
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          pinned: true,
          primary: true,
          expandedHeight: 70,
          elevation: 4,
        ),
        SliverFixedExtentList(
          delegate: SliverChildListDelegate(girisElemanlari()),
          itemExtent: ekranHeight / 2.5,
        ),
        SliverFixedExtentList(
            delegate: SliverChildListDelegate(yanaKayanList()),
            itemExtent: ekranHeight / 7),
        SliverFixedExtentList(
            delegate: SliverChildListDelegate(hareketBmiElemanlari()),
            itemExtent: ekranHeight / 4)
      ],
    );
  }

  //Giriş Kısmı ve Favori Card
  List<Widget> girisElemanlari() {
    return [
      Column(
        children: [
          Padding(padding: EdgeInsets.only(top: 20)),

          //İsim Container
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Merhaba,",
                      style: TextStyle(
                          color: Colors.blueGrey.shade900,
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                    ),
                    FutureBuilder(
                        future: _databaseHelper.kisiselListesiniGetir(),
                        builder:
                            (context, AsyncSnapshot<List<Kisisel>> snapShot) {
                          if (snapShot.connectionState ==
                              ConnectionState.done) {
                            tumKisiselVerilerListesi = snapShot.data;
                            return Text(
                              tumKisiselVerilerListesi[0].adSoyad,
                              style: TextStyle(
                                  color: Colors.deepOrange.shade900,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        }),
                  ],
                ),
                Image.asset(
                  "assets/images/fitness.png",
                  width: MediaQuery.of(context).size.width / 4,
                  height: MediaQuery.of(context).size.height / 7,
                ),
              ],
            ),
          ),

          //Favori Listesi Container
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FavoriSayfasi()));
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              margin: EdgeInsets.fromLTRB(10, 25, 10, 0),
              child: ListTile(
                leading: Image.asset("assets/images/general/favorite.png"),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Favori Hareketler",
                      style: TextStyle(
                        color: Colors.blueGrey.shade900,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Icon(
                      Icons.keyboard_arrow_right_rounded,
                      color: Colors.blueGrey.shade900,
                    )
                  ],
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Favori olarak kaydedilen hareketlere buraya tıklayarak erişebilirsin.",
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 20),
            child: Row(
              children: [
                Text(
                  "Önerilen Egzersizler",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    ];
  }

  //Yana Kayan Liste
  List<Widget> yanaKayanList() {
    return [
      Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            color: Colors.grey.shade100,
          ),
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return yanSatir(context, index);
            },
            itemCount: tumOneriler.length,
          ),
        ),
      )
    ];
  }

  //Yana Kayan Liste
  Widget yanSatir(BuildContext context, int index) {
    Oneri oAnEklenecek = tumOneriler[index];

    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 10, bottom: 0, right: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "/oneriDetay/$index");
            },
            child: Container(
              decoration: BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage(
                    "assets/images/others/" + oAnEklenecek.oneriResim,
                  ),
                  fit: BoxFit.contain,
                ),
                borderRadius: BorderRadius.all(Radius.circular(60.0)),
                color: Colors.grey.shade300,
              ),
              width: MediaQuery.of(context).size.width / 6,
              height: MediaQuery.of(context).size.height / 12,
            ),
          ),
          Text(tumOneriler[index].oneriAd,style: TextStyle(fontSize: MediaQuery.of(context).size.width/35),)
        ],
      ),
    );
  }

  List<Widget> hareketBmiElemanlari() {
    return [
      Padding(
        padding: EdgeInsets.only(left: 10, top: 10),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Size Özel",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 15),
              child: Row(
                children: [
                  //Hareket Kaydedici
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HareketKaydediciSayfasi()));
                    },
                    child: Container(
                        height: MediaQuery.of(context).size.height / 7.5,
                        width: MediaQuery.of(context).size.width / 2.05,
                        decoration: BoxDecoration(
                            color: Colors.blueGrey.shade900,
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "Yaptığınız Hareketleri",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 16),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5.0, left: 12.0),
                                        child: Image.asset(
                                          "assets/images/general/kaydedici.png",
                                          width: 45,
                                          height: 45,
                                        ),
                                      ),
                                      Text(
                                        "Kaydedin",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  //BMI Hesaplayıcı
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VucutKitleSayfasi()));
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height / 7.5,
                      width: MediaQuery.of(context).size.width / 2.25,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade500,
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(6),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Vücut Kitle Endeksi",
                                  style: TextStyle(
                                      color: Colors.blueGrey.shade900,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 16),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5.0, left: 7.0),
                                      child: Image.asset(
                                        "assets/images/general/bmi.png",
                                        width: 45,
                                        height: 45,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 18.0),
                                      child: Text(
                                        "Hesapla",
                                        style: TextStyle(
                                            color: Colors.blueGrey.shade900,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ];
  }
}
