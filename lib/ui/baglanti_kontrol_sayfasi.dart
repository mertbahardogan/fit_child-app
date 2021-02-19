import 'package:flutter/material.dart';

class HataSayfasi extends StatefulWidget {
  @override
  _HataSayfasiState createState() => _HataSayfasiState();
}

class _HataSayfasiState extends State<HataSayfasi> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [Text("Lütfen İnternet Bağlantınızı Kontrol Edin!")],
      ),
    );
  }
}
