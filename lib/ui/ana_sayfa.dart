import 'package:cocuklar_icin_spor_app/methods/oneri_verileri_hazirla.dart';
import 'package:cocuklar_icin_spor_app/models/kisisel.dart';
import 'package:cocuklar_icin_spor_app/models/oneri.dart';
import 'package:cocuklar_icin_spor_app/ui/bilgileri_guncelle.dart';
import 'package:cocuklar_icin_spor_app/ui/favori_listesi_sayfasi.dart';
import 'package:cocuklar_icin_spor_app/ui/faydali_bilgiler_beslenme.dart';
import 'package:cocuklar_icin_spor_app/ui/tekrar_kaydedici_liste.dart';
import 'package:cocuklar_icin_spor_app/ui/vucut_kitle_sayfasi.dart';
import 'package:cocuklar_icin_spor_app/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:launch_review/launch_review.dart';

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
    var boy = MediaQuery.of(context).size.height;
    var en = MediaQuery.of(context).size.width;

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
                  ButtonBar(
                    children: [
                      IconButton(
                          icon: Icon(Icons.stars,
                              size: en / 12, color: Colors.blueAccent.shade100),
                          onPressed: () {
                            // LaunchReview.launch(
                            //   androidAppId:
                            //       "com.company.appname", //app id change
                            // );
                          }),
                      IconButton(
                          icon: Icon(
                            Icons.account_circle_rounded,
                            color: Colors.blueGrey.shade700,
                            size: en / 12,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        BilgileriGuncelle())).then((value) {
                              setState(() {});
                            });
                          }),
                    ],
                  ),
                ]),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          pinned: true,
          primary: true,
          expandedHeight: 70,
          elevation: 4,
        ),
        SliverFixedExtentList(
          delegate: SliverChildListDelegate(girisElemanlari(en, boy)),
          itemExtent: boy / 2.7, //2.5
        ),
        SliverFixedExtentList(
            delegate: SliverChildListDelegate(yanaKayanList(en, boy)),
            itemExtent: boy / 5), //7
        SliverFixedExtentList(
            delegate: SliverChildListDelegate(hareketBmiElemanlari(en, boy)),
            itemExtent: boy / 4.4),
        SliverFixedExtentList(
            delegate: SliverChildListDelegate(tavsiyeElemanlari(en, boy)),
            itemExtent: boy / 2.8),
      ],
    );
  }

  //Giriş Kısmı ve Favori Card
  List<Widget> girisElemanlari(double en, boy) {
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
                          fontSize: en / 25,
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
                                  // color: Colors.deepOrange.shade900,
                                  color: Colors.blueAccent.shade100,
                                  fontSize: en / 19,
                                  fontWeight: FontWeight.bold),
                            );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        }),
                  ],
                ),
                Image.asset(
                  "assets/images/general/main.png",
                  width: en / 4,
                  height: boy / 7,
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
                color: Colors.blueAccent.shade100,
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
                        fontSize: en / 19,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Icon(
                      Icons.keyboard_arrow_right_rounded,
                      color: Colors.blueGrey.shade900,
                      size: en / 15,
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
                        style:
                            TextStyle(color: Colors.white, fontSize: en / 33),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ];
  }

  //Yana Kayan Liste
  List<Widget> yanaKayanList(double en, boy) {
    return [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0, bottom: 10),
            child: Text(
              "Önerilen Egzersizler",
              style: TextStyle(fontSize: en / 26, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                color: Colors.grey.shade100,
              ),
              height: boy / 8,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return yanSatir(context, index, en, boy);
                },
                itemCount: tumOneriler.length,
              ),
            ),
          )
        ],
      )
    ];
  }

  //Yana Kayan Liste
  Widget yanSatir(BuildContext context, int index, double en, boy) {
    Oneri oAnEklenecek = tumOneriler[index];

    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 10, bottom: 0, right: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, "/oneriDetay/$index");
            },
            child: Hero(
              tag: "assets/images/others/" + oAnEklenecek.oneriResim,
              child: Container(
                //Hata gelirse SingleChildScrollView
                decoration: BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage(
                      "assets/images/others/" + oAnEklenecek.oneriResim,
                    ),
                    fit: BoxFit.contain,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(en / 2)),
                  color: Colors.grey.shade200,
                ),
                width: en / 6,
                height: boy / 12,
              ),
            ),
          ),
          Text(
            tumOneriler[index].oneriAd,
            style: TextStyle(fontSize: en / 35),
          )
        ],
      ),
    );
  }

  //İkili Card
  List<Widget> hareketBmiElemanlari(double en, boy) {
    return [
      Padding(
        padding: EdgeInsets.only(left: 10),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Size Özel",
                  style:
                      TextStyle(fontSize: en / 26, fontWeight: FontWeight.bold),
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
                        height: boy / 7.5,
                        width: en / 2.05,
                        decoration: BoxDecoration(
                            color: Colors.blueGrey.shade900,
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start, //en
                                children: [
                                  Text(
                                    "Yaptığınız Hareketleri",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300,
                                        fontSize: en / 30),
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
                                          width: en / 9,
                                          height: en / 9,
                                        ),
                                      ),
                                      Text(
                                        "Kaydedin",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: en / 20),
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
                      height: boy / 7.5,
                      width: en / 2.25,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade500,
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(6),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start, //en
                              children: [
                                Text(
                                  "Vücut Kitle Endeksi",
                                  style: TextStyle(
                                      color: Colors.blueGrey.shade900,
                                      fontWeight: FontWeight.w300,
                                      fontSize: en / 30),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5.0, left: 7.0),
                                      child: Image.asset(
                                        "assets/images/general/bmi.png",
                                        width: en / 9,
                                        height: en / 9,
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
                                            fontSize: en / 20),
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

  //Faydalı Card
  List<Widget> tavsiyeElemanlari(double en, boy) {
    return [
      Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Faydalı Bilgiler",
                  style:
                      TextStyle(fontSize: en / 26, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BeslenmeSayfasi()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Beslenme",
                                  style: TextStyle(
                                      color: Colors.blue.shade600,
                                      fontSize: en / 26,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Detaylı bilgiler için dokunun.",
                                  style: TextStyle(
                                    fontSize: en / 33,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ],
                            ),
                            Image.asset(
                              "assets/images/general/food.png",
                              width: en / 8,
                              height: boy / 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: en / 37,
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Plan ve Düzen",
                              style: TextStyle(
                                  color: Colors.grey.shade600, //blue.shade600
                                  fontSize: en / 26,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              // "Planlı ve düzenli olmanın sporda önemi.",
                              "Çok yakında!",
                              style: TextStyle(
                                fontSize: en / 33,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ],
                        ),
                        Opacity(
                          opacity: 0.3,
                          child: Image.asset(
                            "assets/images/general/plan_passive.png", //change plan.png
                            width: en / 8,
                            height: boy / 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: en / 37,
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Uyku",
                              style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: en / 26,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              // "Uyku ve dinlenme hakkında detaylı bilgiler.",
                              "Çok yakında!",
                              style: TextStyle(
                                fontSize: en / 33,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ],
                        ),
                        Opacity(
                          opacity: 0.3,
                          child: Image.asset(
                            "assets/images/general/sleep_passive.png", //change sleep.png
                            width: en / 8,
                            height: boy / 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      )
    ];
  }
}
