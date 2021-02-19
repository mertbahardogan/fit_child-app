import 'package:cocuklar_icin_spor_app/admob/admob_islemleri.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';

class VucutKitleSayfasi extends StatefulWidget {
  @override
  _VucutKitleSayfasiState createState() => _VucutKitleSayfasiState();
}

class _VucutKitleSayfasiState extends State<VucutKitleSayfasi> {
  var _formKey = GlobalKey<FormState>();
  var _controllerBoy = TextEditingController();
  var _controllerKilo = TextEditingController();
  double bmi;
  String stringOneri;
  BannerAd myBannerAd;

  @override
  void initState() {
    super.initState();
    AdmobIslemleri.admobInitialize();
    myBannerAd = AdmobIslemleri.buildBannerAd();
  }

  @override
  void dispose() {
     myBannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    myBannerAd
      ..load()
      ..show();
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text(
          "Vücut Kitle Endeksi",
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
                    child: TextFormField(
                      controller: _controllerBoy,
                      cursorColor: Colors.red,
                      autofocus: false,
                      validator: _olcuKontrol,
                      decoration: InputDecoration(
                        labelText: "Boy",
                        hintText: "Boyunuz (cm)",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 17, 10, 0),
                    child: TextFormField(
                      autofocus: false,
                      cursorColor: Colors.red,
                      controller: _controllerKilo,
                      validator: _olcuKontrol,
                      decoration: InputDecoration(
                        labelText: "Kilo",
                        hintText: "Kilonuz (kg)",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: RaisedButton(
                child: Text(
                  "Hesapla",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blueGrey.shade900,
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _oraniHesapla(int.parse(_controllerBoy.text),
                        int.parse(_controllerKilo.text));
                    bmiGoster(context, bmi, stringOneri);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _oraniHesapla(int boy, int kilo) {
    var sonuc = ((kilo / (boy * boy)) * 10000).toStringAsFixed(1);

    setState(() {
      bmi = double.parse(sonuc);
      if (bmi <= 18.5) {
        stringOneri = "Kilo almanız öneriliyor.";
      }
      if (bmi > 18.5 && bmi <= 25) {
        stringOneri = "Kilonuzu korumanız öneriliyor.";
      }
      if (bmi > 25 && bmi <= 30) {
        stringOneri = "Spora başlamanız öneriliyor.";
      }
      if (bmi > 30) {
        stringOneri =
            "Spora başlamanız gerekiyor.\nDiyet listesi uygulayabilirsiniz.";
      }
      if (bmi >= 50) {
        stringOneri = "Lütfen doğru değerler giriniz.";
        bmi = 0;
      }
    });
  }

  String _olcuKontrol(String value) {
    RegExp regex = RegExp("^-?\\d*(\\.\\d+)?\$");
    if (value != "") {
      if (!regex.hasMatch(value)) {
        return "Lütfen geçerli bir sayı değeri giriniz. Boşluk bırakmayın.";
      } else
        return null;
    } else {
      return "Lütfen boş değer girmeyin.";
    }
  }

  bmiGoster(BuildContext ctx, double bmi, String stringOneri) {
    showDialog(
        context: ctx,
        barrierDismissible: false,
        builder: (ctx) {
          return AlertDialog(
            title: Center(
              child: Text(
                "Vücut Kitle Endeksiniz:",
                style: TextStyle(color: Colors.yellow.shade800),
              ),
            ),
            backgroundColor: Colors.blueGrey.shade900,
            content: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    Text(
                      "$bmi\n",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      "$stringOneri",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              FlatButton(
                  child: Text(
                    "Kapat",
                    style: TextStyle(color: Colors.redAccent, fontSize: 12),
                  ),
                  onPressed: () => Navigator.of(ctx).pop()),
            ],
          );
        });
  }
}
