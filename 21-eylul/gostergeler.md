```html
<html lang="en">
  <head>
    <meta
      name="viewport"
      content="width=device-width,
    initial-scale=1.0"
    />
    <title>Yerel HTML5 Göstergeleri</title>
    <style>
      body {
        font-family:
          system-ui,
          -apple-system,
          BlinkMacSystemFont,
          "Segoe UI",
          Roboto,
          Oxygen,
          Ubuntu,
          Cantarell,
          "Open Sans",
          "Helvetica Neue",
          sans-serif;
        background: #f8fafc;
        padding: 24px;
        max-width: 480px;
        margin: auto;
      }

      .card {
        background: white;
        padding: 20px;
        border-radius: 12px;
        border: 1px solid #e2e8f0;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.5);
        margin-bottom: 15px;
      }

      label {
        display: block;
        font-weight: bold;
        font-size: 13px;
        margin-bottom: 6px;
      }

      progress,
      meter {
        width: 100%;
        height: 24px;
        margin-bottom: 8px;
      }

      .hint {
        font-size: 12px;
        color: #64748b;
      }
    </style>
  </head>
  <body>
    <div class="card">
      <h3>HTML5 Yerel Göstergeler (Sıfır JS)</h3>

      <!--İlerleme Çubuğu-->
      <label for="p1">Profil Doluluk Oranı</label>
      <progress id="p1" value="75" max="100">75%</progress>
      <div class="hint">İlerleme Çubuğu (Progress):75% Tamamlandı</div>

      <hr style="margin: 16px 0; border: 0; border-top: 1px solid #e2e8f0" />

      <!--2.Batarya Durumu (otomatik renklenen meter)-->
      <label for="m1">Mobil Batarya Seviyesi (15%-Kritik Düşük):</label>
      <meter
        value="10"
        id="m1"
        min="0"
        max="100"
        low="20"
        high="80"
        optimum="90"
      ></meter>
      <div class="hint">
        Kritik Seviyede Olduğu için Tarayıcı Bunu Otomatik
        <strong>Kırmızı</strong>Renkle Uyarır!
      </div>

      <br />

      <label for="m2">Mobil Bayarya Seviyesi(85%-İdeal):</label>
      <meter
        value="85"
        id="m2"
        min="0"
        max="100"
        low="20"
        high="80"
        optimum="90"
      ></meter>
      <div class="hint">
        İdeal Seviyede Olduğu için Tarayıcı Bunu Otomatik
        Olarak<strong>Yeşil</strong>Renkle Gösterir!
      </div>
    </div>
  </body>
</html>
```