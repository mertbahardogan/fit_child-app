import 'package:cocuklar_icin_spor_app/admob/admob_islemleri.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';

class BeslenmeSayfasi extends StatefulWidget {
  @override
  _BeslenmeSayfasiState createState() => _BeslenmeSayfasiState();
}

class _BeslenmeSayfasiState extends State<BeslenmeSayfasi> {
  final controller = PageController(initialPage: 0);

  InterstitialAd myInterstitialAd;

  @override
  void initState() {
    super.initState();
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
    double en = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: PageView(
          controller: controller,
          children: [
            Container(
              color: Colors.blue.shade600,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/benefits/egg.png",
                      width: en / 2,
                    ),
                    Text(
                      "Yumurta",
                      style: TextStyle(
                          color: Colors.yellowAccent, fontSize: en / 14),
                    ),
                    Padding(
                      padding: EdgeInsets.all(en / 15),
                      child: Text(
                        "Bağışıklık sistemini güçlendirir. "
                        "Yüksek miktarda protein içerdiğinden kas ve kemik gelişimine çok faydalıdır. "
                        "Günde bir tane yumurta tüketmeniz önerilir. ",
                        style:
                            TextStyle(fontSize: en / 25, color: Colors.white),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Sola Kaydır",
                            style: TextStyle(
                                fontSize: en / 32, color: Colors.grey)),
                        Icon(
                          Icons.arrow_forward_rounded,
                          size: en / 19,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ]),
            ),
            Container(
              color: Colors.yellowAccent.shade700,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/benefits/water.png",
                      width: en / 2,
                    ),
                    Text(
                      "Su Tüketimi",
                      style: TextStyle(
                          color: Colors.blueGrey.shade800, fontSize: en / 14),
                    ),
                    Padding(
                      padding: EdgeInsets.all(en / 15),
                      child: Text(
                        "Sağlıklı bir yaşam için yeteri kadar su içilmelidir. "
                        "Günlük olarak içilmesi önerilen su miktarı; 1-3 yaş arası çocuklar için 1 litre, 4-8 yaş arası için 1.2 litre, 9 yaş ve üzeri çocuklar için 1.5 litre ve yetişkinler için ise 2-2.5 litredir.",
                        style: TextStyle(
                            fontSize: en / 25, color: Colors.blue.shade800),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: en / 19,
                      color: Colors.grey,
                    ),
                  ]),
            ),
            Container(
              color: Colors.greenAccent.shade400,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/benefits/vegetables.png",
                      width: en / 2,
                    ),
                    Text(
                      "Sebze ve Meyveler",
                      style: TextStyle(color: Colors.brown, fontSize: en / 14),
                    ),
                    Padding(
                      padding: EdgeInsets.all(en / 15),
                      child: Text(
                        "Sebze ve meyve, büyüme ve gelişmeye yardımcı olur. "
                        "Sağlığımız için bir çok yararları bulunmaktadır. Günde en az 5 porsiyon sebze ve meyve tüketmelidir.",
                        style:
                            TextStyle(fontSize: en / 25, color: Colors.purple),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: en / 19,
                      color: Colors.white,
                    ),
                  ]),
            ),
            Container(
              color: Colors.redAccent,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/benefits/milk.png",
                      width: en / 2,
                    ),
                    Text(
                      "Süt ve Süt Ürünleri",
                      style: TextStyle(color: Colors.white, fontSize: en / 14),
                    ),
                    Padding(
                      padding: EdgeInsets.all(en / 15),
                      child: Text(
                        "Büyümeyi ve gelişmeyi sağlayan süt ve süt ürünleri, vücuda güç verir ve kemikleri sağlamlaştırır. "
                        "Günlük olarak içilmesi gereken süt miktarı: 2-3 yaş arası çocuklar için 2 bardak, 4-8 yaş arası çocuklar için 2,5 bardak, 9 ve üzeri yaş çocuklar için 3 bardaktır.",
                        style: TextStyle(
                            fontSize: en / 25, color: Colors.blueGrey.shade800),
                      ),
                    ),
                    Icon(
                      Icons.lens,
                      size: en / 36,
                      color: Colors.grey.shade200,
                    ),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
