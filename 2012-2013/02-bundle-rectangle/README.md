YÜRÜYÜŞ TANIMA SİSTEMİ: BUNDLE RECTANGLE YAKLAŞIMI

İlgili makalede özellik çıkarımı aşağıdaki şekilde yapılmıştır:

1) Arka plan çıkarma işlemi ile çıkarılan siluete göre bir dikdörtgen çizilir. Referans noktaları olarak dikdörtgenin en dış noktaları alınır.

2) Dikdörtgenin  y eksenine göre en üst ve en alt noktalar ile x eksenine göre en sağ ve en sol noktaları uç noktalar olarak alınır.

3) Yürüme özellikleri,  dikdörtgenin yüksekliği,  genişliği,  alanı,  çapraz açısı, sıklığı gibi yönleriyle analiz edilir.

4) Yürüyüş anında aynı kişinin dikdörtgen içine alınmış görüntülerinin genişliği, yüksekliği,  alanı,  çapraz açısı, frekansının ortalaması, toplam spectral güç alınarak yürüyüş karakteri belirlenir.

![](http://image.bayimg.com/2023e22af4a188207e51b7aa8fb219fc89678652.jpg)

---

SDHA2010 veritabanında ilgili özellik çıkarımı yapıldığında örnek ekran çıktıları:

![](http://s1.directupload.net/images/130424/5sdnabkg.jpg)
![](http://s2.ipicture.ru/uploads/20130424/pHAn4cZK.jpg)

---

Analizi yapılacak hareketler:
  
* Tek el  kaldırma(wave1)
* İki el kaldırma(wave2)
* Durma(standing)
* Kazma

SDHA2010 veritabanından seçilen tek el kaldırma eğitim seti  örnekleri:

![](http://savepic.ru/4633054.jpg)

İlgili makalede gerçeklenen özellik çıkarımının uygulanması:

![](http://savepic.ru/4626910.jpg)

SDHA2010 veritabanından seçilen iki el kaldırma eğitim seti  örnekleri:

![](http://images.vfl.ru/ii/1370022488/3a35d714/2446660.jpg)

İlgili makalede gerçeklenen özellik çıkarımının uygulanması: 

![](http://i1.imageban.ru/out/2013/05/31/52d7468b8032725c18652b8ca12e538c.jpg)

SDHA2010 veritabanından seçile durma eğitim seti  örnekleri:

![](http://funkyimg.com/u2/4594/784/1277425.jpg)

İlgili makalede gerçeklenen özellik çıkarımının uygulanması:

![](http://photoload.ru/data/cc/e3/2d/cce32dd5bdda989d34c8ae2cf07f529d.jpg)

Yapay sinir ağlarına; analizi yapılacak 3 hareketin makalede belirtildiği gibi yükseklik, genişlik, alan, açı, spektral güç ortalaması girdi olarak  verilmiştir.

<p> Yöntem :

Her bir hareketin 20 tane örnek görüntüsü vardır. Bu her bir harekete ait 20 görüntüdeki insan figürü kare içine alınmıştır. Karenin uç noktaları yardımıyla  yükseklik, genişlik, alan, açı, spektral güç değerleri hesaplanıp her bir hareketin ortalama  yükseklik, genişlik, alan, açı, spektral gücü bulunmuştur. 
Sonuç olarak ağ 5 girişten (her bir hareket için ortalama yükseklik, genişlik, alan, açı, spektral gücü), 3 çıkıştan oluşmaktadır. 

Ağın çıkışları:
1 0 0  0    ise tek el kaldırma(wave1)
0 1 0  0    ise durma(standing)
0 0 1  0    ise kazma 
0 0 0  1    ise iki el kadırma(wave2)  

Yapay sinir ağı Matlab’ın nprtool arayüzü ile tasarlanmıştır.

Oluşrulan ağın ekran çıktısı:

![](http://savepic.ru/4640591.jpg)

Ağın eğitim, test , doğrulama setinin sonuçları:

![](http://iceimg.com/i/03/8d/83d2c48804.jpg)
