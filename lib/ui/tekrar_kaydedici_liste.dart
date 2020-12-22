import 'package:cocuklar_icin_spor_app/models/hareket.dart';
import 'package:cocuklar_icin_spor_app/utils/database_helper.dart';
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

  List<Hareket> tumKaydedilenlerListesi;
  DateTime suan = DateTime.now();
  DateTime once = DateTime(2020,DateTime.now().month,DateTime.now().day - 7);
  List<String> tumEgzersizler = [
    "Şınav",
    "Mekik",
    "Plank",
    "Yan Plank",
    "Koşu",
    "Squad",
    "Isınma Hareketleri",
    "Yoga"
  ];
  String secilenEgzersiz = "Şınav";
  int tiklanilanCardIndex;
  int tiklanilanCardID;

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
  }

  @override
  Widget build(BuildContext context) {
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
                        maxLength: 20,
                        autofocus: false,
                        controller: _controller,
                        validator: _alanKontrol,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.5,
                      height: MediaQuery.of(context).size.height / 17,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(bottom: 10, top: 5),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(2))),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
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
                                      fontSize: 21),
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
                    Column(
                      children: [
                        FlatButton(
                          color: Colors.grey.shade300,
                          child: Text(
                            "Şu andan farklı tarih girmek için tıklayın.",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w400),
                          ),
                          onPressed: () {
                            showDatePicker(
                                    context: context,
                                    initialDate: suan,
                                    firstDate: once,
                                    lastDate: suan)
                                .then(
                              (secilenTarih) {
                                debugPrint(secilenTarih.toString());
                                suan = secilenTarih;
                                print(once.toString());
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
                      _hareketEkle(Hareket(
                          secilenEgzersiz, suan.toString(), _controller.text));
                    },
                    color: Colors.black,
                    child: Text(
                      "Kaydet",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  RaisedButton(
                      color: Colors.black,
                      child: Text(
                        "Güncelle",
                        style: TextStyle(
                          color: Colors.white,
                        ),
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
                      _tumTabloyuTemizle();
                    },
                    color: Colors.black,
                    child: Text(
                      "Tüm Verileri Sil",
                      style: TextStyle(
                        color: Colors.white,
                      ),
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
                child: Text(
                  "Kayıtlı Hareket Bilgilerim",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: tumKaydedilenlerListesi.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.red.shade100,
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
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  tumKaydedilenlerListesi[index]
                                      .hareketTekrarSayisi,
                                  style: TextStyle(fontSize: 17),
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
                                size: 25, color: Colors.grey.shade600),
                            onTap: () {
                              //Bir methoda bu şekilde değer gönderilir,incele!!
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
      return 'Boş değer girmemelisiniz.';
    else
      return null;
  }

  void _hareketEkle(Hareket hareket) async {
    if (_formKey.currentState.validate()) {
      var eklenenHareketID = await _databaseHelper.hareketEkle(hareket);
      hareket.hareketID = eklenenHareketID;
      setState(() {
        tumKaydedilenlerListesi.insert(0, hareket);
      });
    } else {
      otomatikKontrol = AutovalidateMode.always;
    }
  }

  void _hareketGuncelle(Hareket hareket) async {
    var sonuc = await _databaseHelper.hareketGuncelle(hareket);
    if (sonuc == 1) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content:
            Text("$tiklanilanCardID ID numaralı hareket notu güncellendi."),
        duration: Duration(seconds: 3),
      ));
      setState(() {
        tumKaydedilenlerListesi[tiklanilanCardIndex] = hareket;
        //bir listeye index göndermeden bu şekilde atama ya da alma yapabiliyoruz demek ki, incele!!
      });
    }
  }

  void _hareketSil(int forDBtoDeleteID, int forListtoDeleteIndex) async {
    var sonuc = await _databaseHelper.hareketSil(forDBtoDeleteID);
    if (sonuc == 1) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("$forDBtoDeleteID ID numaralı hareket notu silindi."),
        duration: Duration(seconds: 3),
      ));
      setState(() {
        tumKaydedilenlerListesi.removeAt(forListtoDeleteIndex);
      });
    } else {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Silme işlemi sırasında hata oluştu."),
        duration: Duration(seconds: 3),
      ));
    }
    tiklanilanCardID = null;
  }

  void _tumTabloyuTemizle() async {
    var silinenElemanSayisi = await _databaseHelper.tumHareketTablosunuSil();
    if (silinenElemanSayisi > 0) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        duration: Duration(seconds: 3),
        content: Text(
            silinenElemanSayisi.toString() + " adet hareket notu silindi."),
      ));
      setState(() {
        tumKaydedilenlerListesi.clear();
      });
    }
    tiklanilanCardID = null;
  }
}

// List<Egzersiz> listeyiDoldur() {
//   List<Egzersiz> egzersizAd = [];

//   for (int i = 0; i < 8; i++) {
//     Egzersiz eklenecekEgzersiz = Egzersiz.kaydediciOzel(
//       Strings.EGZERSIZ_ADLARI[i],
//     );
//     egzersizAd.add(eklenecekEgzersiz);
//   }
//   // secilenEgzersiz = egzersizAd[0].toString();
//   return egzersizAd;
// }

//Dropdown hareketleri dinamik olarak çekilecek
