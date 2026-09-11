import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const DilekceAsistani());

class DilekceAsistani extends StatelessWidget {
  const DilekceAsistani({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dilekçe Asistanı',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const AnaSayfa(),
    );
  }
}

class Belge {
  final String baslik;
  final String aciklama;
  final String merci;
  final String tur;

  const Belge(this.baslik, this.aciklama, this.merci, this.tur);
}

const kategoriler = <String, List<Belge>>{
  'Trafik & Kaza': [
    Belge(
      'Kaza Olay Beyanı / Tutanak',
      'Polis gelmediğinde olayın ayrıntılarını yazılı hale getirin.',
      'Sigorta, kolluk veya ilgili kuruma sunulabilecek olay beyanı/tutanak taslağıdır. Resmî zorunlu kaza tespit tutanağının yerine geçtiği varsayılmamalıdır.',
      'kaza',
    ),
    Belge(
      'Trafik Cezasına İtiraz',
      'Ceza ve tebliğ bilgilerine göre itiraz taslağı hazırlayın.',
      'Başvuru mercii ve süresi yaptırım türüne ve güncel mevzuata göre doğrulanmalıdır.',
      'trafik',
    ),
  ],
  'Mahkeme & Hukuk': [
    Belge(
      'Genel Hukuki Başvuru',
      'Olayı anlatın ve başvuru taslağı oluşturun.',
      'Görevli ve yetkili mahkeme veya merci olayın niteliğine göre değişebilir.',
      'hukuk',
    ),
    Belge(
      'Tüketici Uyuşmazlığı',
      'Mal veya hizmet uyuşmazlığı için başvuru hazırlayın.',
      'Uyuşmazlığın niteliği ve güncel parasal sınırlara göre Tüketici Hakem Heyeti veya Tüketici Mahkemesi gündeme gelebilir.',
      'tuketici',
    ),
  ],
  'Çalışma Hayatı': [
    Belge(
      'İşçi Şikâyeti / Başvurusu',
      'Ücret, çalışma koşulu ve işçilik sorunları.',
      'İşveren, Çalışma ve Sosyal Güvenlik Bakanlığı veya uyuşmazlığın niteliğine göre ilgili başvuru yolu.',
      'isci',
    ),
    Belge(
      'Savunma',
      'İşyerinde istenen savunmaya cevap hazırlayın.',
      'Savunmayı isteyen işveren veya kurum.',
      'savunma',
    ),
    Belge(
      'Mobbing Başvurusu',
      'Yaşanan olayları tarih ve ayrıntılarıyla yazın.',
      'İşveren ve olayın niteliğine göre ilgili idari veya hukuki başvuru yolları.',
      'mobbing',
    ),
  ],
  'Sendika İşlemleri': [
    Belge(
      'Sendika Resmî Yazısı',
      'Kurumlara gönderilecek resmî yazı.',
      'Muhatap kurum veya kuruluş.',
      'resmiyazi',
    ),
    Belge(
      'Gelen Yazıya Cevap',
      'Bakanlık veya kurumlardan gelen yazıya cevap.',
      'Gelen yazıyı gönderen kurum.',
      'cevap',
    ),
    Belge(
      'Yönetim Kurulu Kararı',
      'Sendika yönetim kurulu karar taslağı.',
      'Sendika kayıt ve karar defteri.',
      'karar',
    ),
    Belge(
      'Sendika Tüzüğü Taslağı',
      'Düzenlenebilir sendika tüzüğü taslağı.',
      'Kuruluş ve değişiklik işlemlerinde güncel mevzuat ayrıca kontrol edilmelidir.',
      'sendikatuzuk',
    ),
  ],
  'Dernek İşlemleri': [
    Belge(
      'Dernek Tüzüğü Taslağı',
      'Düzenlenebilir dernek tüzüğü taslağı.',
      'Kuruluş ve değişiklik işlemlerinde güncel mevzuat kontrol edilmelidir.',
      'dernektuzuk',
    ),
    Belge(
      'Yönetim Kurulu Kararı',
      'Dernek yönetim kurulu karar taslağı.',
      'Dernek karar defteri.',
      'karar',
    ),
    Belge(
      'İstifa Dilekçesi',
      'Başkanlık veya yönetim kurulu üyeliğinden istifa.',
      'Dernek yönetim kuruluna.',
      'istifa',
    ),
    Belge(
      'Yedek Üye Davet / Kabul / Ret',
      'Yedek üyelik işlemleri için belge hazırlayın.',
      'Dernek yönetim kuruluna.',
      'yedek',
    ),
    Belge(
      'Kuruma Bildirim / Cevap',
      'Kamu kurumuna bildirim veya gelen yazıya cevap.',
      'İlgili kamu kurumu.',
      'cevap',
    ),
  ],
  'GSM & İnternet': [
    Belge(
      'Operatör / İnternet Şikâyeti',
      'Türk Telekom, Turkcell, Vodafone ve diğer sağlayıcılar.',
      'Öncelikle hizmet sağlayıcı; uyuşmazlığa göre BTK veya tüketici başvuru yolları değerlendirilebilir.',
      'telekom',
    ),
    Belge(
      'Fatura İtirazı',
      'Hatalı veya beklenmeyen faturaya itiraz.',
      'Hizmet sağlayıcı ve gerektiğinde ilgili tüketici başvuru yolu.',
      'telekom',
    ),
    Belge(
      'İptal / Cayma Bedeli İtirazı',
      'Abonelik iptali ve cayma bedeli uyuşmazlığı.',
      'Hizmet sağlayıcı ve uyuşmazlığa göre ilgili tüketici başvuru yolu.',
      'telekom',
    ),
  ],
  'Kamu & Kurum': [
    Belge(
      'Genel Dilekçe',
      'Üniversite, belediye, bakanlık ve diğer kurumlara.',
      'Seçtiğiniz kurum veya kuruluş.',
      'dilekce',
    ),
    Belge(
      'Resmî Yazı',
      'Kurumsal resmî yazı taslağı.',
      'Muhatap kurum veya kuruluş.',
      'resmiyazi',
    ),
    Belge(
      'Gelen Yazıya Cevap',
      'Kurumdan gelen yazıya cevap hazırlayın.',
      'Gelen yazıyı gönderen kurum.',
      'cevap',
    ),
    Belge(
      'Şikâyet / İtiraz',
      'İdari işlem veya uygulamaya ilişkin başvuru.',
      'İşlemi yapan veya itirazı incelemeye yetkili kurum.',
      'itiraz',
    ),
  ],
};

