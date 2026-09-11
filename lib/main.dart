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
        scaffoldBackgroundColor: const Color(0xFFF6F8FC),
      ),
      home: const AnaSayfa(),
    );
  }
}

class BelgeTuru {
  final String kategori;
  final String ad;
  final String aciklama;
  final String merci;
  final IconData ikon;
  final String tur;

  const BelgeTuru({
    required this.kategori,
    required this.ad,
    required this.aciklama,
    required this.merci,
    required this.ikon,
    required this.tur,
  });
}

const List<BelgeTuru> belgeler = [
  // TRAFİK VE KAZA
  BelgeTuru(
    kategori: 'Trafik & Kaza',
    ad: 'Kaza Olay Tutanağı',
    aciklama: 'Polis gelmediğinde olay ve kaza beyanı taslağı hazırla',
    merci: 'Sigorta şirketi, ilgili trafik birimi veya gerekli diğer kurum',
    ikon: Icons.car_crash,
    tur: 'kaza',
  ),
  BelgeTuru(
    kategori: 'Trafik & Kaza',
    ad: 'Trafik Cezasına İtiraz',
    aciklama: 'Trafik idari para cezasına ilişkin itiraz taslağı hazırla',
    merci:
        'Ceza türü ve tebligata göre görevli başvuru mercii güncel mevzuattan kontrol edilmelidir.',
    ikon: Icons.traffic,
    tur: 'trafik_itiraz',
  ),
  BelgeTuru(
    kategori: 'Trafik & Kaza',
    ad: 'Trafik Kurum Başvurusu',
    aciklama: 'Trafik işlemleriyle ilgili kuruma dilekçe hazırla',
    merci: 'İşlemi yapan veya konudan sorumlu kurum',
    ikon: Icons.local_police_outlined,
    tur: 'genel',
  ),

  // HUKUK
  BelgeTuru(
    kategori: 'Mahkeme & Hukuk',
    ad: 'Genel Hukuki Başvuru',
    aciklama: 'Olayı anlat, hukuki başvuru dilekçesi taslağı oluştur',
    merci:
        'Uyuşmazlığın niteliğine göre görevli ve yetkili mahkeme veya kurum belirlenmelidir.',
    ikon: Icons.gavel,
    tur: 'hukuk',
  ),
  BelgeTuru(
    kategori: 'Mahkeme & Hukuk',
    ad: 'Tüketici Uyuşmazlığı',
    aciklama: 'Mal veya hizmet uyuşmazlığı için başvuru hazırla',
    merci:
        'Uyuşmazlığın değeri ve niteliğine göre tüketici hakem heyeti veya tüketici mahkemesi yolu değerlendirilebilir.',
    ikon: Icons.shopping_bag_outlined,
    tur: 'hukuk',
  ),
  BelgeTuru(
    kategori: 'Mahkeme & Hukuk',
    ad: 'İdari İşleme İtiraz',
    aciklama: 'Kamu kurumunun işlemine karşı başvuru taslağı hazırla',
    merci:
        'İşlemi tesis eden idare ve uyuşmazlığın niteliğine göre ilgili idari başvuru veya yargı yolu',
    ikon: Icons.account_balance,
    tur: 'hukuk',
  ),

  // ÇALIŞMA
  BelgeTuru(
    kategori: 'Çalışma Hayatı',
    ad: 'İşverene Dilekçe',
    aciklama: 'İşverene resmî talep veya başvuru hazırla',
    merci: 'İşveren veya işyerinin ilgili birimi',
    ikon: Icons.business,
    tur: 'calisma',
  ),
  BelgeTuru(
    kategori: 'Çalışma Hayatı',
    ad: 'Bakanlığa Başvuru',
    aciklama: 'Çalışma hayatıyla ilgili Bakanlık başvurusu hazırla',
    merci: 'Çalışma ve Sosyal Güvenlik Bakanlığı veya ilgili birimi',
    ikon: Icons.account_balance_outlined,
    tur: 'calisma',
  ),
  BelgeTuru(
    kategori: 'Çalışma Hayatı',
    ad: 'Mobbing Başvurusu',
    aciklama: 'İşyerindeki psikolojik baskı iddiasını yazılı hale getir',
    merci:
        'Somut olaya göre işveren, kurum, ilgili idari makam veya hukuki başvuru mercii',
    ikon: Icons.report_problem_outlined,
    tur: 'calisma',
  ),
  BelgeTuru(
    kategori: 'Çalışma Hayatı',
    ad: 'Ücret ve İşçilik Alacağı',
    aciklama: 'Ücret, fazla çalışma ve diğer işçilik taleplerini hazırla',
    merci:
        'İşverene başvuru ve uyuşmazlığın türüne göre zorunlu arabuluculuk/yargı süreçleri değerlendirilebilir.',
    ikon: Icons.payments_outlined,
    tur: 'calisma',
  ),
  BelgeTuru(
    kategori: 'Çalışma Hayatı',
    ad: 'İşyeri Savunması',
    aciklama: 'İşveren veya kurum tarafından istenen savunmayı hazırla',
    merci: 'Savunmayı isteyen işveren, kurum veya disiplin birimi',
    ikon: Icons.shield_outlined,
    tur: 'savunma',
  ),

  // SENDİKA
  BelgeTuru(
    kategori: 'Sendika İşlemleri',
    ad: 'Sendika Üyelik İşlemi',
    aciklama: 'Üyelik, ayrılma veya üyelik işlemleri için yazı hazırla',
    merci: 'İlgili sendika veya yetkili kurum',
    ikon: Icons.person_add_alt,
    tur: 'sendika',
  ),
  BelgeTuru(
    kategori: 'Sendika İşlemleri',
    ad: 'Sendika Yönetim Kurulu Kararı',
    aciklama: 'Yönetim kurulu karar metni hazırla',
    merci: 'Sendika yönetim kurulu',
    ikon: Icons.how_to_vote_outlined,
    tur: 'karar',
  ),
  BelgeTuru(
    kategori: 'Sendika İşlemleri',
    ad: 'Sendika Toplantı Tutanağı',
    aciklama: 'Toplantı tutanağı oluştur',
    merci: 'Sendikanın ilgili organı',
    ikon: Icons.fact_check_outlined,
    tur: 'tutanak',
  ),
  BelgeTuru(
    kategori: 'Sendika İşlemleri',
    ad: 'Sendika Resmî Yazısı',
    aciklama: 'Kamu kurumu veya başka kuruluşa resmî yazı hazırla',
    merci: 'Yazının gönderileceği kurum veya kuruluş',
    ikon: Icons.mail_outline,
    tur: 'resmi_yazi',
  ),
  BelgeTuru(
    kategori: 'Sendika İşlemleri',
    ad: 'Sendikaya Gelen Yazıya Cevap',
    aciklama: 'Bakanlık veya kurum yazısına cevap hazırla',
    merci: 'Gelen yazıyı gönderen kurum',
    ikon: Icons.mark_email_read_outlined,
    tur: 'cevap',
  ),
  BelgeTuru(
    kategori: 'Sendika İşlemleri',
    ad: 'Sendika Tüzüğü',
    aciklama: 'Sendika tüzüğü için düzenlenebilir taslak oluştur',
    merci: 'İlgili mevzuat ve yetkili sendika organları',
    ikon: Icons.menu_book_outlined,
    tur: 'tuzuk_sendika',
  ),

  // DERNEK
  BelgeTuru(
    kategori: 'Dernek İşlemleri',
    ad: 'Dernek Tüzüğü',
    aciklama: 'Dernek tüzüğü için düzenlenebilir taslak oluştur',
    merci: 'Dernek organları ve ilgili idari makam',
    ikon: Icons.menu_book,
    tur: 'tuzuk_dernek',
  ),
  BelgeTuru(
    kategori: 'Dernek İşlemleri',
    ad: 'Yönetim Kurulu Kararı',
    aciklama: 'Dernek yönetim kurulu kararını hazırla',
    merci: 'Dernek yönetim kurulu',
    ikon: Icons.how_to_vote,
    tur: 'karar',
  ),
  BelgeTuru(
    kategori: 'Dernek İşlemleri',
    ad: 'Başkan / Yönetici İstifası',
    aciklama: 'Görev ve yönetim kurulu üyeliğinden istifa belgesi hazırla',
    merci: 'Dernek yönetim kuruluna',
    ikon: Icons.person_remove_outlined,
    tur: 'istifa',
  ),
  BelgeTuru(
    kategori: 'Dernek İşlemleri',
    ad: 'Yedek Üye Daveti',
    aciklama: 'Boşalan üyelik için yedek üyeyi göreve davet et',
    merci: 'İlgili yedek üyeye',
    ikon: Icons.person_add_outlined,
    tur: 'yedek_davet',
  ),
  BelgeTuru(
    kategori: 'Dernek İşlemleri',
    ad: 'Yedek Üye Kabul / Ret',
    aciklama: 'Görevi kabul veya reddetme belgesi hazırla',
    merci: 'Dernek yönetim kuruluna',
    ikon: Icons.rule,
    tur: 'kabul_ret',
  ),
  BelgeTuru(
    kategori: 'Dernek İşlemleri',
    ad: 'Kamu Kurumuna Bildirim',
    aciklama: 'Dernek işlemiyle ilgili resmî bildirim hazırla',
    merci: 'İlgili kamu kurumu veya dernekler birimi',
    ikon: Icons.notifications_active_outlined,
    tur: 'resmi_yazi',
  ),
  BelgeTuru(
    kategori: 'Dernek İşlemleri',
    ad: 'Gelen Resmî Yazıya Cevap',
    aciklama: 'Derneğe gönderilen kurum yazısına cevap hazırla',
    merci: 'Yazıyı gönderen kurum',
    ikon: Icons.reply_all,
    tur: 'cevap',
  ),

  // GSM İNTERNET
  BelgeTuru(
    kategori: 'GSM & İnternet',
    ad: 'Türk Telekom Başvurusu',
    aciklama: 'Arıza, fatura, internet, abonelik veya iptal başvurusu',
    merci: 'Türk Telekom ve uyuşmazlığın türüne göre ilgili başvuru kanalları',
    ikon: Icons.router_outlined,
    tur: 'telekom',
  ),
  BelgeTuru(
    kategori: 'GSM & İnternet',
    ad: 'Turkcell Başvurusu',
    aciklama: 'Hat, internet, fatura, abonelik veya iptal başvurusu',
    merci: 'Turkcell ve uyuşmazlığın türüne göre ilgili başvuru kanalları',
    ikon: Icons.cell_tower,
    tur: 'telekom',
  ),
  BelgeTuru(
    kategori: 'GSM & İnternet',
    ad: 'Vodafone Başvurusu',
    aciklama: 'Hat, internet, fatura, abonelik veya iptal başvurusu',
    merci: 'Vodafone ve uyuşmazlığın türüne göre ilgili başvuru kanalları',
    ikon: Icons.phone_android,
    tur: 'telekom',
  ),
  BelgeTuru(
    kategori: 'GSM & İnternet',
    ad: 'Diğer İnternet / GSM Sağlayıcısı',
    aciklama: 'Diğer operatör ve internet sağlayıcılarına başvuru',
    merci: 'İlgili hizmet sağlayıcı',
    ikon: Icons.wifi,
    tur: 'telekom',
  ),
  BelgeTuru(
    kategori: 'GSM & İnternet',
    ad: 'BTK Başvurusu',
    aciklama: 'Elektronik haberleşme hizmetiyle ilgili şikâyet taslağı',
    merci:
        'Bilgi Teknolojileri ve İletişim Kurumu; başvuru uygunluğu uyuşmazlığın niteliğine göre kontrol edilmelidir.',
    ikon: Icons.settings_input_antenna,
    tur: 'telekom',
  ),
  BelgeTuru(
    kategori: 'GSM & İnternet',
    ad: 'Fatura / Cayma Bedeli İtirazı',
    aciklama: 'Fatura veya cayma bedeli uyuşmazlığı için itiraz hazırla',
    merci:
        'Öncelikle hizmet sağlayıcı; uyuşmazlığın niteliğine göre BTK veya tüketici başvuru yolları değerlendirilebilir.',
    ikon: Icons.receipt_long_outlined,
    tur: 'telekom',
  ),

  // KAMU
  BelgeTuru(
    kategori: 'Kamu & Kurum',
    ad: 'Üniversiteye Dilekçe',
    aciklama: 'Üniversite rektörlüğü veya birimlerine başvuru',
    merci: 'İlgili üniversite rektörlüğü veya yetkili birim',
    ikon: Icons.school_outlined,
    tur: 'genel',
  ),
  BelgeTuru(
    kategori: 'Kamu & Kurum',
    ad: 'Belediyeye Dilekçe',
    aciklama: 'Belediyeye talep, şikâyet veya itiraz hazırla',
    merci: 'İlgili belediye başkanlığı veya müdürlük',
    ikon: Icons.location_city,
    tur: 'genel',
  ),
  BelgeTuru(
    kategori: 'Kamu & Kurum',
    ad: 'Bakanlığa Dilekçe',
    aciklama: 'Bakanlık veya bağlı kuruma resmî başvuru hazırla',
    merci: 'İlgili Bakanlık veya bağlı birim',
    ikon: Icons.account_balance_outlined,
    tur: 'genel',
  ),
  BelgeTuru(
    kategori: 'Kamu & Kurum',
    ad: 'Kamu Kurumuna İtiraz',
    aciklama: 'Kurum işlemi veya kararına karşı itiraz taslağı',
    merci: 'İşlemi yapan kurum veya mevzuatta belirtilen itiraz mercii',
    ikon: Icons.assignment_late_outlined,
    tur: 'genel',
  ),

  // DİĞER
  BelgeTuru(
    kategori: 'Diğer Belgeler',
    ad: 'Genel Dilekçe',
    aciklama: 'Her türlü talep, şikâyet veya başvuru için dilekçe',
    merci: 'Başvurunun konusundan sorumlu kurum veya kuruluş',
    ikon: Icons.edit_document,
    tur: 'genel',
  ),
  BelgeTuru(
    kategori: 'Diğer Belgeler',
    ad: 'Gelen Yazıya Cevap',
    aciklama: 'Size gönderilen resmî yazıya cevap hazırla',
    merci: 'Yazıyı gönderen kurum veya kuruluş',
    ikon: Icons.mark_email_read,
    tur: 'cevap',
  ),
  BelgeTuru(
    kategori: 'Diğer Belgeler',
    ad: 'Savunma Hazırla',
    aciklama: 'İdari veya işyeri savunması oluştur',
    merci: 'Savunmayı isteyen makam veya birim',
    ikon: Icons.shield,
    tur: 'savunma',
  ),
];

