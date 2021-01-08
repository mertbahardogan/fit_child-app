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

  String _kisiselTablo = "kisisel";
  String _columnID = "id";
  String _columnAdSoyad = "adSoyad";
  String _columnYas = "yas";

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
  Future<List<Kisisel>> kisiselListesiniGetir() async{
    var kisiselMapListesi=await tumKayitlar();
    var kisiselListesi=List<Kisisel>();
    for(Map map in kisiselMapListesi){
      kisiselListesi.add(Kisisel.dbdenOkudugunDegeriObjeyeDonustur(map));
    }
    return kisiselListesi;
  }

  Future<int> hareketEkle(Hareket hareket) async {
    var db = await _getDatabase();
    var sonuc = await db.insert(_hareketTablo, hareket.forWritingDbConvertMap(),
        nullColumnHack: "$_columnHareketID");
    print("Kayıt HAREKET DB ye Eklendi: " + sonuc.toString());
    return sonuc;
  }

  Future<List<Map<String, dynamic>>> tumHareketler() async {
    var db = await _getDatabase();
    var sonuc =
        await db.query(_hareketTablo, orderBy: "$_columnHareketID DESC");
    return sonuc;
  }

  Future<int> hareketGuncelle(Hareket hareket) async {
    var db = await _getDatabase();
    var sonuc = await db.update(_hareketTablo, hareket.forWritingDbConvertMap(),
        where: "$_columnHareketID=?", whereArgs: [hareket.hareketID]);
    return sonuc;
  }

  Future<int> hareketSil(int id) async {
    var db = await _getDatabase();
    var sonuc = await db
        .delete(_hareketTablo, where: "$_columnHareketID=?", whereArgs: [id]);
    return sonuc;
  }

  Future<int> tumHareketTablosunuSil() async {
    var db = await _getDatabase();
    var sonuc = await db.delete(_hareketTablo);
    return sonuc;
  }
}
