import 'package:cocuklar_icin_spor_app/models/oneri.dart';
import 'package:cocuklar_icin_spor_app/utils/others.dart';

//Others veri kaynağı, Oneri model sınıfı.
//Burda verileri bir listeye aktarıyoruz. Aktardığımız liste modelimizin propertysi.
List<Oneri> oneriVerileriHazirla() {
  List<Oneri> oneriler = [];

  for (int i = 0; i < 7; i++) {
    String resim = Others.OTHERS_DOSYA_ADLARI[i] + "${i + 1}.png";

    Oneri eklenecekOneri = Oneri(
        Others.OTHERS_ADLARI[i],
        Others.OTHERS_DOSYA_ADLARI[i],
        Others.OTHERS_FAYDALARI[i],
        resim,
        Others.OTHERS_CALISAN_BOLGELER[i],
        Others.OTHERS_TAVSIYE[i]);
    oneriler.add(eklenecekOneri);
  }
  return oneriler;
}
