import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const DilekceAsistaniApp());
}

class DilekceAsistaniApp extends StatelessWidget {
  const DilekceAsistaniApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dilekçe Asistanı',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF5366A3),
        scaffoldBackgroundColor: const Color(0xFFF8F7FC),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
      home: const AnaSayfa(),
    );
  }
}

class BelgeTipi {
  final String baslik;
  final String kategori;
  final IconData ikon;

  const BelgeTipi(this.baslik, this.kategori, this.ikon);
}

class AnaSayfa extends StatelessWidget {
  const AnaSayfa({super.key});

  static const belgeler = <BelgeTipi>[
    BelgeTipi('Genel Dilekçe', 'dilekce', Icons.description_outlined),
    BelgeTipi('Savunma Hazırla', 'savunma', Icons.shield_outlined),
    BelgeTipi('Şikâyet / İtiraz', 'sikayet', Icons.report_outlined),
    BelgeTipi('Mobbing Başvurusu', 'mobbing', Icons.work_outline),
    BelgeTipi('İşçi Alacak / İşveren Başvurusu', 'isci', Icons.badge_outlined),
    BelgeTipi('Trafik Cezasına İtiraz', 'trafik', Icons.traffic_outlined),
    BelgeTipi('Kaza Olay Tutanağı', 'kaza', Icons.car_crash_outlined),
    BelgeTipi('Mahkeme / Hukuk Başvurusu', 'hukuk', Icons.gavel_outlined),
    BelgeTipi('Tüketici Başvurusu', 'tuketici', Icons.shopping_bag_outlined),
    BelgeTipi('GSM / İnternet Şikâyeti', 'gsm', Icons.wifi_outlined),
    BelgeTipi('Kamu Kurumu Başvurusu', 'kamu', Icons.account_balance_outlined),
    BelgeTipi('Gelen Resmî Yazıya Cevap', 'cevap', Icons.mark_email_read_outlined),
    BelgeTipi('Sendika Yönetim Kurulu Kararı', 'sendikakarar', Icons.groups_outlined),
    BelgeTipi('Sendika Resmî Yazısı', 'sendikayazi', Icons.history_edu_outlined),
    BelgeTipi('Sendika Tüzüğü Taslağı', 'sendikatuzuk', Icons.menu_book_outlined),
    BelgeTipi('Dernek Yönetim Kurulu Kararı', 'dernekkarar', Icons.people_outline),
    BelgeTipi('Dernek Üyelik / İstifa İşlemi', 'dernekuyelik', Icons.person_outline),
    BelgeTipi('Dernek Tüzüğü Taslağı', 'dernektuzuk', Icons.library_books_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dilekçe Asistanı',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              showAboutDialog(
                context: context,
                applicationName: 'Dilekçe Asistanı',
                applicationVersion: '2.0',
                children: const [
                  Text('Geliştiren: Fatih Demirel'),
                  SizedBox(height: 8),
                  Text(
                    'Belge taslakları kullanıcı tarafından kontrol edilerek kullanılmalıdır.',
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Card(
            child: Padding(
              padding: EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hangi belgeyi hazırlayacağız?',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Konunuza uygun bölümü seçin. Her belge kendi bilgilerini sorar.',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          ...belgeler.map(
            (b) => Card(
              child: ListTile(
                leading: Icon(b.ikon, size: 30),
                title: Text(
                  b.baslik,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BelgeFormu(belge: b),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Center(
            child: Text(
              'Dilekçe Asistanı\nGeliştiren: Fatih Demirel',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

class BelgeFormu extends StatefulWidget {
  final BelgeTipi belge;

  const BelgeFormu({super.key, required this.belge});

  @override
  State<BelgeFormu> createState() => _BelgeFormuState();
}

class _BelgeFormuState extends State<BelgeFormu> {
  final Map<String, TextEditingController> c = {};

  TextEditingController ctrl(String key) {
    return c.putIfAbsent(key, () => TextEditingController());
  }

  String v(String key) => ctrl(key).text.trim();

  Widget alan(
    String key,
    String label, {
    int satir = 1,
    TextInputType? keyboard,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: ctrl(key),
        maxLines: satir,
        keyboardType: keyboard,
        decoration: InputDecoration(
          labelText: label,
          alignLabelWithHint: satir > 1,
        ),
      ),
    );
  }

  List<Widget> ortakKisi() => [
        alan('ad', 'Ad Soyad'),
        alan('tc', 'T.C. Kimlik No (gerekiyorsa)'),
        alan('adres', 'Adres', satir: 2),
        alan('telefon', 'Telefon'),
      ];

  List<Widget> formaGoreAlanlar() {
    switch (widget.belge.kategori) {
      case 'savunma':
        return [
          ...ortakKisi(),
          alan('kurum', 'Savunmanın sunulacağı kurum / birim'),
          alan('istek', 'Savunma neden istendi?'),
          alan(
            'olay',
            'Olayı kendi cümlelerinizle anlatın',
            satir: 5,
          ),
          alan(
            'neden',
            'Sizin kusurunuz olmadığını düşündüğünüz nedenler',
            satir: 4,
          ),
          alan(
            'delil',
            'Varsa belge, mesaj, kamera, tanık veya diğer deliller',
            satir: 3,
          ),
        ];

      case 'sendikakarar':
      case 'dernekkarar':
        return [
          alan('kurulus', 'Sendika / dernek adı'),
          alan('tarih', 'Toplantı / karar tarihi'),
          alan('kararno', 'Karar No'),
          alan('katilan', 'Toplantıya katılan yönetim kurulu üyeleri', satir: 3),
          alan('gundem', 'Gündem maddesi', satir: 2),
          alan(
            'gorusme',
            'Ne görüşüldü? Günlük dille anlatabilirsiniz',
            satir: 4,
          ),
          alan(
            'karar',
            'Alınan karar nedir?',
            satir: 4,
          ),
          alan('oy', 'Oy birliği / oy çokluğu'),
        ];

      case 'sendikatuzuk':
      case 'dernektuzuk':
        return [
          alan('kurulus', 'Kuruluşun tam adı'),
          alan('merkez', 'Merkezi'),
          alan('amac', 'Kuruluş amacı', satir: 4),
          alan('faaliyet', 'Faaliyet konuları', satir: 4),
          alan('uyelik', 'Üyelik şartları', satir: 3),
          alan('organlar', 'Organlar / yönetim yapısı', satir: 3),
        ];

      case 'kaza':
        return [
          ...ortakKisi(),
          alan('tarih', 'Kaza tarihi ve saati'),
          alan('yer', 'Kaza yeri'),
          alan('arac1', 'Sizin araç / plaka bilgileriniz'),
          alan('arac2', 'Diğer araç / plaka bilgileri'),
          alan(
            'olay',
            'Kazanın nasıl olduğunu ayrıntılı anlatın',
            satir: 5,
          ),
          alan('hasar', 'Araçlardaki hasarlar', satir: 3),
          alan('tanik', 'Varsa tanık bilgileri', satir: 2),
        ];

      case 'trafik':
        return [
          ...ortakKisi(),
          alan('kurum', 'Cezayı düzenleyen kurum'),
          alan('tutanak', 'Tutanak / seri sıra numarası'),
          alan('teblig', 'Tebliğ / öğrenme tarihi'),
          alan('ceza', 'Ceza türü ve tutarı'),
          alan('yer', 'Ceza yeri'),
          alan(
            'olay',
            'Cezanın neden hatalı olduğunu düşünüyorsunuz?',
            satir: 5,
          ),
          alan('delil', 'Delilleriniz', satir: 3),
        ];

      case 'gsm':
        return [
          ...ortakKisi(),
          alan('operator', 'Operatör / internet sağlayıcısı'),
          alan('abone', 'Abone / müşteri / telefon numarası'),
          alan(
            'sorun',
            'Sorun nedir? (fatura, internet, iptal, cayma bedeli vb.)',
            satir: 4,
          ),
          alan('basvuru', 'Daha önce şirkete yaptığınız başvuru', satir: 3),
          alan('talep', 'Şirketten ne yapılmasını istiyorsunuz?', satir: 3),
        ];

      case 'cevap':
        return [
          ...ortakKisi(),
          alan('kurum', 'Cevap verilecek kurum'),
          alan('gelenkurum', 'Yazıyı gönderen kurum / birim'),
          alan('tarih', 'Gelen yazının tarihi'),
          alan('sayi', 'Gelen yazının sayısı'),
          alan('konu', 'Gelen yazının konusu'),
          alan(
            'icerik',
            'Yazıda sizden ne isteniyor?',
            satir: 4,
          ),
          alan(
            'cevap',
            'Vermek istediğiniz cevabı kendi cümlelerinizle anlatın',
            satir: 5,
          ),
        ];

      case 'dernekuyelik':
        return [
          ...ortakKisi(),
          alan('dernek', 'Dernek adı'),
          alan('islem', 'İşlem türü: üyelik / istifa / yedek üye çağrısı vb.'),
          alan('olay', 'İşlemin açıklaması', satir: 4),
          alan('talep', 'Talep edilen işlem', satir: 3),
        ];

      default:
        return [
          ...ortakKisi(),
          alan('kurum', 'Başvurulacak kurum / kuruluş'),
          alan('konu', 'Konu'),
          alan(
            'olay',
            'Yaşanan olayı / sorunu kendi cümlelerinizle anlatın',
            satir: 5,
          ),
          alan(
            'neden',
            'Önemli ayrıntılar / gerekçeler',
            satir: 4,
          ),
          alan('delil', 'Varsa belge / delil / ekler', satir: 3),
          alan(
            'talep',
            'Sonuçta ne yapılmasını istiyorsunuz?',
            satir: 4,
          ),
        ];
    }
  }

  String tarihBugun() {
    final d = DateTime.now();
    return '${d.day.toString().padLeft(2, '0')}.'
        '${d.month.toString().padLeft(2, '0')}.${d.year}';
  }

  String kimlikBolumu() {
    final b = StringBuffer();
    if (v('ad').isNotEmpty) b.writeln('Ad Soyad: ${v('ad')}');
    if (v('tc').isNotEmpty) b.writeln('T.C. Kimlik No: ${v('tc')}');
    if (v('adres').isNotEmpty) b.writeln('Adres: ${v('adres')}');
    if (v('telefon').isNotEmpty) b.writeln('Telefon: ${v('telefon')}');
    return b.toString();
  }

  String ekler() {
    if (v('delil').isEmpty) return '';
    return '\nEKLER / DELİLLER:\n${v('delil')}\n';
  }

  String resmiAciklama(String olay) {
    if (olay.isEmpty) return '';
    var x = olay.trim();
    if (!x.endsWith('.') && !x.endsWith('!') && !x.endsWith('?')) {
      x = '$x.';
    }
    return x;
  }

  String dilekce() {
    final kurum =
        v('kurum').isEmpty ? 'İLGİLİ MAKAMA' : v('kurum').toUpperCase();

    return '''
$kurum

KONU: ${v('konu').isEmpty ? 'Başvuru ve talebimin sunulması' : v('konu')}

AÇIKLAMALAR:

${resmiAciklama(v('olay'))}

${v('neden').isEmpty ? '' : 'Başvuruma konu husus bakımından ayrıca belirtmek isterim ki; ${resmiAciklama(v('neden'))}'}

Yukarıda açıkladığım hususların birlikte değerlendirilerek konu hakkında gerekli incelemenin yapılmasını talep etmekteyim.

SONUÇ VE TALEP:

${v('talep').isEmpty ? 'Yukarıda arz edilen hususların incelenerek gereğinin yapılmasını ve sonucundan tarafıma bilgi verilmesini saygılarımla arz ederim.' : '${resmiAciklama(v('talep'))} Bu kapsamda gerekli işlemlerin yapılarak sonucundan tarafıma bilgi verilmesini saygılarımla arz ederim.'}

${ekler()}
Tarih: ${tarihBugun()}

${kimlikBolumu()}
İmza:
''';
  }

  String savunma() {
    final kurum =
        v('kurum').isEmpty ? 'İLGİLİ MAKAMA' : v('kurum').toUpperCase();

    return '''
$kurum

KONU: Savunmalarımın sunulması hakkındadır.

SAVUNMA:

Tarafımdan savunma istenmesine konu husus ${v('istek').isEmpty ? 'ile ilgili olarak açıklamalarımı sunma gereği doğmuştur' : 'özetle "${v('istek')}" şeklindedir'}.

Olayın gerçekleşme sürecine ilişkin açıklamam şöyledir:

${resmiAciklama(v('olay'))}

${v('neden').isEmpty ? '' : 'Olayın meydana gelmesinde tarafıma kusur yüklenmemesi gerektiğini düşündüğüm hususlar şunlardır:\n\n${resmiAciklama(v('neden'))}'}

${v('delil').isEmpty ? '' : 'Bu açıklamalarımın değerlendirilmesinde ${v('delil')} hususlarının da dikkate alınmasını talep ederim.'}

Olayın oluş şekli, tarafıma yapılan bildirimler, mevcut çalışma koşulları ve yukarıda açıkladığım hususlar birlikte değerlendirildiğinde, konu hakkında karar verilirken olayın bütün yönleriyle incelenmesinin hakkaniyete uygun olacağı kanaatindeyim.

SONUÇ VE TALEP:

Yukarıda sunduğum savunmalarım ile mevcut bilgi ve belgelerin birlikte değerlendirilmesini, olayın gerçek oluş şeklinin dikkate alınmasını ve hakkımda yapılacak işlemde bu açıklamalarımın göz önünde bulundurulmasını saygılarımla arz ederim.

Tarih: ${tarihBugun()}

${kimlikBolumu()}
İmza:
''';
  }

  String sikayet() {
    final kurum =
        v('kurum').isEmpty ? 'İLGİLİ MAKAMA' : v('kurum').toUpperCase();

    return '''
$kurum

KONU: ${v('konu').isEmpty ? 'Şikâyet ve inceleme talebi' : v('konu')}

AÇIKLAMALAR:

Başvuruma konu olay ve uygulamalar aşağıda açıklanmıştır.

${resmiAciklama(v('olay'))}

${v('neden').isEmpty ? '' : 'Konuya ilişkin önemli gördüğüm diğer hususlar şunlardır:\n\n${resmiAciklama(v('neden'))}'}

Belirttiğim hususların yalnızca tek bir olay üzerinden değil, olayın oluş şekli ve mevcut bilgi ve belgeler birlikte değerlendirilerek incelenmesini talep etmekteyim.

SONUÇ VE TALEP:

${v('talep').isEmpty ? 'Şikâyetime konu hususların araştırılmasını, gerekli inceleme ve işlemlerin yapılmasını ve sonucundan tarafıma bilgi verilmesini saygılarımla arz ederim.' : '${resmiAciklama(v('talep'))} Gerekli incelemenin yapılarak sonucundan tarafıma bilgi verilmesini saygılarımla arz ederim.'}

${ekler()}
Tarih: ${tarihBugun()}

${kimlikBolumu()}
İmza:
''';
  }

  String mobbing() {
    final kurum =
        v('kurum').isEmpty ? 'İLGİLİ MAKAMA' : v('kurum').toUpperCase();

    return '''
$kurum

KONU: İşyerinde yaşandığı belirtilen davranış ve uygulamaların incelenmesi talebidir.

AÇIKLAMALAR:

Çalışma ortamında yaşadığım ve değerlendirilmesini istediğim olaylar aşağıda açıklanmıştır:

${resmiAciklama(v('olay'))}

${v('neden').isEmpty ? '' : 'Söz konusu uygulamaların çalışma düzeni ve şahsım üzerindeki etkileri bakımından önemli gördüğüm hususlar şöyledir:\n\n${resmiAciklama(v('neden'))}'}

Belirttiğim olayların sürekliliği, gerçekleşme biçimi, çalışma ortamına etkileri ve varsa bilgi ve belgeler birlikte değerlendirilerek incelenmesini talep etmekteyim.

SONUÇ VE TALEP:

${v('talep').isEmpty ? 'Başvuruma konu olayların araştırılmasını, çalışma ortamında gerekli incelemenin yapılmasını, mevzuat kapsamında gerekli tedbir ve işlemlerin değerlendirilmesini ve sonucundan tarafıma bilgi verilmesini saygılarımla arz ederim.' : '${resmiAciklama(v('talep'))} Başvurumun incelenerek sonucundan tarafıma bilgi verilmesini saygılarımla arz ederim.'}

${ekler()}
Tarih: ${tarihBugun()}

${kimlikBolumu()}
İmza:
''';
  }

  String isci() {
    final kurum =
        v('kurum').isEmpty ? 'İLGİLİ MAKAMA' : v('kurum').toUpperCase();

    return '''
$kurum

KONU: ${v('konu').isEmpty ? 'Çalışma ilişkisinden kaynaklanan başvuru ve taleplerim' : v('konu')}

AÇIKLAMALAR:

Çalışma ilişkim kapsamında yaşadığım uyuşmazlık / sorun aşağıdaki şekildedir:

${resmiAciklama(v('olay'))}

${v('neden').isEmpty ? '' : 'Konuya ilişkin ayrıca dikkate alınmasını istediğim hususlar:\n\n${resmiAciklama(v('neden'))}'}

Varsa işyeri kayıtları, ücret bordroları, vardiya/nöbet kayıtları, yazışmalar ve diğer belgelerin de inceleme kapsamında değerlendirilmesini talep ederim.

SONUÇ VE TALEP:

${v('talep').isEmpty ? 'Çalışma ilişkisinden kaynaklanan başvurumun incelenmesini, hak ve alacaklarım yönünden gerekli işlemlerin yapılmasını ve sonucundan tarafıma bilgi verilmesini saygılarımla arz ederim.' : '${resmiAciklama(v('talep'))} Gereğinin yapılmasını saygılarımla arz ederim.'}

${ekler()}
Tarih: ${tarihBugun()}

${kimlikBolumu()}
İmza:
''';
  }

  String trafik() {
    return '''
GÖREVLİ VE YETKİLİ MERCİE

KONU: Trafik idari yaptırımına ilişkin itiraz / başvuru talebidir.

AÇIKLAMALAR:

${v('kurum').isEmpty ? '' : 'İşlemi Düzenleyen Kurum: ${v('kurum')}'}
${v('tutanak').isEmpty ? '' : 'Tutanak / Seri Sıra No: ${v('tutanak')}'}
${v('teblig').isEmpty ? '' : 'Tebliğ / Öğrenme Tarihi: ${v('teblig')}'}
${v('ceza').isEmpty ? '' : 'Ceza / Yaptırım: ${v('ceza')}'}
${v('yer').isEmpty ? '' : 'Yer: ${v('yer')}'}

İtirazıma konu işlemin hatalı olduğunu düşündüğüm nedenler şöyledir:

${resmiAciklama(v('olay'))}

${v('delil').isEmpty ? '' : 'İtirazımı desteklediğini düşündüğüm bilgi ve belgeler: ${v('delil')}.'}

SONUÇ VE TALEP:

Yukarıda açıkladığım hususlar ve sunulan belgeler kapsamında itiraza konu idari yaptırımın incelenmesini ve hukuki şartları oluşmuş ise kaldırılmasına / iptaline karar verilmesini saygılarımla arz ve talep ederim.

Tarih: ${tarihBugun()}

${kimlikBolumu()}
İmza:

NOT: Başvuru mercii ve süre, yaptırımın türü ve tebliğ şekline göre değişebileceğinden resmî başvuru öncesinde güncel mevzuat ve tebligat bilgileri kontrol edilmelidir.
''';
  }

  String kaza() {
    return '''
TRAFİK KAZASI OLAY BEYANI / TUTANAK TASLAĞI

Olay Tarihi ve Saati: ${v('tarih')}
Olay Yeri: ${v('yer')}

ARAÇ VE TARAF BİLGİLERİ:

1. Araç / Plaka:
${v('arac1')}

2. Araç / Plaka:
${v('arac2')}

OLAYIN OLUŞ ŞEKLİ:

${resmiAciklama(v('olay'))}

HASAR VE TESPİTLER:

${v('hasar').isEmpty ? 'Tespit edilen hasarlar ayrıca belirtilmemiştir.' : resmiAciklama(v('hasar'))}

${v('tanik').isEmpty ? '' : 'TANIK / DİĞER BİLGİLER:\n${v('tanik')}\n'}

İşbu olay beyanı, kazanın oluş şekline ilişkin bilgilerin kayıt altına alınması amacıyla düzenlenmiştir.

Düzenleme Tarihi: ${tarihBugun()}

${kimlikBolumu()}
İmza:

NOT: Bu taslak, mevzuat gereği zorunlu olan resmî kaza tespit işlemlerinin yerine geçtiği anlamına gelmez.
''';
  }

  String gsm() {
    final op =
        v('operator').isEmpty ? 'İLGİLİ İŞLETMECİYE' : '${v('operator').toUpperCase()} GENEL MÜDÜRLÜĞÜNE';

    return '''
$op

KONU: Abonelik / hizmet şikâyeti ve çözüm talebi

${v('abone').isEmpty ? '' : 'Abone / Müşteri / Hat No: ${v('abone')}'}

AÇIKLAMALAR:

Tarafıma sunulan elektronik haberleşme / internet hizmeti kapsamında aşağıda açıkladığım sorun yaşanmaktadır:

${resmiAciklama(v('sorun'))}

${v('basvuru').isEmpty ? '' : 'Sorunun çözümü amacıyla daha önce işletmeciye yaptığım başvuruya ilişkin bilgiler şöyledir:\n\n${resmiAciklama(v('basvuru'))}'}

Yaşanan sorunun abonelik kayıtları, faturalandırma bilgileri, teknik kayıtlar ve önceki başvurularım ile birlikte incelenmesini talep etmekteyim.

SONUÇ VE TALEP:

${v('talep').isEmpty ? 'Şikâyetime konu sorunun incelenmesini, gerekli düzeltmenin yapılmasını ve sonucundan tarafıma yazılı olarak bilgi verilmesini saygılarımla arz ederim.' : '${resmiAciklama(v('talep'))} Başvurumun sonuçlandırılarak tarafıma bilgi verilmesini arz ederim.'}

Tarih: ${tarihBugun()}

${kimlikBolumu()}
İmza:
''';
  }

  String resmiCevap() {
    final kurum =
        v('kurum').isEmpty ? 'İLGİLİ MAKAMA' : v('kurum').toUpperCase();

    return '''
$kurum

İLGİ: ${v('gelenkurum')} tarafından gönderilen ${v('tarih')} tarihli${v('sayi').isEmpty ? '' : ' ve ${v('sayi')} sayılı'} yazı.

KONU: ${v('konu').isEmpty ? 'İlgi yazıya cevap' : v('konu')}

İlgi yazıda ${v('icerik').isEmpty ? 'belirtilen hususlara' : v('icerik')} ilişkin olarak açıklamalarımız / açıklamalarım aşağıda sunulmuştur.

${resmiAciklama(v('cevap'))}

Yukarıda açıklanan hususların ilgi yazı kapsamında değerlendirilmesi hususunda bilgilerinize arz ederim.

Tarih: ${tarihBugun()}

${kimlikBolumu()}
İmza:
''';
  }

  String yonetimKarari(bool sendika) {
    final tur = sendika ? 'SENDİKA' : 'DERNEK';

    return '''
${v('kurulus').isEmpty ? tur : v('kurulus').toUpperCase()}

YÖNETİM KURULU KARARI

Karar Tarihi: ${v('tarih')}
Karar No: ${v('kararno')}

Toplantıya Katılanlar:
${v('katilan')}

GÜNDEM:
${v('gundem')}

GÖRÜŞME:

Yönetim Kurulu, yukarıda belirtilen gündem maddesini görüşmek üzere toplanmıştır.

${resmiAciklama(v('gorusme'))}

Yapılan görüşme ve değerlendirmeler sonucunda aşağıdaki karar alınmıştır.

KARAR:

${resmiAciklama(v('karar'))}

Yukarıda belirtilen kararın uygulanması ve gerekli iş ve işlemlerin yürütülmesi hususunda ${v('oy').isEmpty ? 'karar verilmiştir' : '${v('oy')} ile karar verilmiştir'}.

Başkan
Ad Soyad / İmza

Üye
Ad Soyad / İmza

Üye
Ad Soyad / İmza
''';
  }

  String tuzuk(bool sendika) {
    final tur = sendika ? 'SENDİKA' : 'DERNEK';

    return '''
${v('kurulus').isEmpty ? tur : v('kurulus').toUpperCase()} TÜZÜĞÜ TASLAĞI

MADDE 1 – ADI VE MERKEZİ

Kuruluşun adı: ${v('kurulus')}
Merkezi: ${v('merkez')}

MADDE 2 – AMAÇ

${resmiAciklama(v('amac'))}

MADDE 3 – FAALİYET KONULARI

${resmiAciklama(v('faaliyet'))}

MADDE 4 – ÜYELİK

${resmiAciklama(v('uyelik'))}

MADDE 5 – ÜYELİĞİN SONA ERMESİ

Üyeliğin sona ermesi; istifa, üyelik şartlarının kaybedilmesi ve ilgili mevzuat ile bu tüzükte öngörülen diğer hâllerde gerçekleşir. Ayrıntılı usul ve esaslar kuruluşun niteliğine ve güncel mevzuata göre düzenlenir.

MADDE 6 – ORGANLAR

${v('organlar').isEmpty ? 'Kuruluşun zorunlu ve ihtiyari organları ilgili mevzuat çerçevesinde oluşturulur.' : resmiAciklama(v('organlar'))}

MADDE 7 – GENEL KURUL

Genel kurulun oluşumu, toplantı zamanı, çağrı usulü, toplantı ve karar yeter sayıları yürürlükteki mevzuat ve bu tüzük hükümlerine göre belirlenir.

MADDE 8 – YÖNETİM KURULU

Yönetim kurulu, kuruluşun idari ve mali işlerini yürütür; genel kurul kararlarını uygular ve kuruluşu ilgili mevzuat ile tüzük hükümleri çerçevesinde temsil eder.

MADDE 9 – DENETİM

Kuruluşun faaliyetleri ve mali işlemleri ilgili mevzuat ve tüzük hükümleri çerçevesinde denetlenir.

MADDE 10 – MALİ HÜKÜMLER

Gelir, gider, bütçe, aidat ve mali işlemler ilgili mevzuat ile genel kurul kararları doğrultusunda yürütülür.

MADDE 11 – TÜZÜK DEĞİŞİKLİĞİ

Tüzük değişiklikleri yetkili organ tarafından, yürürlükteki mevzuatta ve bu tüzükte belirtilen usule göre gerçekleştirilir.

MADDE 12 – FESİH / SONA ERME

Kuruluşun sona ermesi ve malvarlığının tasfiyesi yürürlükteki mevzuat ve genel kurul kararları doğrultusunda gerçekleştirilir.

GEÇİCİ VE SON HÜKÜMLER

Bu tüzükte hüküm bulunmayan hâllerde yürürlükteki ilgili mevzuat hükümleri uygulanır.

NOT: Bu metin tüzük taslağıdır. Kuruluş, değişiklik ve resmî başvuru öncesinde güncel mevzuata göre kontrol edilmelidir.
''';
  }

  String dernekUyelik() {
    return '''
${v('dernek').isEmpty ? 'İLGİLİ DERNEK BAŞKANLIĞINA' : '${v('dernek').toUpperCase()} BAŞKANLIĞINA'}

KONU: ${v('islem').isEmpty ? 'Dernek işlemi hakkında başvuru' : v('islem')}

AÇIKLAMALAR:

${resmiAciklama(v('olay'))}

SONUÇ VE TALEP:

${v('talep').isEmpty ? 'Yukarıda açıkladığım hususlar doğrultusunda gerekli işlemin yapılmasını saygılarımla arz ederim.' : '${resmiAciklama(v('talep'))} Gereğinin yapılmasını saygılarımla arz ederim.'}

Tarih: ${tarihBugun()}

${kimlikBolumu()}
İmza:
''';
  }

  String belgeOlustur() {
    switch (widget.belge.kategori) {
      case 'savunma':
        return savunma();
      case 'sikayet':
        return sikayet();
      case 'mobbing':
        return mobbing();
      case 'isci':
        return isci();
      case 'trafik':
        return trafik();
      case 'kaza':
        return kaza();
      case 'gsm':
        return gsm();
      case 'cevap':
        return resmiCevap();
      case 'sendikakarar':
        return yonetimKarari(true);
      case 'dernekkarar':
        return yonetimKarari(false);
      case 'sendikatuzuk':
        return tuzuk(true);
      case 'dernektuzuk':
        return tuzuk(false);
      case 'dernekuyelik':
        return dernekUyelik();
      case 'sendikayazi':
      case 'hukuk':
      case 'tuketici':
      case 'kamu':
      case 'dilekce':
      default:
        return dilekce();
    }
  }

  void hazirla() {
    final metin = belgeOlustur();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SonucSayfasi(
          baslik: widget.belge.baslik,
          metin: metin,
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (final x in c.values) {
      x.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.belge.baslik,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Bilgileri mümkün olduğunca açık yazın. '
                'Olayı günlük dille anlatabilirsiniz; belge uygun resmî yapıda hazırlanacaktır.',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
          const SizedBox(height: 12),
          ...formaGoreAlanlar(),
          const SizedBox(height: 4),
          FilledButton.icon(
            onPressed: hazirla,
            icon: const Icon(Icons.auto_awesome),
            label: const Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Text(
                'Belgeyi Hazırla',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

class SonucSayfasi extends StatelessWidget {
  final String baslik;
  final String metin;

  const SonucSayfasi({
    super.key,
    required this.baslik,
    required this.metin,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          baslik,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Hazırlanan Belge',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black38),
              borderRadius: BorderRadius.circular(14),
            ),
            child: SelectableText(
              metin,
              style: const TextStyle(
                fontSize: 16,
                height: 1.55,
              ),
            ),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: () async {
              await Clipboard.setData(ClipboardData(text: metin));
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Belge metni panoya kopyalandı.'),
                  ),
                );
              }
            },
            icon: const Icon(Icons.copy),
            label: const Padding(
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Text('Metni Kopyala'),
            ),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.edit_outlined),
            label: const Text('Bilgileri Düzenle'),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
