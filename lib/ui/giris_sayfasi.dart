import 'package:cocuklar_icin_spor_app/main.dart';
import 'package:cocuklar_icin_spor_app/models/kisisel.dart';
import 'package:cocuklar_icin_spor_app/utils/database_helper.dart';
import 'package:flutter/material.dart';

class GirisSayfasi extends StatefulWidget {
  @override
  _GirisSayfasiState createState() => _GirisSayfasiState();
}

class _GirisSayfasiState extends State<GirisSayfasi> {
  double _yasForm = 7;
  var otomatikKontrol = AutovalidateMode.disabled;
  var _formKey = GlobalKey<FormState>();

  DatabaseHelper _databaseHelper;
  List<Kisisel> tumKisiselVerilerListesi;
  var _controller = TextEditingController();

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
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text("Bilgilerinizi Giriniz"),
        centerTitle: true,
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
                 Padding(
                  child: Image.asset(
                    "assets/images/kullanici.png",
                    width: 100,
                    height: 100,
                  ),
                  padding: EdgeInsets.only(bottom: 40),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.account_box_rounded),
                    labelText: "Ad Soyad",
                    border: OutlineInputBorder(),
                  ),
                  autofocus: false,
                  maxLength: 20,
                  controller: _controller,
                  validator: _isimKontrol,
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
      return 'Ad alanı sayısal değer içermemeli.';
    else
      return null;
  }
}
