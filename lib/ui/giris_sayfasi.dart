import 'package:cocuklar_icin_spor_app/main.dart';
import 'package:cocuklar_icin_spor_app/models/kisisel.dart';
import 'package:cocuklar_icin_spor_app/utils/database_helper.dart';
import 'package:flutter/material.dart';

class GirisSayfasi extends StatefulWidget {
  @override
  _GirisSayfasiState createState() => _GirisSayfasiState();
}

class _GirisSayfasiState extends State<GirisSayfasi> {
  // String _adSoyad;
  double _yasForm = 7;
  var otomatikKontrol = AutovalidateMode.disabled;
  var _formKey = GlobalKey<FormState>();

  DatabaseHelper _databaseHelper;
  List<Kisisel> tumKisiselVerilerListesi;
  var _controller = TextEditingController();
  // var _scaffoldKey = GlobalKey<ScaffoldState>();

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
    }).catchError((hata) => print("İnit state hata fonk: " + hata));
  }

  @override
  Widget build(BuildContext context) {
    double ekranHeight = MediaQuery.of(context).size.height;
    double ekranWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Bilgiler"),
      ),
      body: Padding(
          padding: EdgeInsets.only(
              top: ekranHeight / 3.5,
              left: ekranWidth / 10,
              right: ekranWidth / 10),
          child: Form(
            key: _formKey,
            autovalidateMode: otomatikKontrol,
            child: ListView(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.account_circle_outlined),
                    labelText: "Ad Soyad",
                    border: OutlineInputBorder(),
                  ),
                  autofocus: false,
                  controller: _controller,
                  validator: _isimKontrol,
                  // onSaved: (deger) => _adSoyad = deger,
                ),
                SizedBox(
                  height: 25,
                ),
                Text("Yaşınızı Seçiniz:"),
                Slider(
                    min: 7,
                    max: 17,
                    divisions: 10,
                    activeColor: Colors.red,
                    label: _yasForm.toInt().toString(),
                    inactiveColor: Colors.grey,
                    value: _yasForm,
                    onChanged: (secilen) {
                      setState(() {
                        _yasForm = secilen;
                        debugPrint("Girilen yaş değeri: $_yasForm");
                      });
                    }),
                SizedBox(
                  height: 25,
                ),
                RaisedButton.icon(
                  onPressed: () {
                    // if (_formKey.currentState.validate()) {
                    //   _kayitEkle(Kisisel(_controller.text, _yasForm.toInt()));
                    // }
                    _kayitEkle(Kisisel(_controller.text, _yasForm.toInt()));
                  },
                  icon: Icon(
                    Icons.save,
                    color: Colors.red,
                  ),
                  color: Colors.red,
                  label: Text(
                    "Kaydet",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  void _kayitEkle(Kisisel kisisel) async {
    if (_formKey.currentState.validate()) {
      // _formKey.currentState.save();
      var eklenenKayitID = await _databaseHelper.kayitEkle(kisisel);
      kisisel.id = eklenenKayitID;
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => MyHomePage()));
    } else {
      setState(() {
        otomatikKontrol = AutovalidateMode.always;
      });
    }
  }

  String _isimKontrol(String deger) {
    RegExp regex = RegExp("[a-zA-Z]+\$");
    if (!regex.hasMatch(deger))
      return 'Ad alanı numara içermemeli.';
    else
      return null;
  }

  // void _kayitEkle(Kisisel kisisel) async {
  //   var eklenenKayitID = await _databaseHelper.kayitEkle(kisisel);
  //   kisisel.id = eklenenKayitID;
  //   // MaterialPageRoute(builder: (context) => MyHomePage());

  //   // if (eklenenKayitID > 0) {
  //   //   setState(() {
  //   //     tumKisiselVerilerListesi.insert(0, kisisel);
  //   //   });
  //   // } else {
  //   //   setState(() {
  //   //     otomatikKontrol = AutovalidateMode.always;
  //   //   });
  // }
  // }
}