class AnaSayfa extends StatelessWidget {
  const AnaSayfa({super.key});

  static const kategoriler = [
    ['Trafik & Kaza', Icons.car_crash],
    ['Mahkeme & Hukuk', Icons.gavel],
    ['Çalışma Hayatı', Icons.work_outline],
    ['Sendika İşlemleri', Icons.groups],
    ['Dernek İşlemleri', Icons.diversity_3],
    ['GSM & İnternet', Icons.cell_tower],
    ['Kamu & Kurum', Icons.account_balance],
    ['Diğer Belgeler', Icons.description_outlined],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dilekçe Asistanı',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => showAboutDialog(
              context: context,
              applicationName: 'Dilekçe Asistanı',
              applicationVersion: '1.0',
              children: const [
                Text('Resmî belge ve dilekçe hazırlama uygulaması.'),
                SizedBox(height: 10),
                Text(
                  'Geliştiren: Fatih Demirel',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Icon(
              Icons.description_outlined,
              size: 64,
              color: Color(0xFF173B67),
            ),
            const SizedBox(height: 10),
            const Text(
              'Belgenizi adım adım hazırlayın',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'İşlem türünü seçin, bilgileri girin ve düzenlenebilir taslağınızı oluşturun.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ...kategoriler.map((item) {
              final ad = item[0] as String;
              final ikon = item[1] as IconData;
              final sayi = belgeler.where((e) => e.kategori == ad).length;

              return Card(
                margin: const EdgeInsets.only(bottom: 11),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  leading: Icon(
                    ikon,
                    size: 32,
                    color: const Color(0xFF173B67),
                  ),
                  title: Text(
                    ad,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('$sayi işlem seçeneği'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => KategoriSayfasi(kategori: ad),
                      ),
                    );
                  },
                ),
              );
            }),
            const SizedBox(height: 18),
            const Divider(),
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

class KategoriSayfasi extends StatelessWidget {
  final String kategori;

