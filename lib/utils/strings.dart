class Strings {
  static const List<String> EGZERSIZ_ADLARI = [
    "Isınma",
    "Isınma",
    "Isınma",
    "Isınma",

    "Şınav",
    "Mekik",
    "Plank",
    "Yan Plank",
    "Squad",

    "Direnç Bandı", //10
    "Pilates 1",
    "Omuz",

    "İnek Pozu", //12
    "Sandalye Pozu",
    "Kartal Pozu", //14
    "Köprü Pozu",
    "Kedi Pozu", //16
    "Eğilme 1",
    "Eğilme 2",
    "Savaşçı Pozu", //19
    "Geniş Üçgen",
    "Yarım Balık",
    "Lotus Pozu",
    "Aşağı Bakma", //23
    "Yukarı Bakma",
    "Yürüyüş",
    "Dinlenme"
  ];

  static const List<String> EGZERSIZ_DOSYA_ADLARI = [
    "aisinma",
    "bisinma",
    "cisinma",
    "disinma",
    "sinav",
    "mekik",
    "plank",
    "yanplank",
    "squad",
    "direnc",
    "pilates",
    "omuz",
    "inek",
    "sandalye",
    "kartal",
    "kopru", //15
    "kedi",
    "aoneeg",
    "oneeg",
    "savas",
    "genisucgen", //22
    "yarimbalik",
    "lotus",
    "asagikopek",
    "yukarikopek",
    "yürüyüs",
    "dinlenme"
  ];

  static const List<String> EGZERSIZ_CALISAN_BOLGELER = [
    "Eklem ve kasları egzersizlere hazırlar, esneklik sağlar.",
    "Eklem ve kasları egzersizlere hazırlar, esneklik sağlar.",
    "Eklem ve kasları egzersizlere hazırlar, esneklik sağlar.",
    "Eklem ve kasları egzersizlere hazırlar, esneklik sağlar.",
    "Göğüs, Kol, Sırt ve Omuz kaslarının çalışmasını sağlar.",
    "Karın kaslarının çalışmasını sağlar.",
    "Göğüs, Kol, Karın, Omuz ve Sırt kaslarının çalışmasını sağlar.",
    "Yan Karın, Kol ve Omuz kaslarının çalışmasını sağlar.",
    "Bacak ve Kalça kaslarının çalışmasını sağlar.",
    "Omuz, Sırt ve Arka Kol kaslarının çalışmasını sağlar.",
    "Kol, Bel, Karın ve Sırt kaslarının esnemesini sağlar.",
    "Omuz kaslarının çalışmasını sağlar.",
    "Rahatlama sağlar ve stresi azaltır. Postürü düzeltir.",
    "Bacak ve Kalça kaslarının çalışmasını sağlar. Vücuda esneklik ve rahatlık kazandırır.",
    "Sırt kası başta olmak üzere tüm vücut bölgelerine esneklik ve rahatlık sağlar.",
    "Vücudun ön tarafındaki kasları esnetir, arka tarafındaki kasları ise kasarak vücudu rahatlatır.",
    "Boyun ve Sırt kaslarını esnetir, postürü (duruşu) düzeltir.",
    "Sırt, Kalça ve Bacak bölgelerinin esnemesini sağlar. Stresi azaltır.",
    "Sırt ve Bacak bölgelerinin esnemesini sağlar. Stresi azaltır.",
    "Kalça ve Bacak kaslarını esnetir ve güçlendirir. Enerjinizi artırır.",
    "Kalça, Bacak, Sırt ve Omuz kaslarını esnetir ve güçlendirir.",
    "Omuz, Kalça ve Boynu esnetir ve rahatlama sağlar. Stresi azaltır.",
    "Kalça, Diz ve Ayak bileklerini esnetir. Stresi azaltır ve rahatlık kazandırır. Postürü düzeltir.",
    "Omuz, Bacak ve Kol kaslarını esnetir ve çalıştırır.",
    "Rahatlama ve esneklik sağlar.", //Yukarı Bakma
    "Bacak kasınız başta olmak üzere tüm kaslarının çalışmasını sağlar. Stresi azaltır.", //yürüyüş
    "Tüm vücut dinlenme sırasında gelişir ve yenilenir."
  ];

  static const List<String> EGZERSIZ_NASIL_YAPILIR = [
    "\t1-Yere oturun, bacaklarınızı düz ve gergin duracak şekilde açın.\n\n"
        "\t2-İki elinizi de kullanarak ilk önce sağ, sonra sol ayak ucuna dokunmaya çalışın.\n\n"
        "\t3-Hareketi tekrarlayın.\n\n",
    "\t1-Ayakta postürünüz düz olacak şekilde durun. Sağ bacağınızı öne atın.\n\n"
        "\t2-Yavaşça öne attığınız bacağınızı büküp pozisyon alın. Diğer bacağınız bu sırada düz olmalıdır. Daha sonra iki elinizi dizinizin üzerinde (fotoğrafta olduğu gibi) tutmaya özen gösterin.\n\n"
        "\t3-Bir kaç saniye bekleyin. Başlangıç pozisyonuna dönüp hareketi diğer bacağınız için tekrarlayın.\n\n",
    "\t1-Ayakta postürünüz düz olacak şekilde durun. Ellerinizi başınızın üzerinde dirseklerinizi kırmadan birleştirin.\n\n"
        "\t2-Sağ bacağınızı yan tarafa doğru açın. Diğer bacağınız bu sırada düz olmalıdır. Dizinizi büküp yavaşça (fotoğrafta olduğu gibi) kendinizi esnetin.\n\n"
        "\t3-Bir kaç saniye bekleyin. Başlangıç pozisyonuna dönüp hareketi diğer bacağınız için tekrarlayın.\n\n",
    "\t1-Ayakta postürünüz düz olacak şekilde durun. Ayaklarınızı omuz hizasında açın.\n\n"
        "\t2-Yapacağınız egzersize göre ısınma hareketine başlayın. (Omuz, Kol veya Göğüs olabilir.)\n\n"
        "\t3-Isınma hareketi örneğin omuz kası için; yavaşça kollarınızı öne doğru çevirin. 10 tekrar sonra bunu arka tarafa doğru tekrarlayın.\n\n"
        "\t4-Isınma hareketi örneğin kol kası için; yavaşça bileklerinizi omzunuza doğru ağırlık kaldırır gibi getirin. 10 tekrar yapabilirsiniz.\n\n"
        "\t5-Isınma hareketi örneğin göğüs kası için; kollarınızı önünüzde omuz hizasında düz duracak şekilde tutun. Yavaşça yana doğru açın ve tekrar yavaşça eski pozisyona gönün. 10 tekrar yapılabilir.\n\n",
    "\t1-Yüzüstü yere uzanın.\n\n"
        "\t2-Ayaklarınızı birbirinden ayırmayın.\n\n"
        "\t3-Kollarınızı kullanarak kendinizi kaldırın.\n\n"
        "\t4-Elleriniz omuz mesafesinden biraz daha aralıklı olmalı.\n\n"
        "\t5-Karnınızı sıkı tutun ve bedenini geri iterken nefes verin.\n\n"
        "\t6-Duruşu bozmadan yapmaya özen gösterin.\n\n",

    "\t1-Sırt üstü yatın, dizleriniz bükülü ve ayak tabanlarınız yerde olsun. Dizleriniz kalça hizasında olmalı.\n\n"
        "\t2-Ellerinizi başınızın arkasında yerleştirin. (Başparmaklarınız kulaklarınızın arkasına gelecek şekilde.)\n\n"
        "\t3-Dirseklerini dışa doğru açık tutun, hafifçe içe dönük olsunlar. Çenenizi hafifçe yukarı kaldırın, göğüs ve çene arasında boşluk olsun.\n\n"
        "\t4-Karnınızı içeri çekin. Baş, boyun ve kürek kemikleriniz aynı anda yerden kalksın.\n\n"
        "\t5-Tepe noktadayken 1–2 saniye bekleyin. Aşağı yavaşça inin.\n\n",
    "\t1-Yüzüstü yere yatın. Dirseklerinizi dik hale getirip üstünde durun.\n\n"
        "\t2-Dirsekleriniz ile yerden destek alıp durun ve bu sırada dirseklerin omuz hizasında olduğuna dikkat edin.\n\n"
        "\t3-Ardından ayak parmaklarınızdan destek alın. Sadece dirsek ve ayak parmaklarınızdan destek alıyor olmalısınız.\n\n"
        "\t4-Bacaklarınızı omuz hizasında tutun. Kalçanızı ne yukarı kaldırın ne de aşağıya indirin. Düz olmasını sağlayın.\n\n"
        "\t4-Derin nefes alıp verin. Süre bitene kadar beklemeye çalışın.\n\n",
    "\t1-Plank pozisyonuna geçtikten sonra sağ eliniz ile gücünüzü ve dengenizi sağladıktan sonra yavaşça dönerek yan plank pozuna geçin.\n\n"
        "\t2-Düz ve dengede olduktan sonra sağ/sol kolunuzu yukarıya kaldırın ve bu pozisyonda kalın.\n\n"
        "\t3-Daha sonra başlangıç pozisyonuna dönün. Bu sefer diğer tarafınıza aynı hareketi uygulayın.\n\n",
    "\t1-Bacak ve omuzlarınız aynı hizada olacak şekilde pozisyon alın.\n\n"
        "\t2-Dizlerinizin ayak hizasını geçmemesine dikkat edin ve başınızı düz pozisyonda tutun.\n\n"
        "\t3-Ayarladığınız pozisyonu koruyarak karnınızın sıkı, belinizin düz olduğundan emin olup sadece kalça bölgenizin dışarı çıkaracak şekilde eğilin.\n\n"
        "\t4-Daha sonra başlangıç pozisyonuna gelerek hareketi tekrarlayın.\n\n",

    "\t1-Direnç bandı kullanıyorsanız tutma yerlerinden, lastik kullanıyorsanız elinizi saracak şekilde tutun.\n\n"
        "\t2-Ellerinizi omuz yüksekliğine getirin, düz duracak şekilde pozisyonunuzu alın.\n\n"
        "\t3-Direnç bandını - lastiği kollarınız düz olana kadar gerin, 1 saniye bekleyin. (Bu sırada kollarınız omuz yüksekliğini korumalı.)\n\n"
        "\t4-İlk pozisyona geri gelip hareketi tekrarlayabilirsiniz.",
    "\t1-Pilates topu başınızın üzerinde olacak şekilde pozisyonunuzu alın.\n\n"
        "\t2-Sırtınızın duruşu dik olacak şekilde, topu kollarınız dik olacak şekilde tutarak önce sola doğru belinizden eğilin.\n\n"
        "\t3-Başlangıç pozisyonuna dönün ve aynı şekilde sağ tarafa eğilin.\n\n"
        "\t4-Eğilmiş ve durma noktası olacak pozisyon için resme bakabilirsiniz.",

    "\t1-Direnç bandı veya lastiğin ortasına resimdeki gibi ayaklarınız ile basın ve iki uçtan sıkıca tutun.\n\n"
        "\t2-Kollarınız bacaklarınızın yanında olacak şekilde başlangıç pozisyonunu alın.\n\n"
        "\t3-Dirseklerinizi bükmeden ellerinizi omuz seviyesine kadar (direnç bandı - lastik gerginliğine dikkat ederek) yukarı çıkartın.\n\n"
        "\t4-Bir kaç saniye bekledikten sonra tekrar başlangıç pozisyonuna dönerek hareketi tekrarlayabilirsiniz.",
    "\t1-Yerde elleriniz ve dizleriniz üzerinde masa pozisyonunda durun.\n\n"
        "\t2-Dizlerinizin tam kalçalarınızın altına denk gelmesine, omuzlarınız ile el bileklerinizin aynı hizada ve yere paralel olmasına dikkat edin. Başınız tam merkezde olsun ve gözleriniz yere baksın.\n\n"
        "\t3-Nefes vererek oturma kemiklerinizi ve göğsünüzü tavana doğru kaldırın. Karnınız yere doğru yaklaşsın.\n\n"
        "\t4-Nefes verin ve tekrar masa pozisyonuna geçin.\n\n",

    "\t1-Ayakta dik bir şekilde durun.\n\n"
        "\t2-Ardından ayaklarınızı hafifçe açın, kollarınızı başınızın üzerine doğru kaldırın ve ileri doğru uzatın.\n\n"
        "\t3-Harekete yavaş bir şekilde arkanızda sandalye varmış ve oturuyormuş gibi çömelerek devam edin. \n\n"
        "\t4-Üst bedeninizi dik tutun, kambur durmamaya özen gösterin. \n\n"
        "\t5-Üst bacağınız yer ile paralel hale geldiği zaman pozisyonu koruyun. Bir kaç kez nefes alıp verin. \n\n"
        "\t6-Başlangıç pozisyonunuza dönüp hareketi tekrarlayabilirsiniz.\n\n",
    "\t1-Ayakta durarak başlayın, dizlerinizi kırın ve sağ ayağınız üzerinde dengede durun.\n\n"
        "\t2-Sol bacağınızı sağın üzerinden geçirin, sol ayağınızı da sağ baldırınıza değdirin.\n\n"
        "\t3-Bir nefeslik süre boyunca dengede kalın, sonra kollarınızı düz bir şekilde ileri doğrultun ve sol kolunuzu sağ kolunuzun altına koyun.\n\n"
        "\t4-Dirseklerinizi bükün, kollarınızı birbirine değdirerek, avuçlarınızı birbirine bastırın.\n\n"
        "\t5-Kalçalarınızı ve göğsünüzü düz tutarak karnınızı içeri çekin.\n\n"
        "\t6-Seviyenize göre (ortalama 5 sn.) bekleyin, sonrasında kollarınızı ve bacaklarınızı çözüp diğer taraf için deneyin.\n\n",
    "\t1-Sırt üstü yatın. Ayaklarınızı omuz genişliğinde olacak şekilde açın ve kendinize çekip başlangıç pozisyonunu alın.\n\n"
        "\t2-Yavaşça kalçanız ve karın kaslarınızdan güç alarak kalkmaya çalışın. Ellerinizi kalktıktan sonra açın ve yere koyun.\n\n"
        "\t3-Bu pozisyonda bir kaç kez nefes alıp verip başlangıç pozisyonuna dönebilir ve hareketi tekrarlayabilirsiniz.\n\n",

    "Not:Bu pozdan sonra inek pozuna geçebilirsiniz.\n\n"
        "\t1-Kollarınızı omuz hizanızda olacak şekilde başlangıç pozisyonunu alın. Ellerinizi avuç içleriniz yere değecek şekilde konumlandırın ve parmaklarınızı açın.\n\n"
        "\t2-Nefes verirken karnınızı içeri çekin, sırtınızı kambur hale getirin. Başınızı öne doğru eğin ve dizlerinize bakmaya başlayın.\n\n"
        "\t3-Bu sırada çenenizi göğsünüze değdirmemeye özen gösterin.\n\n"
        "\t4-Bir kaç saniye bekleyin. Ardından başlangıç pozisyonuna dönerek hareketi tekrarlayabilirsiniz.\n\n",

    "HAREKETİN TAM ADI: Ayakta Öne Eğilme Pozu\n\n"
        "\t1-Ayakta dururken, nefes vererek avuçlarınızın yere değmesini sağlayacak kadar dizlerinizi kırarak eğilin.\n\n"
        "\t2-Başınız diz hizanıza kadar gelmiş olsun. Bacaklarınızı düz tutmaya özen gösterin.\n\n"
        "\t3-Bir kaç saniye boyunca pozisyonu koruyun, sonra dizlerinizi büküp nefes alarak rahatlamaya çalışın. \n\n"
        "\t4-Başlangıç pozisyonunuza geri dönüp hareketi tekrarlayabilirsiniz.\n\n",
    "HAREKETİN TAM ADI: Oturarak Öne Eğilme Pozu\n\n"
        "\t1-Oturur pozisyonda bacaklarınızı düz olacak şekilde uzatın. Omurganızı uzatmak için derin bir nefes alın.\n\n"
        "\t2-Nefes verirken göbeğinizi içinize çekin ve gövdenizi ileriye doğru eğin. Ellerinizi, bacaklarınız ve belinizin izin verdiği kadar ileriye uzatın.\n\n"
        "\t3-Alnınızı bacaklarınızın üzerine yaslayın ve gevşeyin. Bu pozisyonda en az üç kez derin nefes alın verin.\n\n"
        "\t4-Başlangıç pozisyonuna dönüp ve dinlenip tekrar uygulayabilirsiniz.\n\n",

    "\t1-Bir ayağınızı öne uzatın, diğer ayağınızı arkada olacak şekilde tutun.\n\n"
        "\t2-Öndeki ayağınızın üzerine doğru bedeninizi ilerletin, arkadaki bacağınızın dizlerden kırılmasına izin vermeyin.\n\n"
        "\t3-Bunları uygularken dik durmaya ve kollarınızı açmaya özen gösterin.\n\n"
        "\t4-Bu pozisyonda bir kaç saniye bekleyin. Ardından başlangıç pozisyonuna dönüp tekrarlayabilirsiniz.\n\n",

    "HAREKETİN TAM ADI: Geniş Üçgen Pozu\n\n"
        "\t1-Ayakta durarak başlayın. Nefes vererek bacaklarınızı açın ve ellerinizi yanlara doğru açıp, avuçlarınız yere bakacak şekilde durun.\n\n"
        "\t2-Sağ ayağınızı 90 derecelik açıyla dışarı doğru döndürün, sol ayağınızı da sağa doğru döndürün.\n\n"
        "\t3-Kalça kaslarınızı sıkın ve sağ kalçanızı dışa çevirin, sonra vücudu kalça tarafından sağ bacağa doğru bükün.\n\n"
        "\t4-Vücudunuzu sola çevirin, sonrasında sol kalçanızı yavaşça ileri götürün.\n\n"
        "\t5-Sağ elinizi ayak bilekleriniz de tutun, sol elinizi de yukarı kaldırın.\n\n"
        "\t6-Kafanızı düz veya hafifçe sola yatık tutun, bu pozisyonda ortalama 20 saniye (seviyenize göre değişebilir) kalın.\n\n",
    "HAREKETİN TAM ADI: Yarım Balık Kralı Pozu\n\n"
        "\t1-Yere oturun, sırtınız dik olacak şekilde bacaklarınızı öne uzatın. \n\n"
        "\t2-Dizlerinizi bükün, ayaklarınızı yere basın ve sol ayağınızı sağ bacağınızın altına, kalçanızın dışına doğru ilerletin. \n\n"
        "\t3-Sol bacağınızın dışını yere yatırın. Sağ ayağınızı sol bacağınızın dışına yere basın ve sağ dizinizin tavana bakmalı. \n\n"
        "\t4-Nefes vererek sağ kalçanızın dışına doğru dönün. Sağ elinizi sağ kalçanızın arkasında yere bastırın ve sol kolunuzu dirsek hizasından sağ dizinize geçirin. Sol el düz tavanı göstermeli. \n\n"
        "\t5-Sağ ayağınızı yere basın. Sırtınızı da dik tutmaya özen gösterin. Başınızı kontrollü şekilde sağ tarafa döndürün.\n\n"
        "\t6-Ortalama 20 saniye bu pozisyonu koruyun. \n\n"
        "\t7-Ardından başlangıç pozisyonuna dönerek diğer taraftan hareketi tekrarlayabilirsiniz.",
    "\t1-Yere oturun ve ayaklarınızı dümdüz olacak şekilde uzatın.\n\n"
        "\t2-Sağ dizinizi büküp, sağ ayak bileğinizi sol kasığınızın üzerine yerleştirin. \n\n"
        "\t3-Sonrasında sol dizinizi büküp, sol ayağınızı bu sefer sağ kasığınızın üzerine çapraz bir şekilde yerleştirin. \n\n"
        "\t4-Ellerinizi baş parmak ve işaret parmağı bitişik avuç içleri yukarı bakacak şekilde serbest bırakın. \n\n"
        "\t5-Doğal bir şekilde burundan nefes alıp vermeye başlayın. Ortalama 20 saniye bu pozisyonda kalabilirsiniz. \n\n",
    "HAREKETİN TAM ADI: Aşağı Bakan Köpek Pozu\n\n"
        "\t1-Elleriniz ve dizleriniz yerde pozisyona başlayın. Kalçanız yukarıyı görecek ve topuklarınız yere değmeyecek şekilde pozisyon alın.\n\n"
        "\t2-Boynunuzu uzatmak için başınızı eğin. \n\n"
        "\t3-Bilekleriniz yerin kenarına paralel olmalıdır. Bu pozisyonda bir kaç saniye kalıp tekrarlayabilirsiniz.\n\n",
    "HAREKETİN TAM ADI: Yukarı Bakan Köpek Pozu\n\n"
        "\t1-Yüzüstü yatarak avuç içlerinizi yere bastırın ve göğsünüzü yukarı kaldırın.\n\n"
        "\t2-Dizlerinizi yerden kaldırabilmek ayaklarınızı yere bastırın.\n\n"
        "\t2-Bu pozisyonda, sadece elleriniz ve ayaklarınızın üstünün yerde olması lazım.\n\n"
        "\t3-Nefes alıp vermeyi unutmayın.",
    "\t1-Yürüyüşe başlamadan önce ısınma egzersizlerini uygulayabilirsiniz.\n\n"
        "\t2-Nefesinizi düzenli alıp vermeye özen gösterin.\n\n"
        "\t3-Belirli bir tempo yakalayın ve yürüyüş sonuna kadar korumaya özen gösterin.\n\n"
        "\t4-Tempolu yürümek 30 dakikadan sonra yağ yakımınızı önemli derecede artırmaktadır.\n\n",
    "\t1-Günlük dinlenmelerde, uykunun yeteri kadar alındığını düşünürsek egzersizlerden sonra vücudumuzu dinlendirmek çok önemlidir.\n\n"
        "\t2-Antrenman sonraları yaptığınız dinlenmeler, antrenman öncesi yaptığınız dinlenmeler kadar vücudunuzun gelişmesi ve forma girmesine katkı sağlar. \n\n"
        "\t3-Rahatlayıp yeniden sıradaki antrenmana hazırlanmak için dinlenme günlerine önem vermeliyiz.",

    // "\t1-Kol çevirme hareketi, Ayaklarınızı omuz genişliğinde açmış ve kollarınız yanınızda olacak şekilde ayakta durun.\n\n"
    //     "\tKollarınızı yavaşça öne doğru dairesel hareketlerle sallayın. Bunu yaparken, omuzlarını ısınıyor hissetmelisiniz.\n\n"
    //     "\t2-Dizi yukarı çekme hareketi, Yerinizde sayarak hafif tempoda koşmaya başlayın. Kollarınız sabit kalmalı.\n\n"
    //     "\t3-Lunge hareketi, Ayakta duruş pozisyonundayken bir adım öne atın. Öne attığınız bacağınızı diz bölümünden bükün. \n\n"
    //     "\tArdından bacak değiştirip hareketi tekrarlayın.\n\n",
    // "\tSeçenek 1: Sırtüstü uzanın.\n\n"
    //     "\tİki ayağınızın arasındaki mesafeyi omuz genişliğinize göre ayarlayın ve ayaklarınızı kendinize doğru çekin\n\n"
    //     "\tEllerinizle yerden destek alarak kalçanızı havaya kaldırın.\n\n"
    //     "\tSeçenek 2: Ayağa kalkın.\n\n"
    //     "\tDizlerinizi bükmeden öne doğru eğilin ve başınızı olabildiğince bacaklarınıza yaklaştırın. \n\n"
    //     "\tBu sırada ellerinizle arkadan ayak bileklerinizi tutabilirsiniz.\n\n"
    //     "\tSeçenek 3: Son olarak bedeninizi dinlendirmek ve ona tamamladığı yoga hareketleri için teşekkür etmek üzere sırt üstü uzanın\n\n"
    //     "\tKollarınızı iki yana bırakın. Tüm bedeninizin ağırlığını yere verin ve gözlerinizi kapatarak bir süre kıpırdamadan uzanın.\n\n",
    // "\tSpor yapmak kadar dinlenmekte çok önemlidir.\n\n"
    //     "\tVücudumuz spor yaparken gelişeceği gibi, dinlenirkende gelişir."
  ];

  static const List<String> EGZERSIZ_SEVIYE = [
    "Kolay",
    "Kolay",
    "Kolay",
    "Kolay",
    "Orta",
    "Orta",
    "Zor",
    "Zor",
    "Orta",
    "Orta",
    "Kolay",
    "Zor",
    "Orta",
    "Zor",
    "Çok Zor",
    "Orta", //15
    "Orta",
    "Zor", //19
    "Zor",
    "Orta",
    "Orta",
    "Zor",
    "Kolay",
    "Orta",
    "Orta", //yukarı bakma
    "Kolay",
    "Kolay"
  ];
}
//6 8 9 11 25 ve ilerisi
//sqlite
