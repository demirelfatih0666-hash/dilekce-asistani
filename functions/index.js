const { onRequest } = require("firebase-functions/v2/https");
const { defineSecret } = require("firebase-functions/params");
const OpenAI = require("openai");

const openAiKey = defineSecret("OPENAI_API_KEY");

exports.belgeOlustur = onRequest(
  {
    region: "europe-west1",
    secrets: [openAiKey],
    timeoutSeconds: 120,
  },
  async (req, res) => {
    res.set("Access-Control-Allow-Origin", "*");

    if (req.method === "OPTIONS") {
      res.set("Access-Control-Allow-Methods", "POST");
      res.set("Access-Control-Allow-Headers", "Content-Type");
      return res.status(204).send("");
    }

    if (req.method !== "POST") {
      return res.status(405).json({ hata: "Sadece POST isteği kabul edilir." });
    }

    try {
      const belgeTuru = String(req.body?.belgeTuru || "").trim();
      const kullaniciAnlatimi =
        String(req.body?.kullaniciAnlatimi || "").trim();

      if (!belgeTuru || kullaniciAnlatimi.length < 10) {
        return res.status(400).json({
          hata: "Belge türü ve olay açıklaması gereklidir.",
        });
      }

      const client = new OpenAI({
        apiKey: openAiKey.value(),
      });

      const response = await client.responses.create({
        model: "gpt-5",
        store: false,

        instructions: `
Sen Türkiye'de kullanılmak üzere profesyonel resmî belge taslakları
hazırlayan bir belge asistanısın.

Kullanıcının günlük konuşma diliyle verdiği bilgileri aynen kopyalama.
Anlamını koruyarak düzgün, doğal, profesyonel ve resmî Türkçeyle
yeniden yaz.

Belge türüne göre uygun yapı oluştur.

Dilekçelerde gerekiyorsa:
- hitap makamı
- konu
- açıklamalar
- talep ve sonuç
- tarih
- ad soyad
- imza
- ekler

Savunmalarda olayın kronolojisini ve kullanıcının açıklamasını
profesyonel savunma diline dönüştür.

Trafik ve kaza belgelerinde yalnızca kullanıcının verdiği olay
bilgilerini kullan.

Sendika ve dernek belgelerinde belge türüne uygun karar, tutanak,
resmî yazı veya tüzük yapısı kullan.

Kullanıcının vermediği kişi adı, tarih, kanun maddesi, delil,
mahkeme kararı, dosya numarası veya olay uydurma.

Eksik kişisel bilgiler gerekiyorsa [AD SOYAD], [TARİH],
[ADRES] gibi düzenlenebilir alanlar bırak.

Hukuki konuda kesin sonuç vaat etme.
Başvuru makamından emin değilsen kesinmiş gibi yazma.

Belgenin içine "yapay zekâ tarafından hazırlanmıştır",
"AI", "asistan tarafından hazırlanmıştır" gibi ifadeler ekleme.

Sadece kullanılabilir nihai belge metnini üret.
`,

        input: `
BELGE TÜRÜ:
${belgeTuru}

KULLANICININ ANLATIMI:
${kullaniciAnlatimi}

Bu bilgilerden profesyonel ve kullanıma hazır Türkçe belge oluştur.
`,
      });

      const belge = response.output_text?.trim();

      if (!belge) {
        throw new Error("Model boş yanıt döndürdü.");
      }

      return res.status(200).json({ belge });
    } catch (error) {
      console.error(error);

      return res.status(500).json({
        hata: "Belge oluşturulurken bir hata oluştu.",
      });
    }
  }
);
