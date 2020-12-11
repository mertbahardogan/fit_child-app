import 'package:cocuklar_icin_spor_app/ui/giris_sayfasi.dart';
import 'package:flutter/material.dart';

class AnaSayfa extends StatefulWidget {
  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      scrollDirection: Axis.vertical,
      slivers: [
        SliverAppBar(
          title: Text(
            "Çocuklar için Spor App",
            style: TextStyle(fontSize: 23,color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.grey,
          pinned: true,
          primary: true,
          expandedHeight: 65,
        ),
        SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 10),
          delegate: SliverChildListDelegate(sabitCardElemanlari()),
        )
      ],
    );
  }

  List<Widget> sabitCardElemanlari() {
    return [
      Card(
        elevation: 10,
        // clipBehavior: Clip.antiAlias,
        child: ListTile(
          leading: Icon(Icons.star),
          title: Text("Bilgilerini Oluştur"),
          subtitle: Text("Subtitle text 1"),
          onTap: () {
            Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GirisSayfasi()));
          },
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.blueGrey, width: 2),
              borderRadius: BorderRadius.circular(4)),
        ),
      ),
      Card(
        elevation: 10,
        // clipBehavior: Clip.antiAlias,
        child: ListTile(
          leading: Icon(Icons.star),
          title: Text("Card title 2"),
          subtitle: Text("Subtitle text 2"),
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.red, width: 2),
              borderRadius: BorderRadius.circular(4)),
        ),
      )
    ];
  }
}
