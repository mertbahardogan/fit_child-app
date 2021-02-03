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
    return Scaffold(
      primary: true,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            primary: true,
            pinned: true,
            title: Text(secilenOneri[widget.gelenIndex].oneriAd),
            centerTitle: true,
            backgroundColor: Colors.red,
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
      ),
    );
  }
}
