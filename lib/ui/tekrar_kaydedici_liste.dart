import 'package:cocuklar_icin_spor_app/admob/admob_islemleri.dart';
import 'package:cocuklar_icin_spor_app/models/hareket.dart';
import 'package:cocuklar_icin_spor_app/utils/database_helper.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';

class HareketKaydediciSayfasi extends StatefulWidget {
  @override
  _HareketKaydediciSayfasiState createState() =>
      _HareketKaydediciSayfasiState();
}

class _HareketKaydediciSayfasiState extends State<HareketKaydediciSayfasi> {
  var _formKey = GlobalKey<FormState>();
  var otomatikKontrol = AutovalidateMode.disabled;
  DatabaseHelper _databaseHelper;
  var _controller = TextEditingController();
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  InterstitialAd myInterstitialAd;

  List<Hareket> tumKaydedilenlerListesi;
  DateTime suan = DateTime.now();
  DateTime once = DateTime(2021, DateTime.now().month, DateTime.now().day - 3);
  List<String> tumEgzersizler = [
    "Şınav",
    "Mekik",
    "Plank",
    "Yan Plank",
    "Direnç Bandı",
    "Koşu",
    "Yürüyüş",
    "Squad",
    "Isınma",
    "Pilates",
    "Yoga"
  ];
  String secilenEgzersiz = "Şınav";
  int tiklanilanCardIndex;
  int tiklanilanCardID;
  int boyut = 0;

  @override
  void initState() {
    super.initState();
    tumKaydedilenlerListesi = List<Hareket>();
    _databaseHelper = DatabaseHelper();
    _databaseHelper.tumHareketler().then((value) {
      for (Map okunanHareketListesi in value) {
        tumKaydedilenlerListesi
            .add(Hareket.fromDbReadingConvertObject(okunanHareketListesi));
      }
      setState(() {});
    }).catchError((hata) => print("İnit state hata alındı: " + hata));
    AdmobIslemleri.admobInitialize();
    myInterstitialAd = AdmobIslemleri.buildInterstitialAd();
    myInterstitialAd
      ..load()
      ..show();
  }

