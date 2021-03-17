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
  var automaticControl = AutovalidateMode.disabled;
  DatabaseHelper _databaseHelper;
  var _controller = TextEditingController();
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  InterstitialAd myInterstitialAd;

  List<Hareket> allSavedExercices;
  DateTime thisTime = DateTime.now();
  DateTime beforeThisTime =
      DateTime(2021, DateTime.now().month, DateTime.now().day - 3);
  List<String> allExercices = [
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
  List<String> allExerciceType = ["Set", "Tekrar", "Dakika", "Saat", "Hareket"];
  String selectedExerciceType = "Set";
  String selectedExercise = "Şınav";
  int clickedCardIndex;
  int clickedCardID;
  int listSize = 0;
  int selectedNumber = 1;

  @override
  void initState() {
    super.initState();
    allSavedExercices = List<Hareket>();
    _databaseHelper = DatabaseHelper();
    _databaseHelper.tumHareketler().then((value) {
      for (Map okunanHareketListesi in value) {
        allSavedExercices
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
      listSize = allSavedExercices.length;
    });
    double en = MediaQuery.of(context).size.width;
    double boy = MediaQuery.of(context).size.height;
    final TextStyle _dropTextStyle = TextStyle(
        color: Colors.blueGrey.shade900,
        fontWeight: FontWeight.w400,
        fontSize: en / 22);

    final BoxDecoration _dropdownDecoration = BoxDecoration(
        border: Border.all(color: Colors.blueAccent.shade100, width: 1.5),
        borderRadius: BorderRadius.all(Radius.circular(3)));

    final Icon _dropdownIcon = Icon(
      Icons.keyboard_arrow_down_rounded,
      color: Colors.blueAccent.shade100,
      size: en / 15,
    );

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text(
          "Hareket Geçmişi",
          style: Theme.of(context).appBarTheme.textTheme.headline1,
        ),
      ),
      body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: en / 2.75,
                          height: boy / 17,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(bottom: 10, top: 5),
                          decoration: _dropdownDecoration,
                          child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                  icon: _dropdownIcon,
                                  items: createDropdownNumbers(_dropTextStyle),
                                  value: selectedNumber,
                                  onChanged: (val) =>
                                      setState(() => selectedNumber = val))),
                        ),
                        Container(
                          width: en / 2.75,
                          height: boy / 17,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(bottom: 10, top: 5),
                          decoration: _dropdownDecoration,
                          child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                  icon: _dropdownIcon,
                                  items: _createDropdownExerciceType(
                                      _dropTextStyle),
                                  value: selectedExerciceType,
                                  onChanged: (val) => setState(
                                      () => selectedExerciceType = val))),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: en / 1.6,
                          height: boy / 17,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(bottom: 10, top: 5),
                          decoration: _dropdownDecoration,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              icon: _dropdownIcon,
                              items: _createDropdownExercices(_dropTextStyle),
                              onChanged: (selected) {
                                setState(() {
                                  selectedExercise = selected;
                                });
                              },
                              value: selectedExercise,
                            ),
                          ),
                        ),
                        //Farklı tarih seç buton
                        IconButton(
                          icon: Icon(Icons.date_range, size: en / 15),
                          color: Colors.blueGrey.shade900,
                          onPressed: () {
                            showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: beforeThisTime,
                                    lastDate: DateTime.now())
                                .then(
                              (secilenTarih) {
                                thisTime = secilenTarih;
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
                      if (thisTime == null) {
                        thisTime = DateTime.now();
                      }
                      _hareketEkle(Hareket(
                          selectedExercise,
                          thisTime.toString(),
                          selectedNumber.toString() +
                              " " +
                              selectedExerciceType));
                    },
                    color: Theme.of(context).accentColor,
                    child: Text(
                      "Kaydet",
                      style: TextStyle(
                          color: Colors.greenAccent, fontSize: en / 27),
                    ),
                  ),
                  RaisedButton(
                      color: Theme.of(context).accentColor,
                      child: Text(
                        "Güncelle",
                        style: TextStyle(
                            color: Colors.orangeAccent, fontSize: en / 27),
                      ),
                      onPressed: clickedCardID == null
                          ? null
                          : () {
                              if (_formKey.currentState.validate()) {
                                _hareketGuncelle(Hareket.withID(
                                    clickedCardID,
                                    selectedExercise,
                                    thisTime.toString(),
                                    _controller.text));
                              }
                            }),
                  RaisedButton(
                    onPressed: () {
                      if (allSavedExercices.length == 0) {
                      } else {
                        alertEminMi(context);
                      }
                    },
                    color: Theme.of(context).accentColor,
                    child: Text(
                      "Tüm Bilgileri Sil",
                      style:
                          TextStyle(color: Colors.redAccent, fontSize: en / 27),
                    ),
                  ),
                ],
              ),
              Divider(color: Colors.blueAccent.shade100, thickness: 2),
              Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Hareket Geçmişi Listesi",
                      style: TextStyle(fontSize: en / 25),
                    ),
                    Text(
                        listSize.toString() == null
                            ? "Boyut: 0"
                            : "Boyut: $listSize",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: en / 30,
                        ))
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: allSavedExercices.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.white,
                        child: ListTile(
                          onTap: () {
                            setState(() {
                              _controller.text =
                                  allSavedExercices[index].hareketTekrarSayisi;
                              selectedExercise =
                                  allSavedExercices[index].hareketAd;
                              clickedCardIndex = index;
                              clickedCardID =
                                  allSavedExercices[index].hareketID;
                            });
                          },
                          title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  allSavedExercices[index].hareketAd,
                                  style: TextStyle(
                                      fontSize: en / 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  allSavedExercices[index].hareketTekrarSayisi,
                                  style: TextStyle(fontSize: en / 27),
                                )
                              ]),
                          subtitle: Text(
                            formatDate(
                                DateTime.parse(
                                    allSavedExercices[index].hareketTarih),
                                [dd, '-', mm, '-', yyyy]),
                          ),
                          trailing: GestureDetector(
                            child: Icon(Icons.delete,
                                size: en / 15, color: Colors.red.shade400),
                            onTap: () {
                              _hareketSil(
                                  allSavedExercices[index].hareketID, index);
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

  // String _alanKontrol(String deger) {
  //   RegExp regex = RegExp("[a-zA-Z]");
  //   if (!regex.hasMatch(deger))
  //     return 'Boş değer veya sadece sayı girmemelisiniz.';
  //   else
  //     return null;
  // }

  void _hareketEkle(Hareket hareket) async {
    if (_formKey.currentState.validate() && allSavedExercices.length < 15) {
      var eklenenHareketID = await _databaseHelper.hareketEkle(hareket);
      hareket.hareketID = eklenenHareketID;
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: Colors.green.shade600,
        content: Text("Yeni kayıt eklendi."),
        duration: Duration(seconds: 1),
      ));
      setState(() {
        allSavedExercices.insert(0, hareket);
      });
    } else {
      if (allSavedExercices.length >= 15) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          backgroundColor: Colors.black,
          content: Text("Hatırlatıcı boyut sınırına ulaştınız: 15 kayıt."),
          duration: Duration(seconds: 1),
        ));
      }
      if (!_formKey.currentState.validate()) {
        automaticControl = AutovalidateMode.always;
      }
    }
  }

  void _hareketGuncelle(Hareket hareket) async {
    var sonuc = await _databaseHelper.hareketGuncelle(hareket);
    if (sonuc == 1) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: Colors.orange.shade500,
        content: Text("${clickedCardIndex + 1}. hareket notu güncellendi."),
        duration: Duration(seconds: 1),
      ));
      setState(() {
        allSavedExercices[clickedCardIndex] = hareket;
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
        allSavedExercices.removeAt(forListtoDeleteIndex);
      });
    } else {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Silme işlemi sırasında hata oluştu."),
        duration: Duration(seconds: 1),
      ));
    }
    clickedCardID = null;
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
        allSavedExercices.clear();
      });
    }
    clickedCardID = null;
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
            backgroundColor: Theme.of(context).accentColor,
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

  List<DropdownMenuItem> createDropdownNumbers(textStyle) {
    List<int> numberList = List<int>.generate(100, (int index) => index + 1);
    List<DropdownMenuItem> dropdownNumberList = numberList
        .map((val) => DropdownMenuItem(
            value: val, child: Text(val.toString(), style: textStyle)))
        .toList();
    return dropdownNumberList;
  }

  List<DropdownMenuItem> _createDropdownExercices(textStyle) {
    List<DropdownMenuItem> dropdownExerciceList = allExercices.map((val) {
      return DropdownMenuItem<String>(
          child: Align(
            alignment: Alignment.center,
            child: Text(
              val,
              style: textStyle,
            ),
          ),
          value: val);
    }).toList();
    return dropdownExerciceList;
  }

  List<DropdownMenuItem> _createDropdownExerciceType(textStyle) {
    List<DropdownMenuItem> dropdownExerciceTypeList =
        allExerciceType.map((val) {
      return DropdownMenuItem<String>(
          child: Align(
            alignment: Alignment.center,
            child: Text(
              val,
              style: textStyle,
            ),
          ),
          value: val);
    }).toList();
    return dropdownExerciceTypeList;
  }
}
