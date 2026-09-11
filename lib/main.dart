import 'package:flutter/material.dart';

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
        colorSchemeSeed: Colors.indigo,
      ),
      home: const AnaSayfa(),
    );
  }
}

class AnaSayfa extends StatelessWidget {
  const AnaSayfa({super.key});

  static const List<BelgeTuru> belgeler = [
    BelgeTuru(
      'Dilekçe Hazırla',
      'Kurumlara ve kuruluşlara profesyonel dilekçe oluştur.',
      Icons.description_outlined,
    ),
    BelgeTuru(
      'Savunma Hazırla',
      'Olayı anlat, profesyonel savunma metni oluştur.',
      Icons.shield_outlined,
    ),
    BelgeTuru(
      'Mahkeme ve Hukuk',
      'Hukuki konuyu anlat, başvuru yolu ve dilekçe taslağı oluştur.',
      Icons.gavel_outlined,
    ),
    BelgeTuru(
      'Trafik ve Kaza',
      'Kaza tutanağı, olay beyanı ve trafik itirazı hazırla.',
      Icons.car_crash_outlined,
    ),
    BelgeTuru(
      'İşçi ve Çalışma Hayatı',
      'İşveren, Bakanlık ve ilgili kurumlara başvuru hazırla.',
      Icons.work_outline,
    ),
    BelgeTuru(
      'Sendika İşlemleri',
      'Resmî yazı, karar, tutanak, cevap ve tüzük taslağı hazırla.',
      Icons.groups_outlined,
    ),
    BelgeTuru(
      'Dernek İşlemleri',
      'Karar, tutanak, istifa, atama ve tüzük taslağı hazırla.',
      Icons.account_balance_outlined,
    ),
    BelgeTuru(
      'Telefon ve İnternet',
      'Operatör, internet sağlayıcı ve tüketici başvurusu hazırla.',
      Icons.wifi_outlined,
    ),
    BelgeTuru(
      'Resmî Yazı',
      'Kamu kurumları ve diğer kuruluşlar için resmî yazı oluştur.',
      Icons.business_outlined,
    ),
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
            onPressed: () {
              showAboutDialog(
                context: context,
                applicationName: 'Dilekçe Asistanı',
                applicationVersion: '2.0 AI',
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
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.auto_awesome, size: 36),
                  const SizedBox(height: 10),
                  const Text(
                    'AI Belge Asistanı',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Olayı kendi cümlelerinle anlat. Yapay zekâ bilgileri değerlendirerek belge türüne uygun profesyonel bir taslak hazırlasın.',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          ...belgeler.map(
            (belge) => Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                leading: CircleAvatar(
                  child: Icon(belge.icon),
                ),
                title: Text(
                  belge.baslik,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(belge.aciklama),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BelgeOlusturSayfasi(
                        belgeTuru: belge.baslik,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Center(
            child: Text(
              'Geliştiren: Fatih Demirel',
              style: TextStyle(fontSize: 12),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class BelgeOlusturSayfasi extends StatefulWidget {
  final String belgeTuru;

  const BelgeOlusturSayfasi({
    super.key,
    required this.belgeTuru,
  });

  @override
  State<BelgeOlusturSayfasi> createState() => _BelgeOlusturSayfasiState();
}

class _BelgeOlusturSayfasiState extends State<BelgeOlusturSayfasi> {
  final TextEditingController anlatimController = TextEditingController();

  @override
  void dispose() {
    anlatimController.dispose();
    super.dispose();
  }

  void belgeOlustur() {
    final anlatim = anlatimController.text.trim();

    if (anlatim.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lütfen olayı veya talebinizi biraz daha ayrıntılı anlatın.'),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SonucSayfasi(
          belgeTuru: widget.belgeTuru,
          kullaniciAnlatimi: anlatim,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.belgeTuru),
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Text(
            'Ne olduğunu anlatın',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Resmî dil kullanmanız gerekmez. Olayı, sorununuzu, ne istediğinizi ve önemli tarihleri kendi cümlelerinizle yazabilirsiniz.',
          ),
          const SizedBox(height: 18),
          TextField(
            controller: anlatimController,
            minLines: 10,
            maxLines: 18,
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText:
                  'Örnek: İşe giderken yoğun trafik nedeniyle 10 dakika geciktim. İşveren benden yazılı savunma istedi. Gecikmenin kasıtlı olmadığını ve ilk kez yaşandığını belirtmek istiyorum.',
            ),
          ),
          const SizedBox(height: 18),
          FilledButton.icon(
            onPressed: belgeOlustur,
            icon: const Icon(Icons.auto_awesome),
            label: const Padding(
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Text('Yapay Zekâ ile Belge Hazırla'),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Hukuki başvurularda uygulama genel bilgilendirme ve taslak oluşturma amacı taşır. Başvuru mercii ve süreler somut olaya göre ayrıca kontrol edilmelidir.',
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class SonucSayfasi extends StatelessWidget {
  final String belgeTuru;
  final String kullaniciAnlatimi;

  const SonucSayfasi({
    super.key,
    required this.belgeTuru,
    required this.kullaniciAnlatimi,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Belge Sonucu'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          const Icon(
            Icons.cloud_outlined,
            size: 60,
          ),
          const SizedBox(height: 18),
          const Text(
            'AI bağlantısı kurulacak',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Bu ekran artık sabit şablon üretmiyor. Güvenli AI sunucusu bağlandığında anlatımınız yapay zekâya gönderilecek ve profesyonel belge burada oluşturulacak.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    belgeTuru,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  const Divider(),
                  Text(kullaniciAnlatimi),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: null,
            icon: const Icon(Icons.content_copy),
            label: const Text('Metni Kopyala'),
          ),
          const SizedBox(height: 10),
          OutlinedButton.icon(
            onPressed: null,
            icon: const Icon(Icons.description_outlined),
            label: const Text('Word Oluştur'),
          ),
          const SizedBox(height: 10),
          OutlinedButton.icon(
            onPressed: null,
            icon: const Icon(Icons.picture_as_pdf_outlined),
            label: const Text('PDF Oluştur'),
          ),
          const SizedBox(height: 10),
          OutlinedButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.edit_outlined),
            label: const Text('Bilgileri Düzenle'),
          ),
        ],
      ),
    );
  }
}

class BelgeTuru {
  final String baslik;
  final String aciklama;
  final IconData icon;

  const BelgeTuru(
    this.baslik,
    this.aciklama,
    this.icon,
  );
}
