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
        colorSchemeSeed: const Color(0xFF173B67),
        scaffoldBackgroundColor: const Color(0xFFF6F8FC),
      ),
      home: const AnaSayfa(),
    );
  }
}

class Islem {
  final String ad;
  final String aciklama;
  final String merci;
  final IconData ikon;

  const Islem({
    required this.ad,
    required this.aciklama,
    required this.merci,
    required this.ikon,
  });
}

const islemler = <Islem>[
  Islem(
    ad: 'Trafik & Kaza',
    aciklama:
        'Kaza beyanı/tutanağı, trafik cezası itirazı ve trafik başvuruları',
    merci:
        'Olayın türüne, tebligata ve işlemi yapan kuruma göre başvuru mercii belirlenmelidir.',
    ikon: Icons.car_crash,
  ),
  Islem(
    ad: 'Mahkeme & Hukuk',
    aciklama:
        'Olayınızı anlatın, başvuru yolu ve dilekçe taslağı hazırlayın',
    merci:
        'Uyuşmazlığın türüne göre görevli ve yetkili mahkeme veya kurum ayrıca kontrol edilmelidir.',
    ikon: Icons.gavel,
  ),
  Islem(
    ad: 'Çalışma Hayatı',
    aciklama:
        'İşveren, Bakanlık, ücret, işçilik alacağı, mobbing ve çalışma sorunları',
    merci:
        'Konuya göre işveren, Çalışma ve Sosyal Güvenlik Bakanlığı veya ilgili yasal başvuru mercii.',
    ikon: Icons.work_outline,
  ),
  Islem(
    ad: 'Savunma Hazırla',
    aciklama: 'İşyeri, disiplin veya idari süreç için savunma oluştur',
    merci: 'Savunmayı isteyen kurum, işveren veya ilgili birim.',
    ikon: Icons.shield_outlined,
  ),
  Islem(
    ad: 'Sendika İşlemleri',
    aciklama:
        'Üyelik, yönetim, resmî yazı, karar, tutanak, cevap ve sendika tüzüğü',
    merci: 'İlgili sendika organı veya ilgili kamu kurumu.',
    ikon: Icons.groups,
  ),
  Islem(
    ad: 'Dernek İşlemleri',
    aciklama:
        'Dernek tüzüğü, karar, istifa, yedek üye, bildirim ve resmî cevap',
    merci: 'İlgili dernek organı veya yetkili idari makam.',
    ikon: Icons.diversity_3,
  ),
  Islem(
    ad: 'GSM & İnternet',
    aciklama:
        'Türk Telekom, Turkcell, Vodafone ve diğer sağlayıcılara başvuru',
    merci:
        'Önce hizmet sağlayıcı; uyuşmazlığa göre BTK veya tüketici başvuru yolları değerlendirilebilir.',
    ikon: Icons.cell_tower,
  ),
  Islem(
    ad: 'Kamu & Kurum',
    aciklama:
        'Üniversite, belediye, bakanlık ve kamu kurumlarına resmî başvuru',
    merci: 'Başvurunun konusundan sorumlu kurum veya birim.',
    ikon: Icons.account_balance,
  ),
  Islem(
    ad: 'Gelen Yazıya Cevap',
    aciklama:
        'Kurumdan gelen resmî yazının içeriğine göre cevap metni hazırla',
    merci: 'Yazıyı gönderen kurum veya yazıda belirtilen cevap mercii.',
    ikon: Icons.mark_email_read_outlined,
  ),
  Islem(
    ad: 'Genel Dilekçe',
    aciklama: 'Diğer resmî talep, şikâyet, itiraz ve başvurular',
    merci: 'Başvurunun konusuyla ilgili kurum veya kuruluş.',
    ikon: Icons.edit_document,
  ),
];

class AnaSayfa extends StatelessWidget {
  const AnaSayfa({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dilekçe Asistanı',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Icon(
              Icons.description_outlined,
              size: 68,
              color: Color(0xFF173B67),
            ),
            const SizedBox(height: 12),
            const Text(
              'Resmî belgenizi adım adım hazırlayın',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'İşlem türünü seçin, olayınızı anlatın ve düzenlenebilir belge taslağınızı oluşturun.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 22),

            ...islemler.map(
              (islem) => Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 9,
                  ),
                  leading: Icon(
                    islem.ikon,
                    size: 32,
                    color: const Color(0xFF173B67),
                  ),
                  title: Text(
                    islem.ad,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(islem.aciklama),
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BelgeFormu(islem: islem),
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 8),
            const Text(
              'Dilekçe Asistanı',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              'Geliştiren: Fatih Demirel',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 18),
          ],
        ),
      ),
    );
  }
}

class BelgeFormu extends StatefulWidget {
  final Islem islem;

  const BelgeFormu({
    super.key,
    required this.islem,
  });

  @override
  State<BelgeFormu> createState() => _BelgeFormuState();
}

class _BelgeFormuState extends State<BelgeFormu> {
  final adSoyad = TextEditingController();
  final tc = TextEditingController();
  final telefon = TextEditingController();
  final adres = TextEditingController();
  final kurum = TextEditingController();
  final konu = TextEditingController();
  final olay = TextEditingController();
  final talep = TextEditingController();

