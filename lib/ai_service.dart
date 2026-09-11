import 'dart:convert';
import 'package:http/http.dart' as http;

class AiService {
  // Güvenli sunucu bağlantısını kurduğumuzda gerçek adresi buraya ekleyeceğiz.
  static const String apiUrl = '';

  static Future<String> belgeOlustur({
    required String belgeTuru,
    required String kullaniciAnlatimi,
  }) async {
    if (apiUrl.isEmpty) {
      throw Exception('AI sunucu bağlantısı henüz yapılandırılmadı.');
    }

    final response = await http
        .post(
          Uri.parse(apiUrl),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'belgeTuru': belgeTuru,
            'kullaniciAnlatimi': kullaniciAnlatimi,
          }),
        )
        .timeout(const Duration(seconds: 60));

    if (response.statusCode != 200) {
      throw Exception('Belge oluşturulamadı. Lütfen tekrar deneyin.');
    }

    final data = jsonDecode(utf8.decode(response.bodyBytes));

    if (data is! Map || data['belge'] == null) {
      throw Exception('AI sunucusundan geçersiz yanıt alındı.');
    }

    return data['belge'].toString();
  }
}
