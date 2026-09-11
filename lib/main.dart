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
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: const Color(0xFF173B67),
              borderRadius: BorderRadius.circular(22),
            ),
            child: const Column(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.description_outlined,
                    size: 43,
                    color: Color(0xFF173B67),
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  'Resmî belgenizi kolayca hazırlayın',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 7),
                Text(
                  'Belge türünü seçin, bilgilerinizi girin ve metninizi oluşturun.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          _menu(
            context,
            Icons.edit_document,
            'Dilekçe Hazırla',
            'Kamu ve özel kurumlara başvuru',
            BelgeTuru.dilekce,
          ),
          _menu(
            context,
            Icons.gavel,
            'Savunma Hazırla',
            'Disiplin ve işyeri savunması',
            BelgeTuru.savunma,
          ),
          _menu(
            context,
            Icons.account_balance,
            'Resmî Yazı Hazırla',
            'Resmî yazışma formatında metin',
            BelgeTuru.resmiYazi,
          ),
          _menu(
            context,
            Icons.apartment,
            'Kurum Başvuruları',
            'Belediye, üniversite ve kamu kurumları',
            BelgeTuru.kurum,
          ),
          _menu(
            context,
            Icons.signal_cellular_alt,
            'Operatör ve İnternet',
            'GSM, internet ve iletişim hizmetleri',
            BelgeTuru.operatorInternet,
          ),
          _menu(
            context,
            Icons.report_problem_outlined,
            'Şikâyet / İtiraz',
            'Şikâyet, itiraz ve talep başvuruları',
            BelgeTuru.sikayetItiraz,
          ),

          const SizedBox(height: 25),
          const Divider(),
          const SizedBox(height: 12),

          const Text(
            'Dilekçe Asistanı',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
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
    );
  }

  Widget _menu(
    BuildContext context,
    IconData icon,
    String baslik,
    String aciklama,
    BelgeTuru tur,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        leading: CircleAvatar(
          backgroundColor: const Color(0xFFE7EEF7),
          child: Icon(icon, color: const Color(0xFF173B67)),
        ),
        title: Text(
          baslik,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(aciklama),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BelgeFormu(
                tur: tur,
                baslik: baslik,
              ),
            ),
          );
        },
      ),
    );
  }
}

class BelgeFormu extends StatefulWidget {
  final BelgeTuru tur;
  final String baslik;

  const BelgeFormu({
    super.key,
    required this.tur,
    required this.baslik,
  });

  @override
  State<BelgeFormu> createState() => _BelgeFormuState();
}

class _BelgeFormuState extends State<BelgeFormu> {
  final _formKey = GlobalKey<FormState>();

