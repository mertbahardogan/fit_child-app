import 'package:cocuklar_icin_spor_app/models/favori_durum.dart';
import 'package:cocuklar_icin_spor_app/models/kisisel.dart';
import 'package:cocuklar_icin_spor_app/models/oneri.dart';
import 'package:cocuklar_icin_spor_app/ui/bilgileri_guncelle.dart';
import 'package:cocuklar_icin_spor_app/ui/favori_listesi_sayfasi.dart';
import 'package:cocuklar_icin_spor_app/ui/tekrar_kaydedici_liste.dart';
import 'package:cocuklar_icin_spor_app/ui/vucut_kitle_sayfasi.dart';
import 'package:cocuklar_icin_spor_app/utils/database_helper.dart';
import 'package:cocuklar_icin_spor_app/utils/others.dart';
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

    //
    tumOneriler = _verileriHazirla();

    return CustomScrollView(
      scrollDirection: Axis.vertical,
      slivers: [
        SliverAppBar(
          title: Row(
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
              GestureDetector(
                child: Container(
                  child: Image.asset("assets/images/general/profile.png"),
                  width: 30,
                  height: 30,
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
            ],
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          pinned: true,
          primary: true,
          expandedHeight: 70,
          elevation: 4,
        ),
        SliverFixedExtentList(
          delegate: SliverChildListDelegate(sabitCardElemanlari()),
          itemExtent: ekranHeight - 470,
        ),
        // SliverFixedExtentList(

        //     delegate: SliverChildBuilderDelegate(_dinamikCardElemanlari,
        //         childCount: 5,),
        //     itemExtent: 200),

        SliverFixedExtentList(
            delegate: SliverChildListDelegate(pageViewCard()), itemExtent: 130),
      ],
    );
  }

  List<Widget> sabitCardElemanlari() {
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
          //Favori Sayfa Kısmı

          // GestureDetector(
          //   onTap: () {
          //     Navigator.push(
          //         context,w
          //         MaterialPageRoute(
          //             builder: (context) => HareketKaydediciSayfasi()));
          //   },
          //   child: Container(
          //     width: MediaQuery.of(context).size.width,
          //     decoration: BoxDecoration(
          //       color: Colors.green.shade200,
          //       borderRadius: BorderRadius.all(Radius.circular(2)),
          //       boxShadow: [
          //         BoxShadow(
          //           color: Colors.grey.shade700,
          //           offset: Offset(0.2, 0.2),
          //           blurRadius: 6.0,
          //         ),
          //       ],
          //     ),
          //     margin: EdgeInsets.fromLTRB(10, 25, 10, 0),
          //     child: Column(children: [
          //       Image.asset(
          //         "assets/images/liste.png",
          //         width: 60,
          //         height: 60,
          //       ),
          //       Text(
          //         "Anteman Programı",
          //         style: TextStyle(
          //             color: Colors.white,
          //             fontSize: 22,
          //             fontWeight: FontWeight.w500),
          //         textAlign: TextAlign.center,
          //       ),
          //       Text(
          //         "Tekrar Sayılarınızı Kaydedin",
          //         style: TextStyle(
          //             color: Colors.white,
          //             fontSize: 18,
          //             fontWeight: FontWeight.w500),
          //         textAlign: TextAlign.center,
          //       ),
          //       Text(
          //         "Listeye gitmek için tıklayınız.",
          //         style: TextStyle(
          //             color: Colors.grey,
          //             fontSize: 13,
          //             fontWeight: FontWeight.w500),
          //         textAlign: TextAlign.center,
          //       ),
          //     ]),
          //   ),
          // ),
          // GestureDetector(
          //   onTap: () {
          //     Navigator.push(context,
          //         MaterialPageRoute(builder: (context) => VucutKitleSayfasi()));
          //   },
          //   child: Container(
          //     width: MediaQuery.of(context).size.width,
          //     decoration: BoxDecoration(
          //       color: Colors.brown.shade200,
          //       borderRadius: BorderRadius.all(Radius.circular(2)),
          //       boxShadow: [
          //         BoxShadow(
          //           color: Colors.grey.shade700,
          //           offset: Offset(0.2, 0.2),
          //           blurRadius: 6.0,
          //         ),
          //       ],
          //     ),
          //     margin: EdgeInsets.fromLTRB(10, 25, 10, 0),
          //     child: Column(children: [
          //       Image.asset(
          //         "assets/images/yag.png",
          //         width: 60,
          //         height: 60,
          //       ),
          //       Text(
          //         "Vücut Kitle Endeksi",
          //         style: TextStyle(
          //             color: Colors.white,
          //             fontSize: 22,
          //             fontWeight: FontWeight.w500),
          //         textAlign: TextAlign.center,
          //       ),
          //       Text(
          //         "Oranınızı Öğrenin",
          //         style: TextStyle(
          //             color: Colors.white,
          //             fontSize: 18,
          //             fontWeight: FontWeight.w500),
          //         textAlign: TextAlign.center,
          //       ),
          //       Text(
          //         "Hesaplayıcıya gitmek için tıklayınız.",
          //         style: TextStyle(
          //             color: Colors.grey.shade600,
          //             fontSize: 13,
          //             fontWeight: FontWeight.w500),
          //         textAlign: TextAlign.center,
          //       ),
          //     ]),
          //   ),
          // ),

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

          // Container(
          //   decoration: BoxDecoration(
          //     color: Colors.teal,
          //     borderRadius: BorderRadius.all(Radius.circular(2)),
          //     boxShadow: [
          //       BoxShadow(
          //         color: Colors.grey.shade700,
          //         offset: Offset(0.2, 0.2), //(x,y)
          //         blurRadius: 6.0,
          //       ),
          //     ],
          //   ),
          //   margin: EdgeInsets.fromLTRB(10, 25, 10, 0),
          //   child: ListTile(
          //     leading: Image.asset("assets/images/beslenme.png"),
          //     title: Text(
          //       "Beslenme",
          //       style: TextStyle(
          //           color: Colors.white,
          //           fontSize: 22,
          //           fontWeight: FontWeight.w500),
          //       textAlign: TextAlign.center,
          //     ),
          //     subtitle: Column(
          //       children: [
          //         Text(
          //           "Sebze ve meyve tüketimi vücut gelişimi açısından çok önemlidir.",
          //           style: TextStyle(color: Colors.white, fontSize: 16),
          //         ),
          //         Divider(color: Colors.white),
          //         Text(
          //           "Dengeli ve sağlıklı beslenmeye özen gösterirseniz yaptığınız spordan daha çok verim alabilirsiniz.",
          //           style: TextStyle(color: Colors.white, fontSize: 16),
          //         ),
          //         Text(
          //           "Sporun büyük bir kısmı beslenmeden oluşur.",
          //           style: TextStyle(color: Colors.grey.shade400, fontSize: 10),
          //         )
          //       ],
          //     ),
          //   ),
          // ),
          // Container(
          //   decoration: BoxDecoration(
          //     color: Colors.teal,
          //     borderRadius: BorderRadius.all(Radius.circular(2)),
          //     boxShadow: [
          //       BoxShadow(
          //         color: Colors.grey.shade700,
          //         offset: Offset(0.2, 0.2), //(x,y)
          //         blurRadius: 6.0,
          //       ),
          //     ],
          //   ),
          //   margin: EdgeInsets.fromLTRB(10, 25, 10, 0),
          //   child: ListTile(
          //     leading: Image.asset("assets/images/sleep.png"),
          //     title: Text(
          //       "Uyku Düzeni",
          //       style: TextStyle(
          //           color: Colors.white,
          //           fontSize: 22,
          //           fontWeight: FontWeight.w500),
          //       textAlign: TextAlign.center,
          //     ),
          //     subtitle: Column(
          //       children: [
          //         Text(
          //           "Her gün yeteri kadar uyumalısın.",
          //           style: TextStyle(color: Colors.white, fontSize: 16),
          //         ),
          //         Text(
          //           "Yaptığımız sporun verimli olması için 8 saat uyumalıyız.",
          //           style: TextStyle(color: Colors.grey.shade400, fontSize: 10),
          //         )
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    ];
  }

  //Yana Kayan Liste
  List<Widget> pageViewCard() {
    return [
      Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            color: Colors.grey.shade200,
          ),
          height: 110,
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
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage(
                    "assets/images/others/" + oAnEklenecek.oneriResim,
                  ),
                  fit: BoxFit.contain,
                ),
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
                color: Colors.grey.shade300,
              ),
              width: MediaQuery.of(context).size.width / 5,
              height: MediaQuery.of(context).size.height / 10,
            ),
          ),
          Text(tumOneriler[index].oneriAd)
        ],
      ),
    );
  }

  List<Oneri> _verileriHazirla() {
    //Others veri kaynağı, Oneri model sınıfı.
    //Burda verileri bir listeye aktarıyoruz. Aktardığımız liste modelimizin propertysi.
    List<Oneri> oneriler = [];

    for (int i = 0; i < 7; i++) {
      String resim = Others.OTHERS_DOSYA_ADLARI[i] + "${i + 1}.png";

      Oneri eklenecekOneri = Oneri(Others.OTHERS_ADLARI[i],
          Others.OTHERS_DOSYA_ADLARI[i], Others.OTHERS_FAYDALARI[i], resim);
      oneriler.add(eklenecekOneri);
    }
    return oneriler;
  }
}
