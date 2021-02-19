import 'package:cocuklar_icin_spor_app/ui/ana_sayfa.dart';
import 'package:cocuklar_icin_spor_app/ui/oneri_detay.dart';
import 'package:cocuklar_icin_spor_app/ui/program_detay.dart';
import 'package:cocuklar_icin_spor_app/ui/program_sayfasi.dart';
import 'package:cocuklar_icin_spor_app/ui/egzersiz_detay.dart';
import 'package:cocuklar_icin_spor_app/ui/egzersiz_sayfasi.dart';
import 'package:cocuklar_icin_spor_app/ui/giris_sayfasi.dart';
import 'package:cocuklar_icin_spor_app/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:splashscreen/splashscreen.dart';
import 'models/kisisel.dart';

/// OneSignal Initialization
void initOneSignal(oneSignalAppId) async {
  // var settings = {
  //   OSiOSSettings.autoPrompt: true,
  //   OSiOSSettings.inAppLaunchUrl: true
  // };
  await OneSignal.shared.init(oneSignalAppId); //, iOSSettings: settings
  OneSignal.shared
      .setInFocusDisplayType(OSNotificationDisplayType.notification);
// will be called whenever a notification is received
  OneSignal.shared
      .setNotificationReceivedHandler((OSNotification notification) {
    print('Received: ' + notification?.payload?.body ?? '');
  });
// will be called whenever a notification is opened/button pressed.
  OneSignal.shared
      .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
    print('Opened: ' + result.notification?.payload?.body ?? '');
  });
}

// Future<String> initConnectionControl() async {
//   String deger;
//   var connectivityResult = await (Connectivity().checkConnectivity());
//   if (connectivityResult == ConnectivityResult.mobile) {
//     print("I am connected to a mobile network.");
//     deger = "aktif";
//   } else if (connectivityResult == ConnectivityResult.wifi) {
//     print("I am connected to a wifi network.");
//     deger = "aktif";
//   } else if (connectivityResult == ConnectivityResult.none) {
//     print("HAVE NOT network.");
//     deger = "pasif";
//   }
//   return deger;
// }

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fit Child App',
      theme: ThemeData(
        fontFamily: "Poppins",
        visualDensity: VisualDensity.adaptivePlatformDensity,
        accentColor: Colors.black54,
        // primaryColor: Colors.blueGrey.shade900,
        primaryColor: Colors.blueAccent.shade100,
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
        if (pathElemanlari[1] == "programDetay") {
          return MaterialPageRoute(
              builder: (context) => ProgramDetay(int.parse(pathElemanlari[2])));
        }
        if (pathElemanlari[1] == "oneriDetay") {
          return MaterialPageRoute(
              builder: (context) => OneriDetay(int.parse(pathElemanlari[2])));
        } else
          return null;
      },
    );
  }
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  DatabaseHelper _databaseHelper;
  List<Kisisel> tumKisiselVerilerListesi;
  String connection;

  @override
  void initState() {
    super.initState();
    tumKisiselVerilerListesi = List<Kisisel>();
    _databaseHelper = DatabaseHelper();
    initOneSignal("183aa663-1626-4f22-83ac-07ebeeecf2a6");
    // connection = initConnectionControl().toString();
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        seconds: 2,
        navigateAfterSeconds: FutureBuilder(
          future: _databaseHelper.kisiselListesiniGetir(),
          builder: (context, AsyncSnapshot<List<Kisisel>> snapShot) {
            if (snapShot.connectionState == ConnectionState.done) {
              tumKisiselVerilerListesi = snapShot.data;
              return tumKisiselVerilerListesi.length == 0
                  ? GirisSayfasi()
                  : MyHomePage();
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
        title: Text('Fit Child',
            textAlign: TextAlign.end,
            textScaleFactor: 3,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontFamily: "Indie",
              fontSize: MediaQuery.of(context).size.width / 22,
              color: Colors.blueGrey.shade900,
            )),
        // image: Image.asset("assets/images/fitness.png"),
        // loadingText: Text(
        //   // tumKisiselVerilerListesi.length == 0? "Hoşgeldiniz": "Hoşgeldiniz " + tumKisiselVerilerListesi[0].adSoyad,style: TextStyle(fontWeight: FontWeight.bold),
        // ),
        loadingText: Text(
          "1.0.0",
          style: TextStyle(color: Colors.grey),
        ),
        // photoSize: 50.0,
        useLoader: false,
        backgroundColor: Colors.white);
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
  ProgramSayfasi sayfaProgram;

  @override
  void initState() {
    super.initState();
    sayfaAna = AnaSayfa();
    sayfaEgzersiz = EgzersizSayfasi();
    sayfaProgram = ProgramSayfasi();
    tumSayfalar = [sayfaEgzersiz, sayfaAna, sayfaProgram];
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
      elevation: 15,
      backgroundColor: Colors.white,
      showUnselectedLabels: true,
      iconSize: 24,
      selectedItemColor: Colors.blueGrey.shade900,
      selectedFontSize: 13,
      unselectedFontSize: 13,
      unselectedItemColor: Colors.grey,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.fitness_center,
          ),
          label: "Egzersizler",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
          ),
          label: "Ana Sayfa",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.date_range,
          ),
          label: "Program",
        ),
      ],
      type: BottomNavigationBarType.fixed,
      currentIndex: secilenBarItem,
      onTap: (secilenIndex) {
        setState(() {
          secilenBarItem = secilenIndex;
        });
      },
    );
  }
}
