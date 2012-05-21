### HAZIRLAYANLAR

- Sedat Geldi | http://seddi.me
- Caner Bodur
- Çağatay Kaçar
- Sema Altunal
- Meryem Yılmaz

### AÇIKLAMA
`main` fonksiyonu ile oncelikle video okuma islemi ve framelere ayırma islemi
yapılmaktadır. Diger arka plan bulmak icin kullandıgımız `bg_model` fonksiyonunu
cagırmakta ve bu fonksiyonda ortalama bir `mn` framei ile standart sapması olan
`std` frameini uretmektedir. Daha sonra `bw_nesne` fonksiyonu kullanılarak mn
frameine ve std frameine baglı olarak framelerdeki kisiler ayırt edilmis ve
olusturulan black-white (`bw`) goruntulerde iyileştirmeler yapılmıstır.
İyilestirme kısmında belirlenen bir alan degerinden kucuk olan gurultu olarak
gorunen kısımlar goruntuden silinmistir. Bu fonksiyondan tum frameler belli bir
iyilestirme sonucu alındıktan sonra `ayıkla` fonksiyonuna gonderilip framelerin uzerindeki nesne goruntulerinden elde edilen alan degerlerine gore ortalama alan (`A_ort`) hesaplanmıstır. Bu alan degerinde kucuk olan frameler de el sıkısma olmayacagı dusunulmus ve bu frameler goz ardı edılmıstır. Aynı sekilde burada da ayıklama yapıldıktan sonra `kontrolet` fonksiyonunda da ayıkla sonucundan cıkan framelerde nesneler de yuvarlaklık olcutu ile ayıklama yapılmıs ve sonuc olarak cıkan tum framelerden ortanca numaralı frame ekranda gosterılmıstir.

### BİLDİRİ

Uygulamanın bildirisine ulaşmak için [Tıklayınız.](http://docs.google.com/a/bil.omu.edu.tr/file/d/0B6inE3EkDgNsZkV2aHlpMGllNFk/edit)

### YOUTUBE

Youtube üzerinden uygulamanın kullanımını anlatan video'yu izlemek için [Tıklayınız.](http://www.youtube.com/watch?v=AHEStKJzAaM)
