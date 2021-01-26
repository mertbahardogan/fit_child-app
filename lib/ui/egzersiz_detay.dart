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
          // backgroundColor:
          //     widget.gelenIndex % 2 == 0 ? Colors.grey[500] : Colors.brown[100],
          backgroundColor: Colors.blueGrey.shade900,
          expandedHeight: 200,
          actions: [
            IconButton(
              icon: Icon(
                iconMod,
                size: 26,
              ),
              onPressed: () {
                print(widget.gelenIndex);
                print(secilenEgzersiz.egzersizAdi);
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
                      Icon(Icons.fitness_center),
                      Text(
                        secilenEgzersiz.egzersizBolge +
                            "  bölgelerini çalıştırır.",
                        style: TextStyle(fontSize: 23),
                      ),
                      Divider(
                        height: 20,
                        thickness: 1,
                      ),
                      Icon(Icons.repeat),
                      Text(secilenEgzersiz.egzersizOneri,
                          style: TextStyle(fontSize: 23)),
                      Divider(
                        height: 20,
                        thickness: 1,
                      ),
                      Icon(Icons.question_answer),
                      Text(
                        "Nasıl Yapabilirim?",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20),
                      ),
                      Text(
                        secilenEgzersiz.egzersizDetay,
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 20),
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
