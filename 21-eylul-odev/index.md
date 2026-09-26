```html
<!doctype html>
<html lang="tr">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Akıllı Saat Tanıtımı - Samsung Galaxy Watch6</title>

    <style>
      body {
        font-family: Arial, Helvetica, sans-serif;
        background: #f1f5f9;
        color: #1e293b;
        padding: 20px;
        max-width: 600px;
        margin: auto;
      }

      .card {
        background: white;
        padding: 20px;
        border-radius: 12px;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        margin-bottom: 20px;
      }

      h1 {
        color: #1e40af;
        text-align: center;
      }

      h2 {
        font-size: 18px;
        color: #334155;
      }

      p {
        line-height: 1.5;
      }

      video,
      iframe {
        width: 100%;
        border-radius: 8px;
        margin-top: 10px;
      }

      meter {
        width: 100%;
        height: 25px;
        margin-top: 8px;
      }

      details {
        border: 1px solid #cbd5e1;
        border-radius: 6px;
        padding: 10px;
        margin-bottom: 10px;
      }

      details[open] {
        background: #eff6ff;
      }

      summary {
        font-weight: bold;
        color: #1e40af;
        cursor: pointer;
      }

      .btn-modal {
        background: #1e40af;
        color: white;
        border: none;
        padding: 10px 16px;
        border-radius: 6px;
        font-weight: bold;
        cursor: pointer;
      }

      dialog {
        border: none;
        border-radius: 12px;
        padding: 24px;
        max-width: 350px;
        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.25);
      }

      dialog::backdrop {
        background: rgba(15, 23, 42, 0.6);
      }

      .close-btn {
        background: #dc2626;
        color: white;
        border: none;
        padding: 8px 12px;
        border-radius: 6px;
        cursor: pointer;
      }
    </style>
  </head>

  <body>
    <div class="card">
      <h1>Samsung Galaxy Watch6 Akıllı Saat</h1>

      <p>
        Samsung Galaxy Watch6, şık tasarımı ve gelişmiş özellikleri ile günlük
        yaşamınızı kolaylaştırır. Sağlık takibi, bildirimler ve spor özellikleri
        sayesinde gün içindeki aktivitelerinizi daha kolay takip etmenize yardım
        eder.
      </p>

      <h2>Ürün Tanıtım Videosu</h2>

      <video controls playsinline preload="metadata">
        <source
          src="https://interactive-examples.mdn.mozilla.net/media/cc0-videos/flower.mp4"
          type="video/mp4"
        />
        Tarayıcınız video etiketini desteklemiyor.
      </video>

      <h2>YouTube Tanıtım Videosu</h2>

      <iframe
        height="315"
        src="https://www.youtube.com/embed/2vOceSQXjvA"
        title="Samsung Galaxy Watch6 Tanıtım Videosu"
        frameborder="0"
        allow="
          accelerometer;
          autoplay;
          clipboard-write;
          encrypted-media;
          gyroscope;
          picture-in-picture;
          web-share;
        "
        referrerpolicy="strict-origin-when-cross-origin"
        allowfullscreen
      ></iframe>
    </div>

    <div class="card">
      <h2>Stok Durumu</h2>

      <p>Ürünün mevcut stok seviyesi:</p>

      <meter value="35" min="0" max="100" low="20" high="70" optimum="90">
        35%
      </meter>

      <p><strong>Stokta 35 adet ürün bulunmaktadır.</strong></p>
    </div>

    <div class="card">
      <h2>Sıkça Sorulan Sorular</h2>

      <details>
        <summary>Samsung Galaxy Watch 6 Hangi Telefonlarla Uyumludur?</summary>
        <p>
          Samsung Galaxy Watch6, Android İşletim Sistemine Sahip Telefonlarla
          Bluetooth Bağlantısı Üzerinden Kullanılabilir. Samsung Galaxy
          Telefonlarıyla Kullanıldığında Bazı Özellikler Daha Uyumlu Çalışır.
        </p>
      </details>

      <details>
        <summary>Saatte Sağlık ve Spor Takibi Özellikleri Var Mı?</summary>
        <p>
          Evet. Galaxy Watch 6; Günlük Adım Sayısı, Kalp Atış Hızı, Uyku Düzeni,
          Egzersizler ve Yakılan Kalori Gibi Bilgileri Takip Etmeye Yardımcı
          Olur.
        </p>
      </details>

      <details>
        <summary>Saatin Şarj Süresi Ne Kadardır?</summary>
        <p>
          Kullanım Yoğunluğuna Göre Şarj Süresi Değişebilir. Bildirimler, Ekran
          Parlaklığı, Spor Takibi ve Açık Uygulamalar Pil Tüketimini Etkiler.
        </p>
      </details>
    </div>

    <div class="card">
      <h2>Ürün Hakkında</h2>

      <p>
        Teknik Özellikler, Teslimat Bilgisi ve Ürünün Öne Çıkan Özellikleri için
        Aşağıdaki Butona Basabilirsiniz.
      </p>

      <button
        class="btn-modal"
        onclick="document.getElementById('bilgiModal').showModal()"
      >
        Detaylı Bilgi Al
      </button>
    </div>

    <dialog id="bilgiModal">
      <h2>Samsung Galaxy Watch6 Detayları</h2>

      <p>
        Samsung Galaxy Watch6; Modern Tasarımı, Dokunmatik Ekranı ve Günlük
        Kullanıma Uygun Akıllı Özellikleri ile Öne Çıkar. Saat Üzerinden
        Bildirimleri Görüntüleyebilir, Aramaları Takip Edebilir ve Egzersiz
        Verilerinizi Kontrol Edebilirsiniz.
      </p>

      <p>
        Uyku Takibi, Kalp Atış Hızı, Ölçümü ve Aktivite Takibi Gibi Özellikler
        Günlük Sağlık Düzeninizi Takip Etmenize Yardımcı Olur.
      </p>

      <p>
        <strong>Kutu İçeriği:</strong> Galaxy Watch 6 Akıllı Saat, Şarj Kablosu
        ve Kullanım Kılavuzu.
      </p>

      <p><strong>Tahmini Teslimat Süresi:</strong> 2-4 İş Günü</p>

      <button
        class="close-btn"
        onclick="document.getElementById('bilgiModal').close()"
      >
        Kapat
      </button>
    </dialog>
  </body>
</html>
```