  @override
  void dispose() {
    adSoyad.dispose();
    tc.dispose();
    telefon.dispose();
    adres.dispose();
    kurum.dispose();
    konu.dispose();
    olay.dispose();
    talep.dispose();
    super.dispose();
  }

  Widget alan(
    TextEditingController controller,
    String etiket, {
    int satir = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: TextField(
        controller: controller,
        maxLines: satir,
        decoration: InputDecoration(
          labelText: etiket,
          border: const OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  String belgeOlustur() {
    final makam = kurum.text.trim().isEmpty
        ? 'İLGİLİ MAKAMA'
        : kurum.text.trim().toUpperCase();

    final konuMetni =
        konu.text.trim().isEmpty ? widget.islem.ad : konu.text.trim();

    final tcSatiri =
        tc.text.trim().isEmpty ? '' : 'T.C. Kimlik No: ${tc.text.trim()}\n';

    final telefonSatiri = telefon.text.trim().isEmpty
        ? ''
        : 'Telefon: ${telefon.text.trim()}\n';

    final adresSatiri = adres.text.trim().isEmpty
        ? ''
        : 'Adres: ${adres.text.trim()}\n';

    String baslik = '${widget.islem.ad.toUpperCase()} BAŞVURUSU';

    if (widget.islem.ad == 'Savunma Hazırla') {
      baslik = 'SAVUNMA';
    }

    if (widget.islem.ad == 'Gelen Yazıya Cevap') {
      baslik = 'RESMÎ YAZIYA CEVAP';
    }

    return '''
$makam

$baslik

Konu: $konuMetni

AÇIKLAMALAR:

${olay.text.trim()}

SONUÇ VE TALEP:

${talep.text.trim()}

Yukarıda açıkladığım hususların incelenerek gereğinin yapılmasını arz ederim.

Ad Soyad: ${adSoyad.text.trim()}
$tcSatiri$telefonSatiri$adresSatiri
Tarih: .... / .... / ........

İmza:
''';
  }

  void hazirla() {
    if (adSoyad.text.trim().isEmpty ||
        olay.text.trim().isEmpty ||
        talep.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Ad soyad, açıklama ve talep alanlarını doldurun.',
          ),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SonucSayfasi(
          metin: belgeOlustur(),
          merci: widget.islem.merci,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final gelenYazi = widget.islem.ad == 'Gelen Yazıya Cevap';

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.islem.ad),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Genel başvuru yönlendirmesi',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    Text(widget.islem.merci),
                    const SizedBox(height: 8),
                    const Text(
                      'Yetkili veya görevli merci, süre ve başvuru usulü olayın ayrıntılarına ve güncel mevzuata göre değişebilir. Resmî tebligat ayrıca kontrol edilmelidir.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            alan(adSoyad, 'Ad Soyad *'),
            alan(tc, 'T.C. Kimlik No (isteğe bağlı)'),
            alan(telefon, 'Telefon (isteğe bağlı)'),
            alan(adres, 'Adres (isteğe bağlı)', satir: 2),
            alan(kurum, 'Başvurulacak kurum / makam'),
            alan(konu, 'Konu'),

            alan(
              olay,
              gelenYazi
                  ? 'Gelen yazının içeriğini ve cevap verilecek hususları yazın *'
                  : 'Olayı / sorunu ayrıntılı anlatın *',
              satir: 7,
            ),

            alan(
              talep,
              'Sonuç olarak ne istiyorsunuz? *',
              satir: 4,
            ),

            FilledButton.icon(
              onPressed: hazirla,
              icon: const Icon(Icons.auto_awesome),
              label: const Padding(
                padding: EdgeInsets.symmetric(vertical: 14),
                child: Text(
                  'Belgeyi Hazırla',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),

            const SizedBox(height: 12),
            const Text(
              'Hazırlanan belge bir taslaktır. Göndermeden önce kişi, tarih, kurum, süre ve hukuki bilgileri kontrol edin.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SonucSayfasi extends StatefulWidget {
  final String metin;
  final String merci;

  const SonucSayfasi({
    super.key,
    required this.metin,
    required this.merci,
  });

  @override
  State<SonucSayfasi> createState() => _SonucSayfasiState();
}

class _SonucSayfasiState extends State<SonucSayfasi> {
  late final TextEditingController belge;

  @override
  void initState() {
    super.initState();
    belge = TextEditingController(text: widget.metin);
  }

  @override
  void dispose() {
    belge.dispose();
    super.dispose();
  }

  Future<void> kopyala() async {
    await Clipboard.setData(
      ClipboardData(text: belge.text),
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Belge panoya kopyalandı.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hazırlanan Belge'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'Belgeyi göndermeden önce düzenleyebilirsiniz.',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: belge,
              minLines: 18,
              maxLines: null,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 14),

            FilledButton.icon(
              onPressed: kopyala,
              icon: const Icon(Icons.copy),
              label: const Text('Metni Kopyala'),
            ),

            const SizedBox(height: 10),

            OutlinedButton.icon(
              icon: const Icon(Icons.route),
              label: const Text('Başvuru Yolunu Göster'),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Genel Başvuru Yolu'),
                    content: Text(
                      '${widget.merci}\n\n'
                      'Bu yönlendirme genel bilgilendirme amaçlıdır. '
                      'Güncel mevzuat, başvuru süresi ve resmî tebligat '
                      'bilgileri ayrıca kontrol edilmelidir.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Tamam'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
