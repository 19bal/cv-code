### HAZIRLAYANLAR

- Semih Özköroğlu | http://sozkoroglu.me
- Murat Yiğit
- Ahmet Karafilik
- Serkan Kurt
- Can Korkmaz

### AÇIKLAMA

Uygulama kullanıcı etkileşimli bir arayüz sunmaktadır.Bu arayüz ile kullanıcıdan işlenmesi istenilen bir video seçmesini ve her bir videonun arkaplan modellemesi ile standart sapmasını oluşturmak amacı ile başlangıç ve bitiş frame aralığı seçmesini istenmektedir. Genel olarak bu aralık [1 - 25] olarak belirlenmektedir. Eğer video'nun arkaplan görüntüsünde çok fazla sapmalar var ise bu değer aralığını daha büyük seçmek daha uygun olur.

Girilen video'nun işlenme aşamasına başlamadan önce girilen frame aralığında `bg_model` methodu ile videonun background'ı üzerinden ortalama(`mn`) bir frame ile standart sapma(`st`) frameleri elde edilmektedir.

Bu aşamada `mn` ile `st` değerleri ile `temp(abs(sqrt(f1.^2 + f2.^2 + f3.^2) - sqrt(st{1}.^2+st{2}.^2+st{3}.^2)) < 60) = 0;` ifadesini kullanarak video üzerinde blackwhite dönüşümü gerçeklenmiştir( Kişiler 1 arkaplan 0 ).

İlk olarak blackwhite frame'lerimizi `temiz` methoduna göndererek belirlenmiş eşik değerine göre belirlenmiş olan alan değerine sahip olan frame'lerin index numaralarını `Oan` cell'in kaydederek sadece birbirine temas halinde olan frame'lerin belirlenmesi yapıldı. Bu bizim en önemli aşamamızdır. Artık morfolojik yöntemleri ve regionprops methodlarını uygulayarak. Sadece etkileşimde( El sıkışma video'suda olabilir ? ) olan frame'ler üzerinde çalışılabilir bu düzeye getirildi.

Bu aşamada `enkars` methodu ile etkileşimde olan frame'lerin BoundingBox ve Eccentricity özellikleri regionprops methodu ile alınarak BoundingBox 'ı en küçük ve Eccentricity 'i en büyük olan ilk 5 frame belirlenmesi yapıldı. Bu belirleme ile eylemin yapıldığı (Sarılma, itme, el sıkışma vs..) en kritik frame'leri belirlenmiş oldu. Bu eleme'ler sayesinde video işleme hızımız yaklaşık olarak %75 oranında bir artış sağlanmış oldu.

En son aşamamız olan `eleme` methodu ile bir önceki aşamamızdan gelen framelerden en küçük alan'a sahip olanı seçilir.Sebebi ise tam sarılma anında toplam pixel sayısı, birbirine temas halinde olan diğer frame'lere göre daha az olmaktadır. Alanı en küçük olan frame'mizde seçildikten sonra elimizde tek bir frame bulunmaktadır ancak bu frame'in tam olarak sarılma anı olduğu ispatlamak için belirlenen sayıda `imerode` methodu uygulayarak eğer elimizdeki frame üzerinde parçalanmalar meydana gelmiyor ise bu frame'mimizin tam olarak sarılma videosu olduğunu ispatlamış oluyoruz.

### YOUTUBE

Youtube üzerinde uygulamanın gerçeklemesini anlatan video'yu izlemek için [Tıklayınız.](http://www.youtube.com/watch?v=OZWBbRdZWXI&feature=youtu.be)


### BİLDİRİ

Uygulamanın bildirisine ulaşmak için [Tıklayınız](https://docs.google.com/a/bil.omu.edu.tr/file/d/0B-ufRWgXeEyBRHhCczZPTG5URXc/edit)

