import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const DilekceAsistani());
}

class DilekceAsistani extends StatelessWidget {
  const DilekceAsistani({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dilekçe Asistanı',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF3F518C),
        scaffoldBackgroundColor: const Color(0xFFF7F6FC),
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

class Islem {
  final String baslik;
  final String aciklama;
  final IconData ikon;
  final String tur;

  const Islem(this.baslik, this.aciklama, this.ikon, this.tur);
}

class AnaSayfa extends StatelessWidget {
  const AnaSayfa({super.key});

  static const islemler = [
    Islem('Genel Dilekçe', 'Sorununuzu anlatın, dilekçeniz hazırlansın.',
        Icons.description_outlined, 'dilekce'),
    Islem('Şikâyet / İtiraz', 'Kurum veya kişiyle ilgili başvuru hazırlayın.',
        Icons.report_outlined, 'sikayet'),
    Islem('Savunma Hazırla', 'Olayı anlatın, resmî savunma oluşturun.',
        Icons.shield_outlined, 'savunma'),
    Islem('Trafik Cezasına İtiraz', 'Ceza ve tebliğ bilgileriyle itiraz hazırlayın.',
        Icons.traffic_outlined, 'trafik'),
    Islem('Kaza Olay Beyanı', 'Kaza anını anlatın, olay beyanı oluşturun.',
        Icons.car_crash_outlined, 'kaza'),
    Islem('İşçi / Çalışma Hayatı', 'Mobbing, ücret ve işyeri sorunları.',
        Icons.work_outline, 'isci'),
    Islem('GSM / İnternet', 'Operatör, fatura, arıza ve abonelik sorunları.',
        Icons.wifi_outlined, 'gsm'),
    Islem('Mahkeme / Hukuki Başvuru', 'Olayınızı anlatın, başvuru taslağı hazırlayın.',
        Icons.account_balance_outlined, 'hukuk'),
    Islem('Gelen Resmî Yazıya Cevap', 'Size gelen yazıya resmî cevap hazırlayın.',
        Icons.mark_email_read_outlined, 'cevap'),
    Islem('Sendika İşlemleri', 'Sendikal yazışma ve başvurular.',
        Icons.groups_outlined, 'sendika'),
    Islem('Dernek İşlemleri', 'Dernek yazışmaları ve başvuruları.',
        Icons.people_outline, 'dernek'),
    Islem('Yönetim Kurulu Kararı', 'Karar defterine uygun karar taslağı.',
        Icons.fact_check_outlined, 'karar'),
    Islem('Sendika Tüzüğü', 'Sendika tüzüğü taslağı oluşturun.',
        Icons.menu_book_outlined, 'sendikaTuzuk'),
    Islem('Dernek Tüzüğü', 'Dernek tüzüğü taslağı oluşturun.',
        Icons.library_books_outlined, 'dernekTuzuk'),
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
            onPressed: () => showAboutDialog(
              context: context,
              applicationName: 'Dilekçe Asistanı',
              applicationVersion: '1.0',
              children: const [
                Text('Resmî belge ve dilekçe hazırlama yardımcısı.'),
                SizedBox(height: 8),
                Text(
                  'Geliştiren: Fatih Demirel',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
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
                    'Ne hazırlamak istiyorsunuz?',
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'İşlem türünü seçin ve yaşadığınız durumu anlatın. '
                    'Uygulama bilgilerinizi resmî belge düzenine dönüştürür.',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          ...islemler.map(
            (e) => Card(
              child: ListTile(
                leading: CircleAvatar(child: Icon(e.ikon)),
                title: Text(
                  e.baslik,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(e.aciklama),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => e.tur == 'karar'
                          ? const KararFormu()
                          : e.tur == 'sendikaTuzuk' ||
                                  e.tur == 'dernekTuzuk'
                              ? TuzukFormu(tur: e.tur)
                              : DilekceFormu(islem: e),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Center(
            child: Text(
              'Geliştiren: Fatih Demirel',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class DilekceFormu extends StatefulWidget {
  final Islem islem;
  const DilekceFormu({super.key, required this.islem});

  @override
  State<DilekceFormu> createState() => _DilekceFormuState();
}

class _DilekceFormuState extends State<DilekceFormu> {
  final ad = TextEditingController();
  final kimlik = TextEditingController();
  final adres = TextEditingController();
  final telefon = TextEditingController();
  final kurum = TextEditingController();
  final olay = TextEditingController();
  final detay = TextEditingController();

  @override
  void dispose() {
    for (final c in [ad, kimlik, adres, telefon, kurum, olay, detay]) {
      c.dispose();
    }
    super.dispose();
  }

  String yardimciAlan() {
    switch (widget.islem.tur) {
      case 'trafik':
        return 'Ceza tarihi, tebliğ tarihi, plaka, tutanak/seri no ve itiraz nedeniniz';
      case 'kaza':
        return 'Kaza tarihi-saati, yer, araç/plaka, karşı taraf, hasar ve varsa tanık bilgileri';
      case 'gsm':
        return 'Operatör, abonelik/hat no, fatura, arıza veya iptal bilgileri';
      case 'cevap':
        return 'Gelen yazının tarihi, sayısı, konusu ve cevap vermek istediğiniz hususlar';
      case 'isci':
        return 'İşyeri, görev, olay tarihleri, ücret/mobbing/çalışma sorunu ve varsa belgeler';
      case 'hukuk':
        return 'Karşı taraf, olay tarihi, uyuşmazlık türü ve elinizdeki belgeler';
      case 'sendika':
        return 'Sendika adı, üyelik/yönetim bilgisi, işlem veya gelen yazının ayrıntıları';
      case 'dernek':
        return 'Dernek adı, görev/üyelik bilgisi ve yapılacak işlemin ayrıntıları';
      default:
        return 'Varsa tarih, sayı, belge, tanık veya diğer önemli bilgiler';
    }
  }

  String merci() {
    switch (widget.islem.tur) {
      case 'trafik':
        return 'İlgili başvuru mercii';
      case 'gsm':
        return kurum.text.trim().isEmpty
            ? 'İLGİLİ GSM / İNTERNET HİZMET SAĞLAYICISINA'
            : kurum.text.trim().toUpperCase();
      case 'isci':
        return kurum.text.trim().isEmpty
            ? 'İLGİLİ MAKAMA'
            : kurum.text.trim().toUpperCase();
      default:
        return kurum.text.trim().isEmpty
            ? 'İLGİLİ MAKAMA'
            : kurum.text.trim().toUpperCase();
    }
  }

  String konu() {
    switch (widget.islem.tur) {
      case 'trafik':
        return 'İdari yaptırım / trafik cezasına itiraz hakkında';
      case 'kaza':
        return 'Trafik kazasına ilişkin olay beyanı';
      case 'savunma':
        return 'Savunmalarımın sunulması hakkında';
      case 'sikayet':
        return 'Şikâyet ve gerekli işlemlerin yapılması talebi';
      case 'isci':
        return 'Çalışma koşullarına ilişkin başvuru';
      case 'gsm':
        return 'Hizmet / abonelik uyuşmazlığının giderilmesi talebi';
      case 'hukuk':
        return 'Hukuki uyuşmazlığa ilişkin başvuru';
      case 'cevap':
        return 'Tarafıma gönderilen yazıya cevabım';
      case 'sendika':
        return 'Sendikal işleme ilişkin başvuru';
      case 'dernek':
        return 'Dernek işlemine ilişkin başvuru';
      default:
        return 'Başvuru ve talep hakkında';
    }
  }

  String aciklamaMetni() {
    final o = olay.text.trim();
    final d = detay.text.trim();

    switch (widget.islem.tur) {
      case 'savunma':
        return 'Tarafımdan savunma istenmesine konu olayla ilgili olarak; '
            '$o\n\n'
            'Olayın gerçekleşme biçimi ve mevcut koşullar birlikte '
            'değerlendirildiğinde, açıklamalarımın bir bütün olarak dikkate '
            'alınmasını talep ederim.'
            '${d.isEmpty ? '' : '\n\nKonuya ilişkin ek bilgiler: $d'}';

      case 'sikayet':
        return 'Başvuruma konu olay ve uygulamalar özetle şöyledir:\n\n'
            '$o\n\n'
            'Belirttiğim hususların tarafsız biçimde incelenerek iddiaların '
            've mevcut uygulamaların araştırılmasını talep etmekteyim.'
            '${d.isEmpty ? '' : '\n\nBaşvuruyu destekleyen diğer bilgiler: $d'}';

      case 'isci':
        return 'Çalışma ilişkim kapsamında yaşadığım sorun aşağıda '
            'açıklanmıştır:\n\n$o\n\n'
            'Çalışma koşullarım, işyeri uygulamaları ve tarafıma yönelik '
            'işlemlerin ilgili mevzuat ve işyeri düzenlemeleri kapsamında '
            'incelenmesini talep etmekteyim.'
            '${d.isEmpty ? '' : '\n\nDiğer bilgiler ve belgeler: $d'}';

      case 'gsm':
        return 'Abonelik/hizmet ilişkim kapsamında yaşadığım sorun şöyledir:\n\n'
            '$o\n\n'
            'Belirtilen hizmet sorununun ve varsa hatalı ücretlendirme, '
            'fatura, taahhüt, fesih veya bağlantı işlemlerinin incelenerek '
            'mağduriyetimin giderilmesini talep ederim.'
            '${d.isEmpty ? '' : '\n\nAboneliğe ilişkin diğer bilgiler: $d'}';

      case 'trafik':
        return 'Tarafıma uygulanan idari yaptırıma ilişkin olay ve itiraz '
            'nedenlerim şöyledir:\n\n$o\n\n'
            'İşlemin dayanağı, düzenlenme ve tebliğ koşulları ile sunduğum '
            'açıklama ve belgelerin birlikte değerlendirilmesini talep ederim.'
            '${d.isEmpty ? '' : '\n\nCeza ve tebliğe ilişkin bilgiler: $d'}';

      case 'kaza':
        return 'Kaza olayına ilişkin bilgim ve beyanım şöyledir:\n\n$o'
            '${d.isEmpty ? '' : '\n\nKaza, araç, hasar ve diğer bilgiler: $d'}'
            '\n\nİşbu beyan, olayın gerçekleşme biçimine ilişkin bildiğim '
            'hususların kayıt altına alınması amacıyla düzenlenmiştir.';

      case 'cevap':
        return 'Tarafıma gönderilen resmî yazıda belirtilen hususlara ilişkin '
            'açıklamalarım aşağıdadır:\n\n$o'
            '${d.isEmpty ? '' : '\n\nİlgili yazı ve diğer bilgiler: $d'}'
            '\n\nYukarıdaki açıklamalarımın ilgili yazı kapsamında '
            'değerlendirilmesini arz ederim.';

      case 'hukuk':
        return 'Başvuruma konu uyuşmazlık ve olaylar özetle şöyledir:\n\n$o'
            '${d.isEmpty ? '' : '\n\nUyuşmazlığa ilişkin diğer bilgiler ve belgeler: $d'}'
            '\n\nBelirttiğim olaylar ve mevcut belgeler çerçevesinde '
            'haklarımın korunması amacıyla gerekli değerlendirmenin '
            'yapılmasını talep ederim.';

      case 'sendika':
        return 'Sendikal işleme konu durum şöyledir:\n\n$o'
            '${d.isEmpty ? '' : '\n\nİşleme ilişkin diğer bilgiler: $d'}'
            '\n\nBelirtilen hususların sendika mevzuatı, tüzük ve ilgili '
            'düzenlemeler kapsamında değerlendirilerek gerekli işlemin '
            'yapılmasını talep ederim.';

      case 'dernek':
        return 'Dernek iş ve işlemlerine konu durum şöyledir:\n\n$o'
            '${d.isEmpty ? '' : '\n\nİşleme ilişkin diğer bilgiler: $d'}'
            '\n\nBelirtilen hususların dernek tüzüğü ve ilgili düzenlemeler '
            'çerçevesinde değerlendirilmesini talep ederim.';

      default:
        return 'Aşağıda açıkladığım husus hakkında başvuruda bulunma gereği '
            'doğmuştur:\n\n$o'
            '${d.isEmpty ? '' : '\n\nKonuya ilişkin diğer bilgiler: $d'}'
            '\n\nBelirttiğim hususların incelenerek gerekli işlemlerin '
            'yapılmasını talep ederim.';
    }
  }

  String sonuc() {
    switch (widget.islem.tur) {
      case 'savunma':
        return 'Yukarıda arz ettiğim açıklamalarımın savunmam kapsamında '
            'değerlendirilmesini ve hakkımda yapılacak işlemde tüm bilgi ve '
            'belgelerin birlikte dikkate alınmasını arz ederim.';
      case 'trafik':
        return 'Yukarıda açıkladığım nedenler ve sunulan belgeler kapsamında '
            'itirazımın incelenerek hukuka aykırı olduğu değerlendirilecek '
            'işlemin kaldırılmasına karar verilmesini saygılarımla arz ve talep ederim.';
      case 'kaza':
        return 'Yukarıdaki bilgilerin olay beyanım olarak dikkate alınmasını '
            've gerektiğinde ilgili kayıt ve belgelerle birlikte '
            'değerlendirilmesini arz ederim.';
      case 'sikayet':
        return 'Yukarıda açıkladığım hususların araştırılmasını, gerekli '
            'incelemenin yapılmasını ve sonucundan tarafıma bilgi verilmesini '
            'saygılarımla arz ederim.';
      case 'gsm':
        return 'Sorunun incelenerek hizmetin gereği gibi sağlanmasını, varsa '
            'hatalı işlemlerin düzeltilmesini ve başvurumun sonucu hakkında '
            'tarafıma bilgi verilmesini arz ve talep ederim.';
      default:
        return 'Yukarıda açıkladığım hususların incelenerek gerekli işlemlerin '
            'yapılmasını ve başvurumun sonucu hakkında tarafıma bilgi '
            'verilmesini saygılarımla arz ederim.';
    }
  }

  void hazirla() {
    if (olay.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Önce yaşadığınız durumu anlatın.')),
      );
      return;
    }

    final now = DateTime.now();
    final tarih =
        '${now.day.toString().padLeft(2, '0')}.${now.month.toString().padLeft(2, '0')}.${now.year}';

    final metin = '''
${merci()}

KONU: ${konu()}

AÇIKLAMALAR:

${aciklamaMetni()}

SONUÇ VE TALEP:

${sonuc()}

Tarih: $tarih

Ad Soyad: ${ad.text.trim()}
${kimlik.text.trim().isEmpty ? '' : 'T.C. Kimlik No: ${kimlik.text.trim()}\n'}${adres.text.trim().isEmpty ? '' : 'Adres: ${adres.text.trim()}\n'}${telefon.text.trim().isEmpty ? '' : 'Telefon: ${telefon.text.trim()}\n'}
İmza:
''';

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SonucSayfasi(
          baslik: widget.islem.baslik,
          metin: metin,
          uyari: widget.islem.tur == 'hukuk' ||
                  widget.islem.tur == 'trafik'
              ? 'Görevli/yetkili merci, başvuru süresi ve güncel mevzuat işlem yapılmadan önce ayrıca kontrol edilmelidir.'
              : null,
        ),
      ),
    );
  }

  Widget alan(
    TextEditingController c,
    String label, {
    int satir = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: c,
        maxLines: satir,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.islem.baslik)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Durumu kendi cümlelerinizle anlatın',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Uzun ve resmî yazmanıza gerek yok. Ne olduğunu açıkça anlatmanız yeterli.',
          ),
          const SizedBox(height: 18),
          alan(
            olay,
            widget.islem.tur == 'cevap'
                ? 'Gelen yazı ne diyor, siz ne cevap vermek istiyorsunuz?'
                : 'Ne oldu? Sorununuzu anlatın',
            satir: 7,
          ),
          alan(detay, yardimciAlan(), satir: 4),
          const Divider(height: 30),
          Text(
            'Başvuru bilgileri',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          alan(kurum, 'Başvurulacak kurum / kuruluş'),
          alan(ad, 'Ad Soyad'),
          alan(kimlik, 'T.C. / Kimlik No (gerekiyorsa)'),
          alan(adres, 'Adres', satir: 2),
          alan(telefon, 'Telefon'),
          const SizedBox(height: 8),
          FilledButton.icon(
            onPressed: hazirla,
            icon: const Icon(Icons.auto_awesome),
            label: const Padding(
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Text('Dilekçeyi Hazırla'),
            ),
          ),
        ],
      ),
    );
  }
}

class KararFormu extends StatefulWidget {
  const KararFormu({super.key});

  @override
  State<KararFormu> createState() => _KararFormuState();
}

class _KararFormuState extends State<KararFormu> {
  final kurum = TextEditingController();
  final tarih = TextEditingController();
  final no = TextEditingController();
  final katilanlar = TextEditingController();
  final gundem = TextEditingController();
  final aciklama = TextEditingController();
  final karar = TextEditingController();

  Widget alan(TextEditingController c, String l, {int satir = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: c,
        maxLines: satir,
        decoration: InputDecoration(labelText: l),
      ),
    );
  }

  void hazirla() {
    if (kurum.text.trim().isEmpty || karar.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Kurum adı ve alınan kararı yazın.')),
      );
      return;
    }

    final metin = '''
${kurum.text.trim().toUpperCase()}

YÖNETİM KURULU KARARI

Karar Tarihi: ${tarih.text.trim()}
Karar No: ${no.text.trim()}

Toplantıya Katılanlar:
${katilanlar.text.trim()}

GÜNDEM:
${gundem.text.trim()}

GÖRÜŞME:
${aciklama.text.trim()}

KARAR:
${karar.text.trim()}

Yukarıda belirtilen husus yönetim kurulunca görüşülmüş ve karar altına alınmıştır.

İMZALAR

Başkan: ____________________

Başkan Yardımcısı: ____________________

Sekreter: ____________________

Üye: ____________________

Üye: ____________________
''';

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            SonucSayfasi(baslik: 'Yönetim Kurulu Kararı', metin: metin),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Yönetim Kurulu Kararı')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Karar Bilgileri',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          alan(kurum, 'Sendika / Dernek / Kuruluş adı'),
          alan(tarih, 'Karar / toplantı tarihi'),
          alan(no, 'Karar numarası'),
          alan(katilanlar, 'Toplantıya katılan üyeler', satir: 3),
          alan(gundem, 'Gündem maddesi', satir: 3),
          alan(
            aciklama,
            'Konu nasıl görüşüldü? Kısaca anlatın',
            satir: 5,
          ),
          alan(
            karar,
            'Ne karar alındı? Kendi cümlelerinizle yazın',
            satir: 5,
          ),
          FilledButton.icon(
            onPressed: hazirla,
            icon: const Icon(Icons.fact_check),
            label: const Padding(
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Text('Kararı Hazırla'),
            ),
          ),
        ],
      ),
    );
  }
}

class TuzukFormu extends StatefulWidget {
  final String tur;
  const TuzukFormu({super.key, required this.tur});

  @override
  State<TuzukFormu> createState() => _TuzukFormuState();
}

class _TuzukFormuState extends State<TuzukFormu> {
  final ad = TextEditingController();
  final merkez = TextEditingController();
  final amac = TextEditingController();
  final faaliyet = TextEditingController();
  final uyelik = TextEditingController();
  final organlar = TextEditingController();

  Widget alan(TextEditingController c, String l, {int satir = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: c,
        maxLines: satir,
        decoration: InputDecoration(labelText: l),
      ),
    );
  }

  void hazirla() {
    if (ad.text.trim().isEmpty || amac.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Kuruluş adı ve kuruluş amacını yazın.'),
        ),
      );
      return;
    }

    final sendika = widget.tur == 'sendikaTuzuk';
    final turAdi = sendika ? 'SENDİKA' : 'DERNEK';

    final metin = '''
${ad.text.trim().toUpperCase()} $turAdi TÜZÜĞÜ

MADDE 1 - ADI VE MERKEZİ
Kuruluşun adı "${ad.text.trim()}"dır.
Merkezi: ${merkez.text.trim()}.

MADDE 2 - AMAÇ
${amac.text.trim()}

MADDE 3 - FAALİYETLER
${faaliyet.text.trim()}

MADDE 4 - ÜYELİK
${uyelik.text.trim().isEmpty ? 'Üyeliğe kabul, üyelikten ayrılma ve üyeliğin sona ermesine ilişkin işlemler ilgili mevzuat ve bu tüzük hükümleri çerçevesinde yürütülür.' : uyelik.text.trim()}

MADDE 5 - ORGANLAR
${organlar.text.trim().isEmpty ? 'Kuruluşun zorunlu organları genel kurul, yönetim kurulu ve denetim kuruludur. Gerekli diğer organlar tüzük hükümleri doğrultusunda oluşturulabilir.' : organlar.text.trim()}

MADDE 6 - GENEL KURUL
Genel kurulun oluşumu, toplantı zamanı, çağrı usulü, toplantı ve karar yeter sayıları ilgili mevzuat ile bu tüzük hükümlerine göre belirlenir.

MADDE 7 - YÖNETİM KURULU
Yönetim kurulu, kuruluşun yönetim ve temsil organıdır. Görev ve yetkilerini mevzuat, genel kurul kararları ve bu tüzük hükümleri çerçevesinde kullanır.

MADDE 8 - DENETİM
Kuruluşun faaliyet ve hesapları, ilgili mevzuat ve tüzük hükümleri çerçevesinde denetlenir.

MADDE 9 - GELİRLER VE MALİ HÜKÜMLER
Gelirlerin elde edilmesi, giderlerin yapılması, kayıt ve belgelerin tutulması ilgili mevzuata uygun olarak yürütülür.

MADDE 10 - TÜZÜK DEĞİŞİKLİĞİ
Tüzük değişiklikleri yetkili organ tarafından, ilgili mevzuatta ve bu tüzükte belirtilen usul ve çoğunluklara uygun olarak yapılır.

MADDE 11 - FESİH VE TASFİYE
Kuruluşun sona ermesi, feshi ve malvarlığının tasfiyesi ilgili mevzuat ve genel kurul kararları doğrultusunda gerçekleştirilir.

MADDE 12 - HÜKÜM BULUNMAYAN HALLER
Bu tüzükte hüküm bulunmayan konularda yürürlükteki ilgili mevzuat hükümleri uygulanır.
''';

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SonucSayfasi(
          baslik: '$turAdi Tüzüğü Taslağı',
          metin: metin,
          uyari:
              'Tüzük, resmî kuruluş veya değişiklik işleminden önce kuruluş türüne ilişkin güncel mevzuata göre kontrol edilmelidir.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final sendika = widget.tur == 'sendikaTuzuk';

    return Scaffold(
      appBar: AppBar(
        title: Text(sendika ? 'Sendika Tüzüğü' : 'Dernek Tüzüğü'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            '${sendika ? 'Sendika' : 'Dernek'} bilgilerini anlatın',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          alan(ad, '${sendika ? 'Sendika' : 'Dernek'} adı'),
          alan(merkez, 'Merkezi'),
          alan(amac, 'Kuruluş amacı nedir?', satir: 5),
          alan(faaliyet, 'Hangi faaliyetleri yapacak?', satir: 5),
          alan(uyelik, 'Üyelik şartlarını anlatın', satir: 4),
          alan(organlar, 'Organlar ve yönetim yapısı', satir: 4),
          FilledButton.icon(
            onPressed: hazirla,
            icon: const Icon(Icons.menu_book),
            label: const Padding(
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Text('Tüzük Taslağını Hazırla'),
            ),
          ),
        ],
      ),
    );
  }
}

class SonucSayfasi extends StatelessWidget {
  final String baslik;
  final String metin;
  final String? uyari;

  const SonucSayfasi({
    super.key,
    required this.baslik,
    required this.metin,
    this.uyari,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(baslik)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (uyari != null)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.info_outline),
                    const SizedBox(width: 10),
                    Expanded(child: Text(uyari!)),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 8),
          const Text(
            'Hazırlanan Belge',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black38),
              borderRadius: BorderRadius.circular(10),
            ),
            child: SelectableText(
              metin,
              style: const TextStyle(fontSize: 16, height: 1.55),
            ),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: () async {
              await Clipboard.setData(ClipboardData(text: metin));
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Belge panoya kopyalandı.')),
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
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
