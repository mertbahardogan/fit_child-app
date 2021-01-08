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

  @override
  Widget build(BuildContext context) {
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
                color: Colors.red.shade800,
                elevation: 10,
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _oraniHesapla(int.parse(_controllerBoy.text),
                        int.parse(_controllerKilo.text));
                  }
                },
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      bmi != null ? "Vücut Kitle Endeksiniz: $bmi \n" : "",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      stringOneri != null ? "$stringOneri" : "",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
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
    }
    else{
      return "Lütfen boş değer girmeyin.";
    }
  }
}

