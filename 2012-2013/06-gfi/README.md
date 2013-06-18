### Bilgisayarlı Görü Lab Proje Grubu

** Makale: ** Gait Flow Image

#### Grup Üyeleri

- Fatih TAŞTEMUR

- Ali Burak ÖNCÜL

- Nevzat BOZDAĞ

GFI - Gait Flow Image (Yürüyüş Akış Şeması)
-------------------------------------------

Bu yöntem yürüyüş tanımasında kullanılır. GFI'nın temeli ikili siluete dayanır.
GFI bir optik akış alanı kullanılarak oluşturulur. GFI, GEI gibi diğer
yöntemlerle
karşılaştırıldığında daha verimli olduğu görüldü. GFI yaklaşık olarak %42,83
tanıma sağlar ki bu başarım GEI'dan %3,75 daha verimlidir.

Tıbbi araştırmalar insanların yürüyüşlerinin gözlenerek cinsiyet, fizyolojik
rahatsızlıklar vb. özelliklerin çıkarılacağı görülmüştür. Yürüyüşün de parmak
izi veya avuç içi gibi spesifik bir öznitelik olduğu ortaya çıkmıştır.

Yürüyüş tanıma için iki farklı yaklaşım vardır. Bunlar model tabanlı ve model
bağımsız yaklaşımlardır. Model tabanlı yaklaşımda kalça veya eklem pozisyonları
kullanılır. Model bağımsız yaklaşımda ise yürüyüş özellikleri toplanır, ikili
siluetler olarak yeniden hazırlanır.

Yürüyüş dizisi alınır, bu diziden ikili siluet, arkaplandan ayrılarak elde
edilir. Arka plan çıkarma amacı ikili siluetleri elde etmektir. Bu sayede bir
yürüme periyodu elde edilmiş olur. Bu yürüme periyodunda kişinin bir dizi
hareketi bulunur.

Siluet oluşturma yani kişiyi arka plandan ayırma işlemi, threshold veya
segmantasyon teknikleriyle olur. Genellikle arkaplan siyah yani 0 (sıfır)
değerli, ön plan yani kişi ise beyaz yani 1 (bir) değerli olur.

Siluetin uç noktalarına bakılarak hareketin niteliği belirlenir, bu niteliğe
göre hareketin sahibi hakkında istenen çıkarımlar yapılmış olur.
