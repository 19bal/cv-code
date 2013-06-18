  **Hu-Moment-and-Zernice-Moment**


  **Seda DOĞAN - K. Canan DEMİREL - Merve BAŞTÜRK**

Makalenin orijinal haline <a href="https://docs.google.com/a/bil.omu.edu.tr/file/d/0B-m4B9H1C_PDOUp0Y0ZlN2k2MEU/edit">buradan</a>, tamamının çevrilmiş haline ise <a href="https://docs.google.com/a/bil.omu.edu.tr/document/d/1Nuufm9ak1uvf2Lg0Ueh16fO8SGoZLNaR4sC1I3kVxs4/edit">buradan</a> ulaşabilirsiniz.

Bitki tanımlamada bazı zorluklar bulunmaktadır. Çeşitli yöntem ve özellik önerileri olmuştur. Zernice moment kullanarak yeşil bitki tanıma sistemi kurulmuştur. Bu durumda Zernice moment geometrik özellikleri, renk momentleri, gri- düzey eş-oluşum matrisi (GLCM) gibi özellikleri ile kombine edilerek kullanılmaya başlanmıştır. Bu tanıma sistemi için iki yaklaşım incelenmiştir: İlk yaklaşımda uzaklık ölçüsü kullanılmıştır, ikinci yaklaşımda ise Olasılık Sinir Ağları (PNN) kullanılmıştır. Elde edilen sonuçlarda ise Zernice momentin diğer özellikler ile kombine edildiği zaman yaprak tanıma sisteminin olabileceği ihtimali görülmüştür. 

Yaprak görüntüsü kullanılarak bitkilerin belirlenmesi çeşitli araştırmacılar tarafından keşfedilmiştir. Araştırmalardan bazıları yeşil yaprak ve renk bilgisi üzerine odaklanmıştır. 32 tür bitkiyi sınıflandırmak için PNN kullanılmıştır, 10 çeşit bitkiyi sınıflandırmak için Genel Regrasyon Sinir Ağları (GRNN) ve değişmez moment kullanarak araştırma yapılmıştır. 

Yaprak tanıma sistemleri yüksek performans elde etmek için yöntemleri ve özellikleri kombine edilmiş bir araya getirilmiştir.  Chaki and Parakh, sadece şekil özelliklerini esas alan ikili süperpozisyon adı verilen bir yöntem önermişlerdir. Sadece şekil özelliklerini esas alan yaklaşım olan süperpozisyon yöntemi ile yaprak görüntülerin ikili sürümleri karşılaştırılarak ve sıfır piksel değerleri toplamı kullanılarak özellik vektörünün bileşkesine (sonuca) ulaşılmıştır. 6 çeşit bitkiyi tanımak için ise, yaprakların diğer özellikleri kullanılmıştır ve damarların kenarları yakalanmaya çalışılmıştır. Bunun için geometrik özellikler ve değişmez momentler kullanılmıştır. 

Ehsanirad ve Kumar, 13 çeşit bitkiyi sınıflandırmak için gri seviye eş-oluşum matrisi (GLCM) ve Temel Bileşen Analizi (PCA) kullanarak bir bitki tanıma sistemi geliştirmiştir. Jiming ise 30 çeşit bitkiyi sınıflandırmak için  komşuluk kaba kümesi (neighborhood rough set) adında önerilen bir yöntem ile %95.83 doğruluk derecesine ulaşmıştır.

Flavia ‘da kullanılan bir yöntem ile onlar 32 çeşit bitki sınıflandırmasın da Fourier moment leri kullanarak %46.30, PNN-PCNN kullanarak %91.25, Destek Vektör Makinesi (SVM) kullanarak %81.56 doğruluk derecesi olduğunu bildirmişlerdir. Lee ve Chen, 1-NN kullanarak %82.33 doğruluk oranı ile 60 çeşit bitkiyi sınıflandırmıştır. 

Tanımlama sistemlerinde kullanılan tüm özellikler, ya bir uzaklık ölçüsü yada Olasılıklı Sinir Ağları (PNN) kullanarak oluşturulmuştur.

Bu temel tanıma sistemlerinde kullanılan geometrik özellikler; en-boy oranı, dairesellik, düzensizlik, damar özellikleri, dayanıklılık, dışbükeylik(Convexity), renk momenti, GLCM(Gray Level Co-Occurrence Matrix), Zernice moment 'tir.

Bu tanıma sisteminde mesafe ölçümü için ise; CBIR (İçerik Tabanlı Görüntü Alma) yöntemi kullanılır. 



 
