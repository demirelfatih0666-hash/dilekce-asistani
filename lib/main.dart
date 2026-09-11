import 'package:flutter/material.dart';

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
        colorSchemeSeed: Colors.indigo,
      ),
      home: const AnaSayfa(),
    );
  }
}

class AnaSayfa extends StatelessWidget {
  const AnaSayfa({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dilekçe Asistanı'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Icon(
            Icons.description_outlined,
            size: 80,
          ),
          const SizedBox(height: 12),
          const Text(
            'Resmî başvurunuzu kolayca hazırlayın',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Başvuru türünü seçin. Asistan gerekli bilgileri adım adım sorarak belgenizi hazırlamanıza yardımcı olsun.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),

          _menu(
            context,
            Icons.edit_document,
            'Dilekçe Hazırla',
            'Kurum ve kuruluşlara dilekçe oluştur',
          ),
          _menu(
            context,
            Icons.gavel,
            'Savunma Hazırla',
            'Disiplin ve işyeri savunması oluştur',
          ),
          _menu(
            context,
            Icons.account_balance,
            'Resmî Yazı Hazırla',
            'Resmî kurumlara uygun yazı oluştur',
          ),
          _menu(
            context,
            Icons.apartment,
            'Kurum Başvuruları',
            'Belediye, üniversite ve kamu kurumları',
          ),
          _menu(
            context,
            Icons.phone_android,
            'Operatör ve İnternet',
            'GSM ve internet hizmeti şikâyetleri',
          ),
          _menu(
            context,
            Icons.report_problem_outlined,
            'Şikâyet / İtiraz',
            'Şikâyet, itiraz ve talep metni oluştur',
          ),

          const SizedBox(height: 30),
          const Divider(),
          const SizedBox(height: 12),

          const Text(
            'Geliştiren: Fatih Demirel',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Dilekçe Asistanı',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _menu(
    BuildContext context,
    IconData icon,
    String baslik,
    String aciklama,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, size: 32),
        title: Text(
          baslik,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(aciklama),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$baslik bölümü hazırlanıyor.'),
            ),
          );
        },
      ),
    );
  }
}