  final adSoyad = TextEditingController();
  final tcKimlik = TextEditingController();
  final adres = TextEditingController();
  final telefon = TextEditingController();
  final eposta = TextEditingController();
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
    eposta.dispose();
    kurum.dispose();
    konu.dispose();
    olay.dispose();
    talep.dispose();
    super.dispose();
  }

  String get kurumEtiketi {
    switch (widget.tur) {
      case BelgeTuru.operatorInternet:
        return 'Operatör / İnternet Sağlayıcısı';
      case BelgeTuru.savunma:
        return 'İşyeri / Kurum';
      default:
        return 'Başvurulacak Kurum';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.baslik)),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'Başvuru Bilgileri',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Belgenin hazırlanması için aşağıdaki bilgileri doldurun.',
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 20),

            _alan(
              adSoyad,
              'Ad Soyad *',
              Icons.person_outline,
              zorunlu: true,
            ),
            _alan(
              tcKimlik,
              'T.C. Kimlik No (isteğe bağlı)',
              Icons.badge_outlined,
              klavye: TextInputType.number,
            ),
            _alan(
              adres,
              'Adres',
              Icons.home_outlined,
              satir: 2,
            ),
            _alan(
              telefon,
              'Telefon',
              Icons.phone_outlined,
              klavye: TextInputType.phone,
            ),
            _alan(
              eposta,
              'E-posta',
              Icons.email_outlined,
              klavye: TextInputType.emailAddress,
            ),
            _alan(
              kurum,
              '$kurumEtiketi *',
              Icons.account_balance_outlined,
              zorunlu: true,
            ),
            _alan(
              konu,
              'Konu *',
              Icons.subject,
              zorunlu: true,
            ),
            _alan(
              olay,
              widget.tur == BelgeTuru.savunma
                  ? 'Savunmaya konu olay ve açıklamanız *'
                  : 'Olay / Açıklama *',
              Icons.notes,
              zorunlu: true,
              satir: 5,
            ),
            _alan(
              talep,
              widget.tur == BelgeTuru.savunma
                  ? 'Sonuç / Talebiniz'
                  : 'Talebiniz *',
              Icons.check_circle_outline,
              zorunlu: widget.tur != BelgeTuru.savunma,
              satir: 3,
            ),

            const SizedBox(height: 10),

            FilledButton.icon(
              onPressed: _belgeOlustur,
              icon: const Icon(Icons.auto_awesome),
              label: const Padding(
                padding: EdgeInsets.symmetric(vertical: 14),
                child: Text(
                  'BELGEYİ OLUŞTUR',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _alan(
    TextEditingController controller,
    String label,
    IconData icon, {
    bool zorunlu = false,
    int satir = 1,
    TextInputType? klavye,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: TextFormField(
        controller: controller,
        maxLines: satir,
        keyboardType: klavye,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: satir == 1 ? Icon(icon) : null,
          alignLabelWithHint: true,
        ),
        validator: zorunlu
            ? (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Bu alanı doldurun.';
                }
                return null;
              }
            : null,
      ),
    );
  }

  void _belgeOlustur() {
    if (!_formKey.currentState!.validate()) return;

    final metin = _metinHazirla();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SonucSayfasi(
          baslik: widget.baslik,
          metin: metin,
        ),
      ),
    );
  }

  String _bugun() {
    final tarih = DateTime.now();
    return '${tarih.day.toString().padLeft(2, '0')}.'
        '${tarih.month.toString().padLeft(2, '0')}.'
        '${tarih.year}';
  }

  String _kisiBilgileri() {
    final bilgiler = <String>[];

    bilgiler.add('Ad Soyad: ${adSoyad.text.trim()}');

    if (tcKimlik.text.trim().isNotEmpty) {
      bilgiler.add('T.C. Kimlik No: ${tcKimlik.text.trim()}');
    }
    if (adres.text.trim().isNotEmpty) {
      bilgiler.add('Adres: ${adres.text.trim()}');
    }
    if (telefon.text.trim().isNotEmpty) {
      bilgiler.add('Telefon: ${telefon.text.trim()}');
    }
    if (eposta.text.trim().isNotEmpty) {
      bilgiler.add('E-posta: ${eposta.text.trim()}');
    }

    return bilgiler.join('\n');
  }

  String _metinHazirla() {
    final hedef = kurum.text.trim().toUpperCase();
    final konuMetni = konu.text.trim();
    final olayMetni = olay.text.trim();
    final talepMetni = talep.text.trim();

    switch (widget.tur) {
      case BelgeTuru.savunma:
        return '''
$hedef

Konu: $konuMetni

SAVUNMA

Tarafıma bildirilen hususlara ilişkin açıklamalarım aşağıdadır.

$olayMetni

${talepMetni.isNotEmpty ? 'Sonuç ve Talep:\n$talepMetni\n' : ''}
Yukarıda açıkladığım hususların değerlendirilmesini ve savunmamın dikkate alınmasını arz ederim.

Tarih: ${_bugun()}

${_kisiBilgileri()}

İmza:
''';

      case BelgeTuru.resmiYazi:
        return '''
$hedef

Konu: $konuMetni

$olayMetni

Talep:
$talepMetni

Bilgilerinize arz ederim.

Tarih: ${_bugun()}

${_kisiBilgileri()}

İmza:
''';

      case BelgeTuru.operatorInternet:
        return '''
$hedef MÜŞTERİ HİZMETLERİ / İLGİLİ BİRİME

Konu: $konuMetni

Sayın Yetkili,

Kullanmakta olduğum iletişim hizmetine ilişkin yaşadığım sorun aşağıda açıklanmıştır:

$olayMetni

Talebim:
$talepMetni

Başvurumun incelenerek gerekli işlemlerin yapılmasını ve sonucundan tarafıma bilgi verilmesini talep ederim.

Tarih: ${_bugun()}

${_kisiBilgileri()}

İmza:
''';

      case BelgeTuru.sikayetItiraz:
        return '''
$hedef

Konu: $konuMetni

ŞİKÂYET / İTİRAZ BAŞVURUSU

Açıklamalar:

$olayMetni

Talep ve Sonuç:

$talepMetni

Yukarıda açıkladığım hususlar doğrultusunda başvurumun incelenerek gereğinin yapılmasını ve sonucunun tarafıma bildirilmesini arz ederim.

Tarih: ${_bugun()}

${_kisiBilgileri()}

İmza:
''';

      case BelgeTuru.kurum:
      case BelgeTuru.dilekce:
        return '''
$hedef

Konu: $konuMetni

AÇIKLAMALAR

$olayMetni

TALEP VE SONUÇ

$talepMetni

Yukarıda arz edilen hususlar doğrultusunda gerekli inceleme ve işlemlerin yapılarak sonucundan tarafıma bilgi verilmesini arz ederim.

Tarih: ${_bugun()}

${_kisiBilgileri()}

İmza:
''';
    }
  }
}

class SonucSayfasi extends StatefulWidget {
  final String baslik;
  final String metin;

  const SonucSayfasi({
    super.key,
    required this.baslik,
    required this.metin,
  });

  @override
  State<SonucSayfasi> createState() => _SonucSayfasiState();
}

class _SonucSayfasiState extends State<SonucSayfasi> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.metin.trim());
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _kopyala() async {
    await Clipboard.setData(
      ClipboardData(text: controller.text),
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
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            color: const Color(0xFFE7EEF7),
            child: const Row(
              children: [
                Icon(Icons.info_outline),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Metni göndermeden önce bilgilerin doğruluğunu kontrol edin. İsterseniz metni aşağıdan düzenleyebilirsiniz.',
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: controller,
                expands: true,
                maxLines: null,
                minLines: null,
                textAlignVertical: TextAlignVertical.top,
                decoration: const InputDecoration(
                  alignLabelWithHint: true,
                  labelText: 'Belge Metni',
                  filled: true,
                 
