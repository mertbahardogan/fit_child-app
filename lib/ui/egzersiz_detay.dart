import 'package:cocuklar_icin_spor_app/models/egzersiz.dart';
import 'package:cocuklar_icin_spor_app/ui/egzersiz_sayfasi.dart';
import 'package:flutter/material.dart';

class EgzersizDetay extends StatefulWidget {
  int gelenIndex;
  EgzersizDetay(this.gelenIndex);
  @override
  _EgzersizDetayState createState() => _EgzersizDetayState();
}

class _EgzersizDetayState extends State<EgzersizDetay> {
  Egzersiz secilenEgzersiz;
  IconData iconMod = Icons.favorite_border;
  @override
  void initState() {
    secilenEgzersiz = EgzersizSayfasi.tumEgzersizler[widget.gelenIndex];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      body: CustomScrollView(slivers: [
        SliverAppBar(
          primary: true,
          pinned: true,
          title: Text(secilenEgzersiz.egzersizAdi),
          centerTitle: true,
          backgroundColor: Colors.deepOrange[200 * (widget.gelenIndex % 3)],
          expandedHeight: 200,
          actions: [
            IconButton(
              icon: Icon(
                iconMod,
                size: 26,
              ),
              onPressed: () {
                setState(() {
                  if (iconMod == Icons.favorite_border) {
                    iconMod = Icons.favorite;
                  } else {
                    iconMod = Icons.favorite_border;
                  }
                });
              },
            )
          ],
          flexibleSpace: FlexibleSpaceBar(
            background: Image.asset(
              "assets/images/exercises/" + secilenEgzersiz.egzersizResim,
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
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Icon(
                          Icons.fitness_center,
                          size: 27,
                          color: Colors.deepOrange.shade800,
                        ),
                      ),
                      Text(
                        secilenEgzersiz.egzersizBolge +
                            "  bölgelerini çalıştırır.",
                        style: TextStyle(fontSize: 18),
                      ),
                      Divider(
                        height: 20,
                        thickness: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Icon(
                          Icons.repeat,
                          size: 27,
                          color: Colors.deepOrange.shade800,
                        ),
                      ),
                      Text(secilenEgzersiz.egzersizOneri,
                          style: TextStyle(fontSize: 18)),
                      Divider(
                        height: 20,
                        thickness: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom:10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Icon(
                                Icons.play_arrow,
                                size: 27,
                                color: Colors.deepOrange.shade800,
                              ),
                            ),
                            Text(
                              "Nasıl Yapabilirim?",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 20,color: Colors.deepOrange.shade800,),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        secilenEgzersiz.egzersizDetay,
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 18),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
