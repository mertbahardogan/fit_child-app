import 'package:cocuklar_icin_spor_app/main.dart';
import 'package:flutter/material.dart';

class GirisSayfasi extends StatefulWidget {
  @override
  _GirisSayfasiState createState() => _GirisSayfasiState();
}

class _GirisSayfasiState extends State<GirisSayfasi> {
  String _adSoyad, _favoriSpor = "Basketbol";
  double _yas = 7;
  List<String> sporlar = ["Basketbol", "Futbol", "Voleybol", "Tenis", "Boks"];

  var otomatikKontrol = AutovalidateMode.disabled;

  final formKey = GlobalKey<FormState>();

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
            key: formKey,
            autovalidateMode: otomatikKontrol,
            child: ListView(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.account_circle_outlined),
                    labelText: "Ad Soyad",
                    border: OutlineInputBorder(),
                  ),
                  validator: _isimKontrol,
                  onSaved: (deger) => _adSoyad = deger,
                ),
                SizedBox(
                  height: 25,
                ),
                Text("Favori Sporunuzu Seçiniz:"),
                Container(
                  margin: EdgeInsets.only(top: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                        color: Colors.grey[500],
                        style: BorderStyle.solid,
                        width: 1),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      icon: Icon(Icons.sports_basketball_outlined),
                      items: sporlar.map((oankiSpor) {
                        return DropdownMenuItem<String>(
                          child: Text(
                            oankiSpor,
                            textAlign: TextAlign.center,
                          ),
                          value: oankiSpor,
                        );
                      }).toList(),
                      onChanged: (secilen) {
                        setState(() {
                          _favoriSpor = secilen;
                        });
                      },
                      value: _favoriSpor,
                    ),
                  ),
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
                    label: _yas.toInt().toString(),
                    inactiveColor: Colors.grey,
                    value: _yas,
                    onChanged: (secilen) {
                      setState(() {
                        _yas = secilen;
                        debugPrint("Girilen yaş değeri: $_yas");
                      });
                    }),
                SizedBox(
                  height: 25,
                ),
                RaisedButton.icon(
                  onPressed: () {
                    _girisBilgileriniOnayla();
                  },
                  icon: Icon(
                    Icons.save,
                    color: Colors.white,
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

  void _girisBilgileriniOnayla() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      MaterialPageRoute(builder: (context) => MyHomePage());

      debugPrint(
          "Girilen adsoyad: $_adSoyad\n spor: $_favoriSpor\n yaş: $_yas ");
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
}
