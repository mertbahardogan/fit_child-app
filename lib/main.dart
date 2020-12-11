import 'package:cocuklar_icin_spor_app/ui/ana_sayfa.dart';
import 'package:cocuklar_icin_spor_app/ui/bilgiler_sayfasi.dart';
import 'package:cocuklar_icin_spor_app/ui/egzersiz_detay.dart';
import 'package:cocuklar_icin_spor_app/ui/egzersiz_sayfasi.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "Quicksand",
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Splash(),
      onGenerateRoute: (RouteSettings settings) {
        List<String> pathElemanlari = settings.name.split("/");
        //egzersizDetay/$index
        if (pathElemanlari[1] == "egzersizDetay") {
          return MaterialPageRoute(
              builder: (context) =>
                  EgzersizDetay(int.parse(pathElemanlari[2])));
        }
        else return null;
      },
    );
  }
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 4,
      navigateAfterSeconds: MyHomePage(),
      title: new Text(
        'Çocuklar için Spor App',
        textScaleFactor: 2,
      ),
      image: Image.asset("assets/images/fitness.png"),
      loadingText: Text("Hoşgeldiniz!"),
      photoSize: 100.0,
      loaderColor: Colors.red,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int secilenBarItem = 1;
  List<Widget> tumSayfalar;
  AnaSayfa sayfaAna;
  EgzersizSayfasi sayfaEgzersiz;
  BilgilerSayfasi sayfaBilgi;

  @override
  void initState() {
    super.initState();
    sayfaAna = AnaSayfa();
    sayfaEgzersiz = EgzersizSayfasi();
    sayfaBilgi = BilgilerSayfasi();
    tumSayfalar = [sayfaEgzersiz, sayfaAna, sayfaBilgi];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavMenu(),
      body: tumSayfalar[secilenBarItem],
    );
  }

  Widget bottomNavMenu() {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.fitness_center),
          label: "Egzersizler",
          backgroundColor: Colors.grey,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Ana Sayfa",
          backgroundColor: Colors.red,
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.psychology),
            label: "Günlük Bilgiler",
            backgroundColor: Colors.grey),
      ],
      type: BottomNavigationBarType.shifting,
      currentIndex: secilenBarItem,
      onTap: (secilenIndex) {
        setState(() {
          secilenBarItem = secilenIndex;
        });
      },
    );
  }
}
