### Bilgisayarlı Görü Lab Proje Grubu

Makale: Width Vector

#### Grup Üyeleri

- Ali Daşbaşı

- Emre Engin

- Kerem Öğüt

### Yöntem : Yürüyüş Sıralarını Eşleştirme

	Tipik bir yürüme yürüyen birinin 4 yarım turunu içeren yaklaşık 60 şekle sahiptir. Geniş veri öğreniminin yokluğu yüzünden,
doğrudan video temelli eşleştirme istatistiksel modelleri kullanmaktan çok daha uygundur.  Doğrudan şekle şekil eşleştirme gerçekçi
bir şema olmaz çünkü insanlar yürüme şeklini ve hızlarını değiştirebilirler. Mümkün eşleştirmenin şekillerini kısıtlamak yerine,
değerlendirme esnasında her acil durumda bir araştırma bölgesine izin vermek için tedbirli olabilir. Bu yüzden DTW(8) eşleştirme
şeması olarak seçildi. DTW kuralına anahtar adımlar son nokta sınırlandırmalarını uyguluyor, sapma yolunu içerip aynı yolda geri
dönerek takip edilen yerel ve kümülatif hata hesaplarını hesaplıyor. Son nokta sınırlamasına ikna etmek için, bütün sıralamalar ilk
ve son şekillerin ikisi de rahat duruşlar için işlenir. Öklit uzaklığı iki genişlik vektörü karşılaştırıldığı zaman yerel uzaklığı
ölçmek için kullanılır. Sapma yolunun sonundaki kümülatif uzaklık referans ve test modelleri arasındaki skoru karşılaştırma olarak
kaydedilir.

### Deneysel Sonuçlar

#### UMD Veritabanı

	UMD veri grubu birbirlerine dikey olarak yerleştirilen iki kamera ile yakalanan dışarıda yapılmış yürüyüş sıralamalarını içerir. 44 kişi 2 oturumda kaydedildi. Biz ilk bölümden toplanmış video verisiyle öğrenip 2.bölümdekilerle de test ettik. UMD verisi için yakın yürüme turlarının sayısı 4’ten 6’ya doğru değişir. Türdeşliği sürdürmek için, eşleştirme 4 yarım tur kullanırız. Farklı yürüme ölçümleri için belirlenmiş sonuçlar tablo-1 de gösterilir. Fark ediyoruz ki oldukça basite indirgenme ve düzgünleştirmeden sonra bile tanımlama oranları hızla azalmamaktadır. Kendi özellikleri için %80’in bir kesinliği sadece 2 öz vektör ile kullanmanın başarılabileceğini görüyoruz. Öz vektörlerin sayısının artması daha düşük kesinliğe yol açar. Çünkü daha yüksek öz vektörler düzeni sesli olmaya meyillidir. Üstelik sadece hız bilgisi kullanılırsa kesinlik önemli bir şekilde düşer. Böylece, yürüyüş tanımlama için hem yapısal hem de dinamik bilgiler önemlidir.

#### CMU Veritabanı

	CMU veri grubu yavaş yürüme, hızlı yürüme, bir top taşıyorken yürüme gibi farklı koşullar altında yürüyen 25 kişiyi içerir.
7 kamera farklı açılara yerleştirilir. Yürüyüş sırasının ilk yarısı test için kullanılırken ikincisi yarısı eğitme için kullanılır.
Bu veri grubu tanımlamada yürüme hızındaki değişikliğin etkisini gösterir. Sonuçlar Tablo-2 de verilmiştir. Görülüyor ki kendi
düzeltilmiş özelliği genel performansa da doğrudan düzeltilmiş özellikten daha iyidir. Çünkü öz düzgünleştirme uzamsal duyudan daha
çok uzay-zaman kısıtlamasını kullanır. Galeri, yavaş yürüme sırası olduğunda ve deneme çubuğu, hızlı yürüme sırası olur.  Galeri ve
deneme çubuğu ikisi de yavaş yürüme hızı olduğu zaman performans durumdan daha düşük bulunur. Deneme çubuğu uzunluğu ile galeri
uzunluğu oranı 0.5 den az veya 2’den fazla olduğunda DTW kötü performansı olarak bilinir. CMU veri grubunda, deneme çubuğunun tur 
uzunluğu ile galerinin tur uzunluğuna oranı en fazla 1.36’dır. Aynı kişi asıl eşleşme olarak doğru tanımlanırdı. Böylece dinamik 
zaman sapma metodu yürüme hızındaki değişikliklerde sağlamdır. Yanlış eşleşme durumlarının biri için oran değeri 1.15’dir. Bunu 
analiz etmek için biz resim-3(a) ve (b)’deki hızlı ve yavaş yürüme durumları altında insanı yanlış tanımanın yürüyüş turlarındaki 
az ama yeterli şekillerini düşündük. Şekilden görüldüğü gibi bir insan için el hareketlerinin yanı sıra duruş da hızlı ve yavaş 
yürüme durumlarında biraz farklıdır. Böylece yürüme turunun uzunluğundan daha çok insanın uzun adımları ve vücut hareketlerindeki 
değişiklikler kötü tanımlama performansından sorumludur. Şekil-3(a) ve (b) sırasıyla yanlış tanımlanmış insanı ve en yüksek oranla 
insan için sapma yollarını gösterir. Sonuç olarak insanların elinde topla yürüdüğü durumda yüksek kesinlik vücudun belli parçaları 
tanımlaması için bir daha tutarlı örnek gösterebileceğini önerir.

#### USF Veritabanı

	USF veritabanı iki farklı ayakkabı (A ve B) giyen iki farklı yüzeyde(cam ve beton) bir eliptik yolu boyunca yürüyen 71 
kişinin dışarıdaki yürüyüş sırasını içerir. 2 kamera R ve L bu veriyi yakalar. 7 deney Tablo-3’de gösterildiği gibi kurulmuştur. 
USF veritabanı bahsettiğimiz veriler arasında en geniş kişi sayısına sahiptir. Doğrudan ve kendi-düzgünleştirilmiş genişlik 
özellikleri tekrar düşünülür. Kendi-düzgünleştirilmiş özelik doğrudan düzgünleştirilmiş özellik ile karşılaştırıldığında daha iyi 
performans verir. CMC Şekil-4’de gösterilen Tablo-3’de tanımlandığı gibi farklı denemeler için kıvrılır. Grafikten birçok sonuç 
çizilebilir. Görüş açısındaki farklılık en az etkileniyorken yüzeydeki farklılığın en kötü tanımlama performansına yol açtığı 
bellidir.

##### Emre Engin, Kerem Öğüt