  @override
  void dispose() {
    if (myInterstitialAd != null) myInterstitialAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      boyut = tumKaydedilenlerListesi.length;
    });
    double en = MediaQuery.of(context).size.width;
    double boy = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text("Hareket Hatırlatıcı"),
        centerTitle: true,
      ),
      body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.timer),
                          labelText: "Set / Tekrar Sayısı veya Dakika Giriniz",
                          labelStyle: TextStyle(fontSize: 15),
                          border: OutlineInputBorder(),
                        ),
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                        cursorColor: Colors.grey,
                        maxLength: 10,
                        autofocus: false,
                        controller: _controller,
                        validator: _alanKontrol,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: en / 1.5,
                          height: boy / 17,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(bottom: 10, top: 5),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              border: Border.all(color: Colors.grey),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2))),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              dropdownColor: Colors.white,
                              iconSize: 30,
                              items: tumEgzersizler.map((oankiEgzersiz) {
                                return DropdownMenuItem<String>(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      oankiEgzersiz,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: en / 20),
                                    ),
                                  ),
                                  value: oankiEgzersiz,
                                );
                              }).toList(),
                              onChanged: (secilen) {
                                setState(() {
                                  secilenEgzersiz = secilen;
                                });
                              },
                              value: secilenEgzersiz,
                            ),
                          ),
                        ),
                        //Farklı tarih seç buton
                        IconButton(
                          icon: Icon(Icons.date_range),
                          color: Colors.black,
                          onPressed: () {
                            showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: once,
                                    lastDate: DateTime.now())
                                .then(
                              (secilenTarih) {
                                suan = secilenTarih;
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    onPressed: () {
                      if (suan == null) {
                        suan = DateTime.now();
                      }
                      _hareketEkle(Hareket(
                          secilenEgzersiz, suan.toString(), _controller.text));
                    },
                    color: Colors.blueGrey.shade900,
                    child: Text(
                      "Kaydet",
                      style: TextStyle(
                          color: Colors.greenAccent, fontSize: en / 27),
                    ),
                  ),
                  RaisedButton(
                      disabledColor: Colors.blueGrey.shade900,
                      color: Colors.blueGrey.shade900,
                      child: Text(
                        "Güncelle",
                        style: TextStyle(
                            color: Colors.orangeAccent, fontSize: en / 27),
                      ),
                      onPressed: tiklanilanCardID == null
                          ? null
                          : () {
                              if (_formKey.currentState.validate()) {
                                _hareketGuncelle(Hareket.withID(
                                    tiklanilanCardID,
                                    secilenEgzersiz,
                                    suan.toString(),
                                    _controller.text));
                              }
                            }),
                  RaisedButton(
                    onPressed: () {
                      if (tumKaydedilenlerListesi.length == 0) {
                      } else {
                        alertEminMi(context);
                      }
                    },
                    color: Colors.blueGrey.shade900,
                    child: Text(
                      "Tüm Bilgileri Sil",
                      style:
                          TextStyle(color: Colors.redAccent, fontSize: en / 27),
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.grey,
                thickness: 2,
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Kayıtlı Hareket Bilgilerim",
                      style: TextStyle(fontSize: en / 25),
                    ),
                    Text(
                        boyut.toString() == null ? "Boyut: 0" : "Boyut: $boyut",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: en / 30,
                        ))
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: tumKaydedilenlerListesi.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.white,
                        child: ListTile(
                          onTap: () {
                            setState(() {
                              _controller.text = tumKaydedilenlerListesi[index]
                                  .hareketTekrarSayisi;
                              secilenEgzersiz =
                                  tumKaydedilenlerListesi[index].hareketAd;
                              tiklanilanCardIndex = index;
                              tiklanilanCardID =
                                  tumKaydedilenlerListesi[index].hareketID;
                            });
                          },
                          title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  tumKaydedilenlerListesi[index].hareketAd,
                                  style: TextStyle(
                                      fontSize: en / 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "Not: " +
                                      tumKaydedilenlerListesi[index]
                                          .hareketTekrarSayisi,
                                  style: TextStyle(fontSize: en / 27),
                                )
                              ]),
                          subtitle: Text(
                            formatDate(
                                DateTime.parse(tumKaydedilenlerListesi[index]
                                    .hareketTarih),
                                [dd, '-', mm, '-', yyyy]),
                          ),
                          trailing: GestureDetector(
                            child: Icon(Icons.delete,
                                size: en / 15, color: Colors.red.shade400),
                            onTap: () {
                              _hareketSil(
                                  tumKaydedilenlerListesi[index].hareketID,
                                  index);
                            },
                          ),
                        ),
                      );
                    }),
              ),
            ],
          )),
    );
  }

  String _alanKontrol(String deger) {
    RegExp regex = RegExp("[a-zA-Z]");
    if (!regex.hasMatch(deger))
      return 'Boş değer veya sadece sayı girmemelisiniz.';
    else
      return null;
  }

  void _hareketEkle(Hareket hareket) async {
    if (_formKey.currentState.validate() &&
        tumKaydedilenlerListesi.length < 15) {
      var eklenenHareketID = await _databaseHelper.hareketEkle(hareket);
      hareket.hareketID = eklenenHareketID;
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: Colors.green.shade600,
        content: Text("Yeni kayıt eklendi."),
        duration: Duration(seconds: 1),
      ));
      setState(() {
        tumKaydedilenlerListesi.insert(0, hareket);
      });
    } else {
      if (tumKaydedilenlerListesi.length >= 15) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          backgroundColor: Colors.black,
          content: Text("Hatırlatıcı boyut sınırına ulaştınız: 15 kayıt."),
          duration: Duration(seconds: 1),
        ));
      }
      if (!_formKey.currentState.validate()) {
        otomatikKontrol = AutovalidateMode.always;
      }
    }
  }

  void _hareketGuncelle(Hareket hareket) async {
    var sonuc = await _databaseHelper.hareketGuncelle(hareket);
    if (sonuc == 1) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: Colors.orange.shade500,
        content: Text("${tiklanilanCardIndex + 1}. hareket notu güncellendi."),
        duration: Duration(seconds: 1),
      ));
      setState(() {
        tumKaydedilenlerListesi[tiklanilanCardIndex] = hareket;
      });
    }
  }

  void _hareketSil(int forDBtoDeleteID, int forListtoDeleteIndex) async {
    var sonuc = await _databaseHelper.hareketSil(forDBtoDeleteID);
    if (sonuc == 1) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: Colors.red.shade800,
        content: Text("Hareket notu silindi."),
        duration: Duration(seconds: 1),
      ));
      setState(() {
        tumKaydedilenlerListesi.removeAt(forListtoDeleteIndex);
      });
    } else {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Silme işlemi sırasında hata oluştu."),
        duration: Duration(seconds: 1),
      ));
    }
    tiklanilanCardID = null;
  }

  void _tumTabloyuTemizle() async {
    var silinenElemanSayisi = await _databaseHelper.tumHareketTablosunuSil();
    if (silinenElemanSayisi > 0) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: Colors.red.shade800,
        duration: Duration(seconds: 1),
        content: Text(
            silinenElemanSayisi.toString() + " adet hareket notu silindi."),
      ));
      setState(() {
        tumKaydedilenlerListesi.clear();
      });
    }
    tiklanilanCardID = null;
  }

  void alertEminMi(BuildContext ctx) {
    showDialog(
        context: ctx,
        barrierDismissible: false,
        builder: (ctx) {
          return AlertDialog(
            title: Center(
              child: Text(
                "Emin misin?",
                style: TextStyle(color: Colors.yellow.shade800),
              ),
            ),
            backgroundColor: Colors.blueGrey.shade900,
            content: SingleChildScrollView(
                child: Center(
              child: Text(
                "Tüm bilgilerin silinecek.",
                style: TextStyle(color: Colors.white),
              ),
            )),
            actions: [
              FlatButton(
                  child: Text(
                    "Eminim",
                    style: TextStyle(color: Colors.greenAccent, fontSize: 12),
                  ),
                  onPressed: () {
                    _tumTabloyuTemizle();
                    Navigator.of(ctx).pop();
                  }),
              FlatButton(
                  child: Text(
                    "İptal",
                    style: TextStyle(color: Colors.redAccent, fontSize: 12),
                  ),
                  onPressed: () => Navigator.of(ctx).pop()),
            ],
          );
        });
  }
}
