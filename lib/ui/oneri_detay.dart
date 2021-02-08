import 'package:cocuklar_icin_spor_app/methods/oneri_verileri_hazirla.dart';
import 'package:cocuklar_icin_spor_app/models/oneri.dart';
import 'package:flutter/material.dart';

class OneriDetay extends StatefulWidget {
  int gelenIndex;
  OneriDetay(this.gelenIndex);
  @override
  _OneriDetayState createState() => _OneriDetayState();
}

class _OneriDetayState extends State<OneriDetay> {
  static List<Oneri> secilenOneri;

  @override
  void initState() {
    secilenOneri = oneriVerileriHazirla();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double boy = MediaQuery.of(context).size.height;
    double en = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            secilenOneri[widget.gelenIndex].oneriAd,
          ),
          centerTitle: true,
          backgroundColor: Colors.blue,
          elevation: 0,
        ),
        backgroundColor: Colors.blue,
        body: Stack(
          children: [
            Positioned(
              height: boy * 0.75,
              width: en / 1.2,
              left: en / 12,
              top: boy * 0.06,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 20, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: boy / 10),
                      Text(
                        "Faydaları",
                        style: TextStyle(
                            color: Colors.deepOrange.shade800,
                            fontWeight: FontWeight.bold,
                            fontSize: en / 20),
                      ),
                      SizedBox(
                        height: boy / 70,
                      ),
                      Text(
                        secilenOneri[widget.gelenIndex].oneriFayda,
                        style: TextStyle(
                            color: Colors.blueGrey.shade900, fontSize: en / 26),
                      ),
                      SizedBox(height: boy / 16),
                      Text(
                        "Öneriler",
                        style: TextStyle(
                            color: Colors.deepOrange.shade800,
                            fontWeight: FontWeight.bold,
                            fontSize: en / 20),
                      ),
                      SizedBox(
                        height: boy / 70,
                      ),
                      Text(
                        secilenOneri[widget.gelenIndex].oneriTavsiye,
                        style: TextStyle(
                            color: Colors.blueGrey.shade900, fontSize: en / 26),
                      ),
                      SizedBox(height: boy / 16),
                      Text(
                        "Çalıştırdığı Bölgeler",
                        style: TextStyle(
                            color: Colors.deepOrange.shade800,
                            fontWeight: FontWeight.bold,
                            fontSize: en / 20),
                      ),
                      SizedBox(
                        height: boy / 70,
                      ),
                      Text(
                        secilenOneri[widget.gelenIndex].oneriBolge,
                        style: TextStyle(
                          color: Colors.blueGrey.shade900,
                          fontSize: en / 26,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Hero(
                tag: "assets/images/others/" +
                    secilenOneri[widget.gelenIndex].oneriResim,
                child: Container(
                  width: en / 3,
                  height: boy / 8,
                  child: Image.asset(
                    "assets/images/others/" +
                        secilenOneri[widget.gelenIndex].oneriResim,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            )
          ],
        ));
  }
}

/*       CustomScrollView(
        slivers: [
          SliverAppBar(
            primary: true,
            pinned: true,
            title: Text(secilenOneri[widget.gelenIndex].oneriAd),
            centerTitle: true,
            backgroundColor: Colors.blue.shade300,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                "assets/images/others/" +
                    secilenOneri[widget.gelenIndex].oneriResim,
                fit: BoxFit.scaleDown,
                cacheHeight: 130,
                alignment: Alignment.bottomCenter,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(6)),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        "Egzersiz Faydaları",
                        style: TextStyle(color: Colors.deepOrange.shade800),
                      ),
                    ),
                    Text(secilenOneri[widget.gelenIndex].oneriFayda),
                  ],
                ),
              ),
            ),
          ),
        ],
      ), */
