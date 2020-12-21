import 'package:cocuklar_icin_spor_app/models/hareket.dart';
import 'package:cocuklar_icin_spor_app/utils/database_helper.dart';
import 'package:flutter/material.dart';

class HareketKaydediciSayfasi extends StatefulWidget {
  @override
  _HareketKaydediciSayfasiState createState() =>
      _HareketKaydediciSayfasiState();
}

class _HareketKaydediciSayfasiState extends State<HareketKaydediciSayfasi> {
  var _formKey = GlobalKey<FormState>();
  var otomatikKontrol = AutovalidateMode.disabled;
  DatabaseHelper _databaseHelper;
  List<Hareket> tumKaydedilenlerListesi;
  var _controller = TextEditingController();

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
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text("Kaydedilecek Hareket"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.account_box_rounded),
                    labelText: "Ad Soyad",
                    border: OutlineInputBorder(),
                  ),
                  autofocus: false,
                  controller: _controller,
                  validator: _isimKontrol,
                ),
                SizedBox(
                  height: 25,
                ),
                RaisedButton.icon(
                  onPressed: () {
                    // if (_formKey.currentState.validate()) {
                    //   _kayitEkle(Kisisel(_controller.text, _yasForm.toInt()));
                    // }
                    _hareketEkle(Hareket(
                        _controller.text, _controller.text, _controller.text));
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
            )),
      ),
    );
  }

  String _isimKontrol(String deger) {
    RegExp regex = RegExp("[a-zA-Z]+\$");
    if (!regex.hasMatch(deger))
      return 'Ad alanı numara içermemeli.';
    else
      return null;
  }

  void _hareketEkle(Hareket hareket) async {
    if (_formKey.currentState.validate()) {
      var eklenenHareketID = await _databaseHelper.hareketEkle(hareket);
      hareket.hareketID = eklenenHareketID;
    } else {
      setState(() {
        otomatikKontrol = AutovalidateMode.always;
      });
    }
  }
}
