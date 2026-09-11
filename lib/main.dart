
                 
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
        colorSchemeSeed: const Color(0xFF173B67),
        scaffoldBackgroundColor: const Color(0xFFF7F8FC),
      ),
      home: const AnaSayfa(),
    );
  }
}

enum BelgeTuru {
  dilekce,
  savunma,
  resmiYazi,
  kurum,
  operatorInternet,
  sikayetItiraz,
}

class AnaSayfa extends StatelessWidget {
  const AnaSayfa({super.key});

  void ac(
    BuildContext context,
    BelgeTuru tur,
    String baslik,
    String aciklama,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BelgeFormu(
          tur: tur,
          baslik: baslik,
          aciklama: aciklama,
        ),
      ),
    );
  }

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
            const SizedBox(height: 8),
            const Icon(
              Icons.description_outlined,
              size: 78,
              color: Color(0xFF173B67),
            ),
            const SizedBox(height: 18),
            const Text(
              'Resmî başvurunuzu kolayca hazırlayın',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Başvuru türünü seçin. Gerekli bilgileri girin, '
              'Dilekçe Asistanı belgenizi düzenli bir taslak hâline getirsin.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, height: 1.45),
            ),
            const SizedBox(height: 24),

            MenuKarti(
              ikon: Icons.edit_document,
              baslik: 'Dilekçe Hazırla',
              altBaslik: 'Kurum ve kuruluşlara dilekçe oluştur',
              onTap: () => ac(
                context,
                BelgeTuru.dilekce,
                'Dilekçe Hazırla',
                'Başvurunuz için gerekli bilgileri girin.',
              ),
            ),

            MenuKarti(
              ikon: Icons.gavel,
              baslik: 'Savunma Hazırla',
              altBaslik: 'Disiplin ve işyeri savunması oluştur',
              onTap: () => ac(
                context,
                BelgeTuru.savunma,
                'Savunma Hazırla',
                'Savunmaya konu olayın ayrıntılarını yazın.',
              ),
            ),

            MenuKarti(
              ikon: Icons.account_balance,
              baslik: 'Resmî Yazı Hazırla',
              altBaslik: 'Resmî kurumlara uygun yazı oluştur',
              onTap: () => ac(
                context,
                BelgeTuru.resmiYazi,
                'Resmî Yazı Hazırla',
                'Resmî yazının konusu ve talebinizi belirtin.',
              ),
            ),

            MenuKarti(
              ikon: Icons.apartment,
              baslik: 'Kurum Başvuruları',
              altBaslik: 'Belediye, üniversite ve kamu kurumları',
              onTap: () => ac(
                context,
                BelgeTuru.kurum,
                'Kurum Başvurusu',
                'Başvuru yapacağınız kurumu ve talebinizi yazın.',
              ),
            ),

            MenuKarti(
              ikon: Icons.cell_tower,
              baslik: 'GSM ve İnternet',
              altBaslik: 'Operatör ve internet hizmeti başvuruları',
              onTap: () => ac(
                context,
                BelgeTuru.operatorInternet,
                'GSM / İnternet Başvurusu',
                'Operatör veya internet hizmetiyle ilgili sorununuzu yazın.',
              ),
            ),

            MenuKarti(
              ikon: Icons.report_problem_outlined,
              baslik: 'Şikâyet ve İtiraz',
              altBaslik: 'Şikâyet, itiraz ve talep metni oluştur',
              onTap: () => ac(
                context,
                BelgeTuru.sikayetItiraz,
                'Şikâyet / İtiraz',
                'Şikâyet veya itirazınıza ilişkin bilgileri girin.',
              ),
            ),

            const SizedBox(height: 28),
            const Divider(),
            const SizedBox(height: 12),
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
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class MenuKarti extends StatelessWidget {
  final IconData ikon;
  final String baslik;
  final String altBaslik;
  final VoidCallback onTap;

  const MenuKarti({
    super.key,
    required this.ikon,
    required this.baslik,
    required this.altBaslik,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 13),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 10,
        ),
        leading: Icon(
          ikon,
          size: 34,
          color: const Color(0xFF173B67),
        ),
        title: Text(
          baslik,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(altBaslik),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}

class BelgeFormu extends StatefulWidget {
  final BelgeTuru tur;
  final String baslik;
  final String aciklama;

  const BelgeFormu({
    super.key,
    required this.tur,
    required this.baslik,
    required this.aciklama,
  });

  @override
  State<BelgeFormu> createState() => _BelgeFormuState();
}

class _BelgeFormuState extends State<BelgeFormu> {
  final adSoyad = TextEditingController();
  final tcKimlik = TextEditingController();
  final adres = TextEditingController();
  final telefon = TextEditingController();
  final kurum = TextEditingController();
  final konu = TextEditingController();
  final olay = TextEditingController();
  final talep = TextEditingController();

  @override
  void dispose() {
    adSoyad.dispose();
    tcKimlik.dispose();
    adres.dispose();
    telefon.dispose();
    kurum.dispose();
    konu.dispose();
    olay.dispose();
    talep.dispose();
    super.dispose();
  }

  String belgeBasligi() {
    switch (widget.tur) {
      case BelgeTuru.dilekce:
        return 'DİLEKÇE';
      case BelgeTuru.savunma:
        return 'SAVUNMA';
      case BelgeTuru.resmiYazi:
        return 'RESMÎ YAZI';
      case BelgeTuru.kurum:
        return 'KURUM BAŞVURUSU';
      case BelgeTuru.operatorInternet:
        return 'GSM / İNTERNET HİZMETİ BAŞVURUSU';
      case BelgeTuru.sikayetItiraz:
        return 'ŞİKÂYET / İTİRAZ BAŞVURUSU';
    }
  }

  String anaMetin() {
    final olayMetni = olay.text.trim();
    final talepMetni = talep.text.trim();

    switch (widget.tur) {
      case BelgeTuru.savunma:
        return '''
Tarafıma bildirilen hususa ilişkin açıklamalarım aşağıdadır:

$olayMetni

Yukarıda açıkladığım hususların değerlendirilmesini, savunmamın dikkate alınmasını arz ederim.

$talepMetni''';

      case BelgeTuru.sikayetItiraz:
        return '''
$olayMetni

Yukarıda açıkladığım nedenlerle konuya ilişkin gerekli incelemenin yapılmasını ve aşağıda belirttiğim talebimin değerlendirilmesini arz ederim.

$talepMetni''';

      case BelgeTuru.operatorInternet:
        return '''
Kullanmakta olduğum elektronik haberleşme / internet hizmetine ilişkin yaşadığım sorun aşağıda açıklanmıştır:

$olayMetni

Sorunun incelenerek giderilmesini ve aşağıdaki talebimin değerlendirilmesini arz ederim.

$talepMetni''';

      default:
        return '''
$olayMetni

Yukarıda açıkladığım hususlar doğrultusunda aşağıda belirttiğim talebimin değerlendirilmesini arz ederim.

$talepMetni''';
    }
  }

  String belgeOlustur() {
    final kurumAdi = kurum.text.trim().isEmpty
        ? 'İLGİLİ MAKAMA'
        : kurum.text.trim().toUpperCase();

    final konuMetni = konu.text.trim().isEmpty
        ? 'Başvuru'
        : konu.text.trim();

    final tcSatiri = tcKimlik.text.trim().isEmpty
        ? ''
        : '\nT.C. Kimlik No: ${tcKimlik.text.trim()}';

    final telefonSatiri = telefon.text.trim().isEmpty
        ? ''
        : '\nTelefon: ${telefon.text.trim()}';

    final adresSatiri = adres.text.trim().isEmpty
        ? ''
        : '\nAdres: ${adres.text.trim()}';

    return '''
$kurumAdi

${belgeBasligi()}

Konu: $konuMetni

${anaMetin()}

Ad Soyad: ${adSoyad.text.trim()}$tcSatiri$telefonSatiri$adresSatiri

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
            'Lütfen ad soyad, açıklama ve talep alanlarını doldurun.',
          ),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SonucSayfasi(
          baslangicMetni: belgeOlustur(),
        ),
      ),
    );
  }

  Widget alan(
    TextEditingController controller,
    String etiket, {
    int satir = 1,
    TextInputType? klavye,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: controller,
        maxLines: satir,
        keyboardType: klavye,
        decoration: InputDecoration(
          labelText: etiket,
          border: const OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.baslik),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              widget.aciklama,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 18),

            alan(adSoyad, 'Ad Soyad *'),
            alan(tcKimlik, 'T.C. Kimlik No (isteğe bağlı)',
                klavye: TextInputType.number),
            alan(telefon, 'Telefon (isteğe bağlı)',
                klavye: TextInputType.phone),
            alan(adres, 'Adres (isteğe bağlı)', satir: 2),
            alan(kurum, 'Başvurulacak kurum / kuruluş'),
            alan(konu, 'Konu'),

            alan(
              olay,
              widget.tur == BelgeTuru.savunma
                  ? 'Olayı ve savunmanızı ayrıntılı anlatın *'
                  : 'Olayı / başvuru nedenini ayrıntılı anlatın *',
              satir: 6,
            ),

            alan(
              talep,
              'Talebiniz / sonuç olarak istediğiniz işlem *',
              satir: 4,
            ),

            const SizedBox(height: 6),

            FilledButton.icon(
              onPressed: hazirla,
              icon: const Icon(Icons.auto_awesome),
              label: const Padding(
                padding: EdgeInsets.symmetric(vertical: 14),
                child: Text(
                  'Belgeyi Hazırla',
                  style: TextStyle(fontSize: 17),
                ),
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              'Hazırlanan metni göndermeden önce bilgilerin doğruluğunu '
              'kontrol etmeniz önerilir.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SonucSayfasi extends StatefulWidget {
  final String baslangicMetni;

  const SonucSayfasi({
    super.key,
    required this.baslangicMetni,
  });

  @override
  State<SonucSayfasi> createState() => _SonucSayfasiState();
}

class _SonucSayfasiState extends State<SonucSayfasi> {
  late final TextEditingController metin;

  @override
  void initState() {
    super.initState();
    metin = TextEditingController(text: widget.baslangicMetni);
  }

  @override
  void dispose() {
    metin.dispose();
    super.dispose();
  }

  Future<void> kopyala() async {
    await Clipboard.setData(
      ClipboardData(text: metin.text),
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
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text(
                'Metni kontrol edebilir ve isterseniz doğrudan düzenleyebilirsiniz.',
              ),
              const SizedBox(height: 12),

              Expanded(
                child: TextField(
                  controller: metin,
                  expands: true,
                  maxLines: null,
                  minLines: null,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: kopyala,
                  icon: const Icon(Icons.copy),
                  label: const Text('Metni Kopyala'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
