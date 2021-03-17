import 'package:cocuklar_icin_spor_app/admob/admob_islemleri.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';

class VucutKitleSayfasi extends StatefulWidget {
  @override
  _VucutKitleSayfasiState createState() => _VucutKitleSayfasiState();
}

class _VucutKitleSayfasiState extends State<VucutKitleSayfasi> {
  var _formKey = GlobalKey<FormState>();
  var _controllerTall = TextEditingController();
  var _controllerWeight = TextEditingController();
  double bmi;
  String myAdvice;
  BannerAd myBannerAd;

  @override
  void initState() {
    super.initState();
    AdmobIslemleri.admobInitialize();
    myBannerAd = AdmobIslemleri.buildBannerAd();
  }

  @override
  void dispose() {
    _controllerTall.dispose();
    _controllerWeight.dispose();

    if (myBannerAd != null) myBannerAd.dispose();
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
          style: Theme.of(context).appBarTheme.textTheme.headline1,
        ),
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
                      controller: _controllerTall,
                      cursorColor: Colors.red,
                      autofocus: false,
                      validator: _checkValues,
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
                      controller: _controllerWeight,
                      validator: _checkValues,
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
                    _oraniHesapla(int.parse(_controllerTall.text),
                        int.parse(_controllerWeight.text));
                    bmiGoster(context, bmi, myAdvice);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _oraniHesapla(int tall, int weight) {
    var sonuc = ((weight / (tall * tall)) * 10000).toStringAsFixed(1);

    setState(() {
      bmi = double.parse(sonuc);
      if (bmi <= 18.5) {
        myAdvice = "Kilo almanız öneriliyor.";
      }
      if (bmi > 18.5 && bmi <= 25) {
        myAdvice = "Kilonuzu korumanız öneriliyor.";
      }
      if (bmi > 25 && bmi <= 30) {
        myAdvice = "Spora başlamanız öneriliyor.";
      }
      if (bmi > 30) {
        myAdvice =
            "Spora başlamanız gerekiyor.\nDiyet listesi uygulayabilirsiniz.";
      }
      if (bmi >= 50) {
        myAdvice = "Lütfen doğru değerler giriniz.";
        bmi = 0;
      }
    });
  }

  String _checkValues(String value) {
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

  bmiGoster(BuildContext ctx, double bmi, String myAdvice) {
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
                      "$myAdvice",
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
