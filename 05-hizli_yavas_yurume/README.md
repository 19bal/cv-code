### HAZIRLAYANLAR

- Mesut Muhammet Şahin
- Eren Özdemir
- İsmail Sünbül
- Rahmi Saçal

### AÇIKLAMA
`bg_model` fonksiyonu ile arkaplan video okuma işlemi yapılarak, ortalama(`mn`) frame ile standart sapma(`st`) frameleri elde edilmektedir. 

`bg_arka` fonksiyonu, `bg_model` ile üretmiş olduğumuz değerleri kullanarak videoda yürüme eylemini yapan kişi tespit edilmiş ve olusturulan black-white (`bw`) görüntülerde iyileştirmeler yapılmıştır.

`bg_kontrol` fonksiyonu, önce `bg_model` fonksiyonunu daha sonra `bg_arka` fonksiyonunu çağırır. Daha sonra frame'lerin BoundingBox özellikleri alınarak iki bacak arası mesafe BoundingBox 'ı en büyük frame belirlenmesi yapılır. Belirli bir eşik değeri ile karşılaştırarak yürümenin hızlı mı yoksa yavaş mı olduğu belirlenir.

### YOUTUBE

Youtube üzerinden uygulamanın kullanımını anlatan video'yu izlemek için [Tıklayınız.](http://www.youtube.com/watch?v=JJZXZ9oghOY)
