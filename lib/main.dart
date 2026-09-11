import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'ai_service.dart';

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
      'Kurumlara ve kuruluşlara dilekçe taslağı oluştur.',
      Icons.description_outlined,
    ),
    BelgeTuru(
      'Savunma Hazırla',
      'Olayı anlat, yazılı savunma taslağı oluştur.',
      Icons.shield_outlined,
    ),
    BelgeTuru(
      'Mahkeme ve Hukuk',
      'Hukuki konuyu anlat, başvuru ve dilekçe taslağı hazırla.',
      Icons.gavel_outlined,
    ),
    BelgeTuru(
      'Trafik ve Kaza',
      'Kaza beyanı, tutanak taslağı ve trafik itirazı hazırla.',
      Icons.car_crash_outlined,
    ),
    BelgeTuru(
      'İşçi ve Çalışma Hayatı',
      'İşverene ve ilgili kurumlara başvuru hazırla.',
      Icons.work_outline,
    ),
    BelgeTuru(
      'Sendika İşlemleri',
      'Resmî yazı, karar, tutanak ve tüzük taslağı hazırla.',
      Icons.groups_outlined,
    ),
    BelgeTuru(
      'Dernek İşlemleri',
      'Karar, tutanak, istifa ve atama yazısı taslağı hazırla.',
      Icons.account_balance_outlined,
    ),
    BelgeTuru(
      'Telefon ve İnternet',
      'Operatör ve internet sağlayıcısına başvuru hazırla.',
      Icons.wifi_outlined,
    ),
    BelgeTuru(
      'Resmî Yazı',
      'Kamu kurumları ve kuruluşlar için yazı taslağı oluştur.',
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
            tooltip: 'Hakkında',
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              showAboutDialog(
                context: context,
                applicationName: 'Dilekçe Asistanı',
                applicationVersion: '2.1 AI',
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
          const Card(
            child: Padding(
              padding: EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.auto_awesome, size: 36),
                  SizedBox(height: 10),
                  Text(
                    'AI Belge Asistanı',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Olayı kendi cümlelerinle anlat. Yapay zekâ, '
                    'belge türüne uygun bir taslak hazırlasın.',
                    style: TextStyle(fontSize: 15),
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
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                leading: CircleAvatar(
                  child: Icon(belge.icon),
                ),
                title: Text(
                  belge.baslik,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(belge.aciklama),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
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
  State<BelgeOlusturSayfasi> createState() =>
      _BelgeOlusturSayfasiState();
}

class _BelgeOlusturSayfasiState
    extends State<BelgeOlusturSayfasi> {
  final TextEditingController anlatimController =
      TextEditingController();

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
          content: Text(
            'Lütfen olayınızı veya talebinizi '
            'biraz daha ayrıntılı anlatın.',
          ),
        ),
      );
      return;
    }

    FocusScope.of(context).unfocus();

    Navigator.push(
      context,
      MaterialPageRoute<void>(
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
      appBar: AppBar(title: Text(widget.belgeTuru)),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Text(
            'Ne olduğunu anlatın',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Resmî dil kullanmanız gerekmez. Olayı, talebinizi, '
            'başvuracağınız kurumu ve önemli tarihleri yazın.',
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
                  'Örnek: İşe giderken yoğun trafik nedeniyle '
                  '10 dakika geciktim. Benden yazılı savunma '
                  'istendi. İdari ve Mali İşler Daire '
                  'Başkanlığına sunacağım bir savunma '
                  'taslağı hazırlamak istiyorum.',
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
            'Belge hazırlamak için yazdığınız bilgiler '
            'yapay zekâ hizmetine gönderilir. '
            'Gereksiz kişisel bilgileri paylaşmayın.',
            style: TextStyle(fontSize: 12),
          ),
          const SizedBox(height: 8),
          const Text(
            'Oluşturulan metin bir taslaktır. Kullanmadan önce '
            'bilgileri, başvuru merciini ve süreleri kontrol edin.',
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class SonucSayfasi extends StatefulWidget {
  final String belgeTuru;
  final String kullaniciAnlatimi;

  const SonucSayfasi({
    super.key,
    required this.belgeTuru,
    required this.kullaniciAnlatimi,
  });

  @override
  State<SonucSayfasi> createState() => _SonucSayfasiState();
}

class _SonucSayfasiState extends State<SonucSayfasi> {
  bool yukleniyor = true;
  String? belge;
  String? hata;

  @override
  void initState() {
    super.initState();
    belgeHazirla();
  }

  Future<void> belgeHazirla() async {
    setState(() {
      yukleniyor = true;
      hata = null;
      belge = null;
    });

    try {
      final sonuc = await AiService.belgeOlustur(
        belgeTuru: widget.belgeTuru,
        kullaniciAnlatimi: widget.kullaniciAnlatimi,
      );

      if (sonuc.trim().isEmpty) {
        throw Exception('Sunucudan boş belge geldi.');
      }

      if (!mounted) return;

      setState(() {
        belge = sonuc;
        yukleniyor = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        hata = e.toString().replaceFirst('Exception: ', '');
        yukleniyor = false;
      });
    }
  }

  Future<void> metniKopyala() async {
    final metin = belge;
    if (metin == null) return;

    try {
      await Clipboard.setData(ClipboardData(text: metin));
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Belge metni kopyalandı.'),
        ),
      );
    } catch (_) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Kopyalama yapılamadı. Metne uzun basarak '
            'seçip kopyalayabilirsiniz.',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Belge Sonucu')),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          if (yukleniyor) ...[
            const SizedBox(height: 40),
            const Center(
              child: CircularProgressIndicator(),
            ),
            const SizedBox(height: 24),
            const Text(
              'Belgeniz hazırlanıyor…',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Yapay zekânın yanıtı bekleniyor.',
              textAlign: TextAlign.center,
            ),
          ],
          if (hata != null) ...[
            const Icon(
              Icons.error_outline,
              size: 56,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            const Text(
              'Belge hazırlanamadı',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            SelectableText(
              hata!,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: belgeHazirla,
              icon: const Icon(Icons.refresh),
              label: const Text('Tekrar Dene'),
            ),
          ],
          if (belge != null) ...[
            Text(
              widget.belgeTuru,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: SelectableText(
                  belge!,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.6,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: metniKopyala,
              icon: const Icon(Icons.content_copy),
              label: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text('Metni Kopyala'),
              ),
            ),
          ],
          const SizedBox(height: 20),
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
