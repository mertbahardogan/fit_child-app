import 'dart:io';
import 'dart:async';
import 'package:cocuklar_icin_spor_app/models/hareket.dart';
import 'package:cocuklar_icin_spor_app/models/kisisel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  //
  // static Database _databaseHareket;

  String _kisiselTablo = "kisisel";
  String _columnID = "id";
  String _columnAdSoyad = "adSoyad";
  String _columnYas = "yas";

  //
  String _hareketTablo = "hareket";
  String _columnHareketID = "hareketID";
  String _columnHareketAd = "hareketAd";
  String _columnHareketTarih = "hareketTarih";
  String _columnHareketTekrarSayisi = "hareketTekrarSayisi";

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._internal();
      print("DBHelper null idi, oluşturuldu.");
      return _databaseHelper;
    } else {
      print("DBHelper null değildi, var olan kullanıldı.");
      return _databaseHelper;
    }
  }
  DatabaseHelper._internal();

  Future<Database> _getDatabase() async {
    if (_database == null) {
      print("DB nulldi oluşturulacak.");
      _database = await _initializeDatabase();
      return _database;
    } else {
      print("DB null değildi var olan kullanılacak");
      return _database;
    }
  }

  _initializeDatabase() async {
    Directory klasor = await getApplicationDocumentsDirectory();
    //"C://users/emre/" üst bana bunun gibi bir yol verir

    String dbPath = join(klasor.path, "kisisel.db"); //iki yolu birleştiriyo
    print("DB Path: " + dbPath);

    //version şu an 1 ama eğer tabloda ekleme yaparsak onu değiştirmemiz lazım güncellemesi için.
    var kisiselDB = openDatabase(dbPath, version: 1, onCreate: _createDB);
    return kisiselDB;
  }

  Future<void> _createDB(Database db, int version) async {
    print("CREATE DB METOT ÇALIŞTI TABLO OLUŞTURULACAK.");
    await db.execute(
        "CREATE TABLE $_kisiselTablo ($_columnID INTEGER PRIMARY KEY AUTOINCREMENT,$_columnAdSoyad TEXT, $_columnYas INTEGER )");

    await db.execute(
        "CREATE TABLE $_hareketTablo($_columnHareketID INTEGER PRIMARY KEY AUTOINCREMENT,$_columnHareketAd TEXT,$_columnHareketTarih TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,$_columnHareketTekrarSayisi TEXT)");
  }

  // //
  // Future<Database> _getHareketDatabase() async {
  //   if (_databaseHareket == null) {
  //     print("DB HAREKET NULL İDİ Oluşturulacak!!");
  //     _databaseHareket = await _initializeHareketDatabase();
  //     return _databaseHareket;
  //   } else {
  //     print("DB HAREKET NULL DEĞİL İDİ VAR OLAN KULLANILACAK");
  //     return _databaseHareket;
  //   }
  // }

  // //
  // _initializeHareketDatabase() async {
  //   Directory klasor = await getApplicationDocumentsDirectory();
  //   String dbHareketPath = join(klasor.path, "hareket.db");
  //   print("DB Path: " + dbHareketPath);
  //   var hareketDB =
  //       openDatabase(dbHareketPath, version: 1, onCreate: _createHareketDB);

  //   return hareketDB;
  // }

  // //
  // FutureOr<void> _createHareketDB(Database db, int version) async {
  //   print("CREATE YENİ DB METOT ÇALIŞTI TABLO OLUŞTURULACAK!!");
  //   await db.execute(
  //       "CREATE TABLE $_hareketTablo($_columnHareketID INTEGER PRIMARY KEY AUTOINCREMENT,$_columnHareketAd TEXT,$_columnHareketTarih TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,$_columnHareketTekrarSayisi TEXT)");
  // }

  Future<int> kayitEkle(Kisisel kisisel) async {
    var db = await _getDatabase();
    var sonuc = await db.insert(
        _kisiselTablo, kisisel.dbyeYazmakIcinMapeDonustur(),
        nullColumnHack: "$_columnID");
    print("Kayıt DB ye Eklendi: " + sonuc.toString());
    return sonuc;
  }

  Future<List<Map<String, dynamic>>> tumKayitlar() async {
    var db = await _getDatabase();
    var sonuc = await db.query(_kisiselTablo, orderBy: "$_columnID DESC");
    return sonuc;
  }

  Future<int> kayitGuncelle(Kisisel kisisel) async {
    var db = await _getDatabase();
    var sonuc = await db.update(
        _kisiselTablo, kisisel.dbyeYazmakIcinMapeDonustur(),
        where: "$_columnID=?", whereArgs: [kisisel.id]);
    return sonuc;
  }

  //
  Future<int> hareketEkle(Hareket hareket) async {
    var db = await _getDatabase();
    var sonuc = await db.insert(_hareketTablo, hareket.forWritingDbConvertMap(),
        nullColumnHack: "$_columnHareketID");
    print("Kayıt HAREKET DB ye Eklendi: " + sonuc.toString());
    return sonuc;
  }

  //
  Future<List<Map<String, dynamic>>> tumHareketler() async {
    var db = await _getDatabase();
    var sonuc =
        await db.query(_hareketTablo, orderBy: "$_columnHareketID DESC");
    return sonuc;
  }
}
