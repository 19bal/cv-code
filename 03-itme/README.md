### HAZIRLAYANLAR

- Gökhan Demir | http://gdemir.me
- Erol Uslu
- Merve Ceylan
- Yunus Ateş

### AÇIKLAMA

- bg_model:

Arkaplan videolarının(kişilerin bulunmadığı videolar) ortalama ve standart sapma değerlerini 2 resim şeklinde dönderir.

- bg_remove:

bg_model'den gelen ortalama ve standart sapma değerleri kullanılarak önplan videolarından(kişilerin bulunduğu videolar) kişilerin
barındırdığı alanları **1** diğer alanları(arka planı) **0** olarak bw(siyah beyaz) bir frame cell'i(hücresi) dönderir.

- motion_detection.m:

bg_remove'dan gelen bw(siyah beyaz) frame cell'ini(hücresini) yorumlarayarak itme olup olmadığını söyler.

### VİDEO VE BİLDİRİ

Videolar ve bildiri için [tıklayınız](http://github.com/19bal/cv-asset/tree/master/03-itme)