  const KategoriSayfasi({
    super.key,
    required this.kategori,
  });

  @override
  Widget build(BuildContext context) {
    final liste = belgeler.where((e) => e.kategori == kategori).toList();

    return Scaffold(
      appBar: AppBar(title: Text(kategori)),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: liste.length,
        itemBuilder: (context, index) {
          final belge = liste[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              contentPadding: const EdgeInsets.all(14),
              leading: Icon(
                belge.ikon,
                color: const Color(0xFF173B67),
                size: 30,
              ),
              title: Text(
                belge.ad,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(belge.aciklama),
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BelgeFormu(belge: belge),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class BelgeFormu extends StatefulWidget {
  final BelgeTuru belge;

  const BelgeFormu({
    super.key,
    required this.belge,
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
  final tarihNo = TextEditingController();
  final olay = TextEditingController();
  final talep = TextEditingController();
  final ekBilgi = TextEditingController();

  @override
  void dispose() {
    adSoyad.dispose();
    tc.dispose();
    telefon.dispose();
    adres.dispose();
    kurum.dispose();
    konu.dispose();
    tarihNo.dispose();
    olay.dispose();
    talep.dispose();
    ekBilgi.dispose();
    super.dispose();
  }

  Widget alan(
    TextEditingController controller,
    String label, {
    int satir = 1,
    bool zorunlu = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        maxLines: satir,
        decoration: InputDecoration(
          labelText: '$label${zorunlu ? ' *' : ''}',
          border: const OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white,
          alignLabelWithHint: satir > 1,
        ),
      ),
    );
  }

  String olayEtiketi() {
    switch (widget.belge.tur) {
      case 'kaza':
        return 'Kaza tarihi, saati, yeri, araçlar, oluş şekli, hasar ve varsa tanıkları anlatın';
      case 'trafik_itiraz':
        return 'Ceza tarihi, tebliğ tarihi, ceza türü, düzenleyen kurum ve itiraz nedenlerini yazın';
      case 'savunma':
        return 'Size yöneltilen iddia ve olayın gerçek gelişimini anlatın';
      case 'cevap':
        return 'Gelen yazının içeriğini ve cevap verilmesi gereken hususları yazın';
      case 'karar':
        return 'Karara bağlanacak konuyu ve alınan kararı açıklayın';
      case 'tutanak':
        return 'Toplantı tarihi, katılanlar, gündem ve görüşmeleri yazın';
      case 'telekom':
        return 'Abone/hat bilgisi, sorun, başvuru tarihleri ve yaşanan mağduriyeti anlatın';
      case 'istifa':
        return 'Görevinizi ve istifa iradenizi açıklayın';
      case 'yedek_davet':
        return 'Boşalan görev, yedek üye ve davet gerekçesini yazın';
      case 'kabul_ret':
        return 'Davet edilen görevi ve kabul/ret iradenizi açıklayın';
      default:
        return 'Olayı, sorunu ve önemli tarihleri ayrıntılı anlatın';
    }
  }

  String ekEtiketi() {
    switch (widget.belge.tur) {
      case 'kaza':
        return 'Plaka, sürücü, araç, sigorta ve diğer kaza bilgileri';
      case 'trafik_itiraz':
        return 'Ceza tutanağı seri/sıra no, plaka ve diğer bilgiler';
      case 'telekom':
        return 'Abone no, telefon no, müşteri hizmetleri kayıt no vb.';
      case 'cevap':
        return 'Gelen yazının tarih ve sayısı / ek bilgiler';
      case 'karar':
        return 'Karar no, toplantıya katılanlar ve varsa oylama bilgisi';
      default:
        return 'Ek bilgiler / belge numaraları / açıklamalar';
    }
  }

  String normalDilekce() {
    final makam = kurum.text.trim().isEmpty
        ? 'İLGİLİ MAKAMA'
        : kurum.text.trim().toUpperCase();

    return '''
$makam

Konu: ${konu.text.trim().isEmpty ? widget.belge.ad : konu.text.trim()}

AÇIKLAMALAR

${olay.text.trim()}

${ekBilgi.text.trim().isEmpty ? '' : 'Ek Bilgiler:\n${ekBilgi.text.trim()}\n'}

SONUÇ VE TALEP

${talep.text.trim()}

Yukarıda açıkladığım hususlar doğrultusunda gerekli incelemenin yapılarak talebim hakkında gereğinin yapılmasını arz ederim.

Tarih: .... / .... / ........

Ad Soyad: ${adSoyad.text.trim()}
${tc.text.trim().isEmpty ? '' : 'T.C. Kimlik No: ${tc.text.trim()}'}
${telefon.text.trim().isEmpty ? '' : 'Telefon: ${telefon.text.trim()}'}
${adres.text.trim().isEmpty ? '' : 'Adres: ${adres.text.trim()}'}

İmza
''';
  }

  String savunma() {
    return '''
${kurum.text.trim().isEmpty ? 'İLGİLİ MAKAMA' : kurum.text.trim().toUpperCase()}

SAVUNMA

Konu: ${konu.text.trim().isEmpty ? 'Savunma' : konu.text.trim()}

Tarafıma bildirilen hususlara ilişkin açıklamalarım aşağıdadır:

${olay.text.trim()}

${ekBilgi.text.trim().isEmpty ? '' : 'Ek Açıklamalar:\n${ekBilgi.text.trim()}\n'}

SONUÇ

${talep.text.trim()}

Açıklamalarımın değerlendirilmesini ve gereğinin buna göre yapılmasını arz ederim.

Tarih: .... / .... / ........

Ad Soyad: ${adSoyad.text.trim()}
İmza
''';
  }

  String kaza() {
    return '''
KAZA / OLAY BEYAN TUTANAĞI TASLAĞI

Tarih ve Saat: ${tarihNo.text.trim().isEmpty ? '........................' : tarihNo.text.trim()}

Olay / Kaza Yeri:
${konu.text.trim()}

Taraf / Beyanda Bulunan:
${adSoyad.text.trim()}

KAZANIN / OLAYIN OLUŞ ŞEKLİ

${olay.text.trim()}

ARAÇ, PLAKA, SÜRÜCÜ, HASAR, SİGORTA VE DİĞER BİLGİLER

${ekBilgi.text.trim()}

BEYAN / TALEP

${talep.text.trim()}

Yukarıdaki bilgilerin bildiğim ve gördüğüm kadarıyla gerçeğe uygun olduğunu beyan ederim.

Ad Soyad: ${adSoyad.text.trim()}
${telefon.text.trim().isEmpty ? '' : 'Telefon: ${telefon.text.trim()}'}
${adres.text.trim().isEmpty ? '' : 'Adres: ${adres.text.trim()}'}

Tarih: .... / .... / ........
İmza
''';
  }

  String karar() {
    return '''
${kurum.text.trim().isEmpty ? 'KURUM / KURULUŞ ADI' : kurum.text.trim().toUpperCase()}

YÖNETİM KURULU KARARI

Karar Tarihi / No:
${tarihNo.text.trim().isEmpty ? '................................' : tarihNo.text.trim()}

Konu:
${konu.text.trim()}

Yönetim kurulu, yukarıda belirtilen gündem maddesini görüşmek üzere toplanmıştır.

GÖRÜŞÜLEN HUSUSLAR

${olay.text.trim()}

KARAR

${talep.text.trim()}

${ekBilgi.text.trim().isEmpty ? '' : 'Ek Açıklamalar:\n${ekBilgi.text.trim()}\n'}

İşbu karar düzenlenerek imza altına alınmıştır.

Başkan: ............................ İmza: ............
Üye: ............................... İmza: ............
Üye: ............................... İmza: ............
''';
  }

  String tutanak() {
    return '''
${kurum.text.trim().isEmpty ? 'KURUM / KURULUŞ ADI' : kurum.text.trim().toUpperCase()}

TOPLANTI TUTANAĞI

Toplantı Tarihi / Saati:
${tarihNo.text.trim().isEmpty ? '................................' : tarihNo.text.trim()}

Gündem:
${konu.text.trim()}

GÖRÜŞMELER

${olay.text.trim()}

SONUÇ / ALINAN KARARLAR

${talep.text.trim()}

${ekBilgi.text.trim().isEmpty ? '' : 'Katılımcılar / Ek Bilgiler:\n${ekBilgi.text.trim()}\n'}

İşbu tutanak birlikte düzenlenerek imza altına alınmıştır.

İmzalar:
................................
................................
................................
''';
  }

  String resmiYazi() {
    return '''
${kurum.text.trim().isEmpty ? 'KURUM / KURULUŞ' : kurum.text.trim().toUpperCase()}

Sayı: ${tarihNo.text.trim().isEmpty ? '....................' : tarihNo.text.trim()}
Konu: ${konu.text.trim()}

İLGİLİ MAKAMA

${olay.text.trim()}

${talep.text.trim()}

Bilgilerinize ve gereğini arz/rica ederiz.

${ekBilgi.text.trim().isEmpty ? '' : 'Ek / İlgi:\n${ekBilgi.text.trim()}\n'}

Ad Soyad / Yetkili:
${adSoyad.text.trim()}

İmza
''';
  }

  String cevap() {
    return '''
${kurum.text.trim().isEmpty ? 'YAZIYI GÖNDEREN MAKAMA' : kurum.text.trim().toUpperCase()}

Konu: ${konu.text.trim().isEmpty ? 'İlgi yazınıza cevap' : konu.text.trim()}
İlgi: ${tarihNo.text.trim().isEmpty ? '.... tarih ve .... sayılı yazınız' : tarihNo.text.trim()}

İlgi yazınız incelenmiştir.

${olay.text.trim()}

Bu kapsamda;

${talep.text.trim()}

Bilgilerinize arz/rica ederim.

${ekBilgi.text.trim().isEmpty ? '' : 'Ek Açıklama / Ekler:\n${ekBilgi.text.trim()}\n'}

Ad Soyad / Yetkili:
${adSoyad.text.trim()}

İmza
''';
  }

  String istifa() {
    return '''
${kurum.text.trim().isEmpty ? 'DERNEK YÖNETİM KURULU BAŞKANLIĞINA' : kurum.text.trim().toUpperCase()}

İSTİFA DİLEKÇESİ

Konu: ${konu.text.trim().isEmpty ? 'Görevden istifa' : konu.text.trim()}

${olay.text.trim()}

İstifa irademin ilgili kurul ve kayıtlara işlenerek gerekli işlemlerin yapılmasını arz ederim.

${talep.text.trim()}

Tarih: .... / .... / ........

Ad Soyad: ${adSoyad.text.trim()}
İmza
''';
  }

  String yedekDavet() {
    return '''
${kurum.text.trim().isEmpty ? 'DERNEK / KURULUŞ ADI' : kurum.text.trim().toUpperCase()}

YEDEK ÜYE GÖREVE DAVET YAZISI

Konu: ${konu.text.trim().isEmpty ? 'Yedek üyenin göreve daveti' : konu.text.trim()}

Sayın ${adSoyad.text.trim()},

${olay.text.trim()}

Yönetim kurulunda boşalan üyelik nedeniyle, yedek üyelik sırası ve ilgili karar doğrultusunda görevi kabul edip etmediğinizi yazılı olarak bildirmeniz hususunda gereğini rica ederiz.

${talep.text.trim()}

${ekBilgi.text.trim().isEmpty ? '' : 'Ek Bilgiler:\n${ekBilgi.text.trim()}\n'}

Tarih: .... / .... / ........
Yetkili İmza
''';
  }

  String kabulRet() {
    return '''
${kurum.text.trim().isEmpty ? 'DERNEK YÖNETİM KURULU BAŞKANLIĞINA' : kurum.text.trim().toUpperCase()}

GÖREV KABUL / RET BEYANI

Konu: ${konu.text.trim().isEmpty ? 'Yedek üyelik görevi hakkında' : konu.text.trim()}

${olay.text.trim()}

BEYANIM

${talep.text.trim()}

İşbu beyanı kendi irademle sunduğumu bildiririm.

Tarih: .... / .... / ........

Ad Soyad: ${adSoyad.text.trim()}
İmza
''';
  }

  String tuzuk(bool sendika) {
    final ad = kurum.text.trim().isEmpty
        ? (sendika ? 'SENDİKA ADI' : 'DERNEK ADI')
        : kurum.text.trim().toUpperCase();

    return '''
$ad

TÜZÜK TASLAĞI

MADDE 1 - AD VE MERKEZ
Kuruluşun adı: $ad
Merkezi: ............................................................

MADDE 2 - AMAÇ
${konu.text.trim().isEmpty ? 'Kuruluşun amacı ve faaliyet alanları burada ayrıntılı olarak düzenlenir.' : konu.text.trim()}

MADDE 3 - FAALİYETLER
${olay.text.trim()}

MADDE 4 - ÜYELİK
Üyeliğe kabul, üyelikten ayrılma ve üyeliğin sona ermesine ilişkin esaslar ilgili mevzuata uygun şekilde düzenlenir.

MADDE 5 - ORGANLAR
Kuruluşun zorunlu ve diğer organları, görevleri, yetkileri, seçim usulleri ve görev süreleri bu bölümde düzenlenir.

MADDE 6 - GENEL KURUL
Genel kurulun toplanma zamanı, çağrı usulü, toplantı ve karar yeter sayıları ile görev ve yetkileri düzenlenir.

MADDE 7 - YÖNETİM KURULU
Yönetim kurulunun oluşumu, görevleri, yetkileri ve çalışma esasları düzenlenir.

MADDE 8 - DENETİM
Denetim organının oluşumu, görevleri ve denetim esasları düzenlenir.

MADDE 9 - GELİRLER VE MALİ HÜKÜMLER
Gelir kaynakları, giderler, bütçe, kayıt ve mali işlemler ilgili mevzuata uygun yürütülür.

MADDE 10 - TÜZÜK DEĞİŞİKLİĞİ
Tüzük değişikliğinin hangi organ tarafından ve hangi usulle yapılacağı düzenlenir.

MADDE 11 - FESİH / SONA ERME
Kuruluşun sona ermesi halinde uygulanacak usul ve malvarlığının tasfiyesi ilgili mevzuata uygun düzenlenir.

MADDE 12 - DİĞER HÜKÜMLER
${talep.text.trim()}

EK NOTLAR
${ekBilgi.text.trim()}

Bu metin düzenlenebilir bir tüzük taslağıdır. Kuruluş türüne ilişkin zorunlu tüzük hükümleri ve güncel mevzuat, resmî işlem öncesinde ayrıca kontrol edilmelidir.
''';
  }

  String belgeOlustur() {
    switch (widget.belge.tur) {
      case 'kaza':
        return kaza();
      case 'savunma':
        return savunma();
      case 'karar':
        return karar();
      case 'tutanak':
        return tutanak();
      case 'resmi_yazi':
        return resmiYazi();
      case 'cevap':
        return cevap();
      case 'istifa':
        return istifa();
      case 'yedek_davet':
        return yedekDavet();
      case 'kabul_ret':
        return kabulRet();
      case 'tuzuk_sendika':
        return tuzuk(true);
      case 'tuzuk_dernek':
        return tuzuk(false);
      default:
        return normalDilekce();
    }
  }

  void hazirla() {
    if (adSoyad.text.trim().isEmpty ||
        olay.text.trim().isEmpty ||
        talep.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Ad soyad, olay/açıklama ve sonuç/talep alanlarını doldurun.',
          ),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SonucSayfasi(
          baslik: widget.belge.ad,
          metin: belgeOlustur(),
          merci: widget.belge.merci,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.belge.ad)),
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
                      'Başvuru yönlendirmesi',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    Text(widget.belge.merci),
                    const SizedBox(height: 8),
                    const Text(
                      'Görevli/yetkili merci, süre ve usul somut olaya ve güncel mevzuata göre değişebilir. Özellikle dava ve itirazlarda resmî tebligat ile güncel kurallar kontrol edilmelidir.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            alan(adSoyad, 'Ad Soyad / Yetkili', zorunlu: true),
            alan(tc, 'T.C. Kimlik No (gerekiyorsa)'),
            alan(telefon, 'Telefon'),
            alan(adres, 'Adres', satir: 2),
            alan(kurum, 'Kurum / Makam / Kuruluş'),
            alan(konu, 'Konu / Olay yeri / Gündem'),
            alan(tarihNo, 'Tarih, tebliğ tarihi, karar/yazı/ceza no'),
            alan(
              olay,
              olayEtiketi(),
              satir: 7,
              zorunlu: true,
            ),
            alan(
              ekBilgi,
              ekEtiketi(),
              satir: 4,
            ),
            alan(
              talep,
              'Sonuç / Talep / Karar / Beyan',
              satir: 5,
              zorunlu: true,
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
              'Hazırlanan metin düzenlenebilir taslaktır. İmzalamadan veya göndermeden önce kişi, kurum, tarih, süre ve hukuki bilgileri kontrol edin.',
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
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.metin);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