class AnaSayfa extends StatelessWidget {
  const AnaSayfa({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dilekçe Asistanı'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              showAboutDialog(
                context: context,
                applicationName: 'Dilekçe Asistanı',
                applicationVersion: '1.0',
                children: const [
                  Text('Geliştiren: Fatih Demirel'),
                ],
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Belgenizi seçin',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Bilgilerinizi girin, düzenlenebilir belge taslağınızı hazırlayın.',
          ),
          const SizedBox(height: 16),
          ...kategoriler.entries.map(
            (e) => Card(
              child: ListTile(
                leading: const Icon(Icons.description_outlined),
                title: Text(
                  e.key,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text('${e.value.length} işlem'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SecimSayfasi(e.key, e.value),
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
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 6),
          const Center(
            child: Text(
              'Taslakları resmî işlem öncesinde kontrol edin.',
              style: TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

class SecimSayfasi extends StatelessWidget {
  final String kategori;
  final List<Belge> belgeler;

  const SecimSayfasi(this.kategori, this.belgeler, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(kategori)),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: belgeler.map((b) {
          return Card(
            child: ListTile(
              title: Text(b.baslik),
              subtitle: Text(b.aciklama),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => FormSayfasi(b),
                  ),
                );
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}

class FormSayfasi extends StatefulWidget {
  final Belge belge;

  const FormSayfasi(this.belge, {super.key});

  @override
  State<FormSayfasi> createState() => _FormSayfasiState();
}

class _FormSayfasiState extends State<FormSayfasi> {
  final ad = TextEditingController();
  final kimlik = TextEditingController();
  final adres = TextEditingController();
  final telefon = TextEditingController();
  final kurum = TextEditingController();
  final konu = TextEditingController();
  final olay = TextEditingController();
  final talep = TextEditingController();
  final ek = TextEditingController();

  @override
  void dispose() {
    ad.dispose();
    kimlik.dispose();
    adres.dispose();
    telefon.dispose();
    kurum.dispose();
    konu.dispose();
    olay.dispose();
    talep.dispose();
    ek.dispose();
    super.dispose();
  }

  Widget alan(
    String label,
    TextEditingController controller, {
    int satir = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        maxLines: satir,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  String tarih() {
    final d = DateTime.now();
    return '${d.day.toString().padLeft(2, '0')}.'
        '${d.month.toString().padLeft(2, '0')}.${d.year}';
  }

  String govde() {
    switch (widget.belge.tur) {
      case 'kaza':
        return '''
KONU: ${konu.text}

OLAY VE TESPİTLER:
${olay.text}

TALEP / BEYAN:
${talep.text}

ARAÇ / TANIK / HASAR / EK BİLGİLER:
${ek.text}
''';

      case 'trafik':
        return '''
KONU: Trafik idari yaptırımına ilişkin itiraz talebimdir.

AÇIKLAMALAR:
${olay.text}

CEZA / TEBLİĞ BİLGİLERİ:
${ek.text}

SONUÇ VE TALEP:
${talep.text}
''';

      case 'savunma':
        return '''
KONU: Savunma sunulmasıdır.

AÇIKLAMALAR:
${olay.text}

SONUÇ:
Belirtilen hususlar çerçevesinde savunmamın değerlendirilmesini arz ederim.

${talep.text}
''';

      case 'karar':
        return '''
KARAR KONUSU: ${konu.text}

Yönetim kurulu aşağıdaki hususu görüşmüştür:

${olay.text}

KARAR:
${talep.text}

Kararın gereği için ilgili kişi ve birimlere bildirilmesine karar verilmiştir.

${ek.text}
''';

      case 'sendikatuzuk':
        return '''
SENDİKA TÜZÜĞÜ TASLAĞI

1. SENDİKANIN ADI, MERKEZİ VE ADRESİ
${kurum.text}

2. AMAÇ VE FAALİYETLER
${olay.text}

3. ÜYELİK
Üyeliğe kabul, üyelikten ayrılma ve çıkarılma usulleri düzenlenir.

4. ORGANLAR
Genel kurul, yönetim kurulu, denetleme kurulu ve disiplin kurulu ile görev ve yetkileri düzenlenir.

5. GENEL KURUL VE SEÇİMLER
Toplantı, çağrı, karar ve seçim usulleri düzenlenir.

6. MALİ HÜKÜMLER
Gelir, aidat, harcama, bütçe ve denetim esasları düzenlenir.

7. TÜZÜK DEĞİŞİKLİĞİ VE SONA ERME
Yetkili organ, karar usulü ve tasfiye hükümleri düzenlenir.

ÖZEL HÜKÜMLER:
${talep.text}

${ek.text}
''';

      case 'dernektuzuk':
        return '''
DERNEK TÜZÜĞÜ TASLAĞI

1. DERNEĞİN ADI VE MERKEZİ
${kurum.text}

2. AMAÇ VE ÇALIŞMA KONULARI
${olay.text}

3. ÜYELİK
Üyeliğe kabul, ayrılma ve çıkarılma usulleri düzenlenir.

4. DERNEK ORGANLARI
Genel kurul, yönetim kurulu ve denetim kurulu düzenlenir.

5. GENEL KURUL
Toplantı, çağrı ve karar usulleri düzenlenir.

6. GELİRLER VE DENETİM
Gelir kaynakları, aidat, harcama ve denetim esasları düzenlenir.

7. TÜZÜK DEĞİŞİKLİĞİ VE FESİH
Karar, tasfiye ve malvarlığının devri düzenlenir.

ÖZEL HÜKÜMLER:
${talep.text}

${ek.text}
''';

      case 'cevap':
        return '''
İLGİ: ${ek.text}
KONU: ${konu.text}

İlgi yazınız incelenmiştir.

${olay.text}

Bu kapsamda ${talep.text}

Bilgilerinize arz ederim.
''';

      case 'yedek':
        return '''
KONU: Yedek üyelik işlemi hakkında.

${olay.text}

BEYAN / TALEP:
${talep.text}

${ek.text}
''';

      case 'istifa':
        return '''
KONU: İstifa bildirimi.

${olay.text}

Görevimden/üyeliğimden kendi irademle ayrıldığımı bildirir, gerekli işlemlerin yapılmasını arz ederim.

${talep.text}
''';

      default:
        return '''
KONU: ${konu.text}

AÇIKLAMALAR:
${olay.text}

SONUÇ VE TALEP:
${talep.text}

EK / İLGİ / DİĞER BİLGİLER:
${ek.text}
''';
    }
  }

  String belgeMetni() {
    final muhatap = kurum.text.trim().isEmpty
        ? 'İLGİLİ MAKAMA'
        : kurum.text.trim().toUpperCase();

    return '''
$muhatap

${govde()}

Tarih: ${tarih()}

Ad Soyad: ${ad.text}
T.C. / Kimlik No: ${kimlik.text}
Adres: ${adres.text}
Telefon: ${telefon.text}

İmza:
''';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.belge.baslik)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                'Genel başvuru yolu:\n${widget.belge.merci}',
                style: const TextStyle(fontSize: 13),
              ),
            ),
          ),
          const SizedBox(height: 8),
          alan('Ad Soyad', ad),
          alan('T.C. / Kimlik No (gerekiyorsa)', kimlik),
          alan('Adres', adres, satir: 2),
          alan('Telefon', telefon),
          alan('Muhatap kurum / kuruluş', kurum),
          alan('Konu', konu, satir: 2),
          alan('Olay / açıklamalar', olay, satir: 6),
          alan('Talebiniz', talep, satir: 4),
          alan(
            'Ek, ilgi, ceza, tebliğ, araç veya diğer bilgiler',
            ek,
            satir: 4,
          ),
          FilledButton.icon(
            icon: const Icon(Icons.auto_awesome),
            label: const Padding(
              padding: EdgeInsets.all(14),
              child: Text('Belgeyi Hazırla'),
            ),
            onPressed: () {
              if (ad.text.trim().isEmpty || olay.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'En az Ad Soyad ve Olay/Açıklamalar alanlarını doldurun.',
                    ),
                  ),
                );
                return;
              }

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SonucSayfasi(
                    baslik: widget.belge.baslik,
                    metin: belgeMetni(),
                    merci: widget.belge.merci,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class SonucSayfasi extends StatefulWidget {
  final String baslik;
  final String metin;
  final String merci;

  const SonucSayfasi({
    super.key,
    required this.baslik,
    required this.metin,
    required this.merci,
  });

  @override
  State<SonucSayfasi> createState() => _SonucSayfasiState();
}

class _SonucSayfasiState extends State<SonucSayfasi> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.metin);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.baslik)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Hazırlanan Belge',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            minLines: 18,
            maxLines: null,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: () async {
              await Clipboard.setData(
                ClipboardData(text: controller.text),
              );

              if (!mounted) return;

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Belge panoya kopyalandı.'),
                ),
              );
            },
            icon: const Icon(Icons.copy),
            label: const Text('Metni Kopyala'),
          ),
          const SizedBox(height: 10),
          OutlinedButton.icon(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    title: const Text('Başvuru Yolu'),
                    content: Text(
                      '${widget.merci}\n\n'
                      'Bu bilgi genel yönlendirmedir. Süre, görevli/yetkili '
                      'merci ve güncel mevzuat resmî işlem öncesinde '
                      'kontrol edilmelidir.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Tamam'),
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(Icons.route_outlined),
            label: const Text('Başvuru Yolunu Göster'),
          ),
        ],
      ),
    );
  }
}
