```html
<!doctype html>
<html lang="tr">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <title>Ürün Detay & Sepet</title>

    <style>
      *,
      *::before,
      *::after {
        box-sizing: border-box;
        margin: 0;
        padding: 0;
      }

      :root {
        --primary: #0f766e;
        --primary-dark: #115e59;
        --primary-light: #14b8a6;
        --blue: #2563eb;
        --success: #16a34a;
        --danger: #dc2626;
        --bg: #eff6ff;
        --surface: #ffffff;
        --text-main: #0f172a;
        --text-muted: #64748b;
        --border: #dbeafe;
        --shadow: 0 10px 25px rgba(15, 118, 110, 0.12);
      }

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
        min-height: 100vh;
        background: var(--bg);
        color: var(--text-main);
      }

      .app-container {
        width: 100%;
        max-width: 480px;
        min-height: 100vh;
        margin: 0 auto;
        overflow: hidden;
        background: var(--surface);
        box-shadow: var(--shadow);
      }

      /* Sticky mobil menü */
      .mobile-menu {
        position: sticky;
        top: 0;
        z-index: 100;
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 16px 20px;
        border-bottom: 1px solid var(--border);
        background: rgba(255, 255, 255, 0.94);
        backdrop-filter: blur(12px);
      }

      .brand {
        display: flex;
        align-items: center;
        gap: 10px;
        color: var(--primary-dark);
        font-weight: 800;
      }

      .brand-icon {
        width: 36px;
        height: 36px;
        display: flex;
        justify-content: center;
        align-items: center;
        border-radius: 12px;
        background: linear-gradient(135deg, var(--blue), var(--primary-light));
        color: white;
        font-size: 18px;
      }

      .menu-actions {
        display: flex;
        gap: 12px;
      }

      .menu-button {
        width: 36px;
        height: 36px;
        display: flex;
        justify-content: center;
        align-items: center;
        border: none;
        border-radius: 50%;
        background: #eff6ff;
        color: var(--primary-dark);
        font-size: 17px;
        cursor: pointer;
      }

      .product-content {
        padding: 20px;
      }

      .breadcrumb {
        margin-bottom: 16px;
        color: var(--text-muted);
        font-size: 12px;
      }

      /* Ürün görsel alanı */
      .product-image-area {
        position: relative;
        height: 300px;
        display: flex;
        justify-content: center;
        align-items: center;
        margin-bottom: 20px;
        overflow: hidden;
        border-radius: 24px;
        background:
          radial-gradient(circle at 30% 20%, #bfdbfe 0, transparent 35%),
          linear-gradient(145deg, #dbeafe, #ecfdf5);
      }

      .product-image-area::after {
        content: "";
        position: absolute;
        bottom: 28px;
        width: 180px;
        height: 25px;
        border-radius: 50%;
        background: rgba(15, 118, 110, 0.2);
        filter: blur(12px);
      }

      .product-image {
        position: relative;
        z-index: 2;
        width: 220px;
        height: 220px;
        display: flex;
        justify-content: center;
        align-items: center;
        border-radius: 50%;
        background: linear-gradient(145deg, var(--blue), var(--primary-light));
        color: white;
        font-size: 86px;
        box-shadow: 0 20px 35px rgba(15, 118, 110, 0.3);
      }

      /* Görsel üzerindeki rozetler */
      .discount-badge {
        position: absolute;
        top: 16px;
        left: 16px;
        z-index: 5;
        padding: 7px 12px;
        border-radius: 20px;
        background: var(--danger);
        color: white;
        font-size: 12px;
        font-weight: 800;
      }

      .shipping-badge {
        position: absolute;
        right: 16px;
        bottom: 16px;
        z-index: 5;
        padding: 7px 12px;
        border-radius: 20px;
        background: var(--success);
        color: white;
        font-size: 12px;
        font-weight: 800;
      }

      .product-heading {
        display: flex;
        justify-content: space-between;
        align-items: flex-start;
        gap: 12px;
        margin-bottom: 10px;
      }

      .product-title {
        font-size: 24px;
        line-height: 1.2;
      }

      .favorite-button {
        width: 40px;
        height: 40px;
        flex-shrink: 0;
        border: 1px solid var(--border);
        border-radius: 50%;
        background: white;
        color: var(--danger);
        font-size: 20px;
        cursor: pointer;
      }

      .rating-row {
        display: flex;
        align-items: center;
        gap: 8px;
        margin-bottom: 16px;
        font-size: 13px;
      }

      .stars {
        color: #f59e0b;
        letter-spacing: 2px;
      }

      .review-count {
        color: var(--text-muted);
      }

      .price-row {
        display: flex;
        align-items: center;
        gap: 10px;
        margin-bottom: 18px;
      }

      .current-price {
        color: var(--blue);
        font-size: 25px;
        font-weight: 800;
      }

      .old-price {
        color: var(--text-muted);
        font-size: 14px;
        text-decoration: line-through;
      }

      .product-description {
        margin-bottom: 22px;
        color: var(--text-muted);
        font-size: 14px;
        line-height: 1.7;
      }

      .option-section {
        margin-bottom: 22px;
      }

      .option-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 10px;
      }

      .option-title {
        font-size: 15px;
        font-weight: 800;
      }

      .option-info {
        color: var(--text-muted);
        font-size: 12px;
      }

      /* Renk seçenekleri */
      .color-list {
        display: flex;
        gap: 14px;
      }

      .color-chip {
        width: 30px;
        height: 30px;
        border: 3px solid white;
        border-radius: 50%;
        outline: 1px solid #cbd5e1;
        cursor: pointer;
      }

      .color-chip.selected {
        outline: 3px solid var(--primary);
        outline-offset: 2px;
      }

      .color-black {
        background: #111827;
      }

      .color-white {
        background: #ffffff;
      }

      .color-red {
        background: #ef4444;
      }

      /*
        Ürün adedi ve Sepete Ekle alanı
        Adet solda, buton sağda bulunur.
      */
      .cart-action-row {
        display: flex;
        align-items: center;
        gap: 12px;
        margin: 26px 0 22px;
      }

      .quantity-control {
        display: flex;
        align-items: center;
        gap: 16px;
        padding: 5px 8px;
        border: 1px solid var(--border);
        border-radius: 12px;
        background: white;
      }

      .quantity-button {
        width: 30px;
        height: 30px;
        border: none;
        border-radius: 8px;
        background: #ecfdf5;
        color: var(--primary-dark);
        font-size: 20px;
        font-weight: 700;
        cursor: pointer;
      }

      .quantity-button:hover {
        background: #ccfbf1;
      }

      .quantity-number {
        min-width: 18px;
        text-align: center;
        font-size: 16px;
        font-weight: 800;
      }

      .add-cart-button {
        flex: 1;
        min-height: 42px;
        padding: 12px 14px;
        border: none;
        border-radius: 11px;
        background: linear-gradient(135deg, var(--blue), var(--primary));
        color: white;
        font-size: 13px;
        font-weight: 800;
        cursor: pointer;
        box-shadow: 0 7px 15px rgba(37, 99, 235, 0.22);
        transition: 0.2s ease;
      }

      .add-cart-button:hover {
        background: linear-gradient(
          135deg,
          var(--primary),
          var(--primary-dark)
        );
        transform: translateY(-2px);
      }

      .add-cart-button:active {
        transform: translateY(0);
      }

      .delivery-card {
        display: flex;
        align-items: center;
        gap: 12px;
        padding: 14px;
        margin-bottom: 20px;
        border: 1px solid #a7f3d0;
        border-radius: 14px;
        background: #ecfdf5;
      }

      .delivery-icon {
        width: 38px;
        height: 38px;
        display: flex;
        justify-content: center;
        align-items: center;
        border-radius: 11px;
        background: #d1fae5;
        font-size: 19px;
      }

      .delivery-card strong {
        display: block;
        margin-bottom: 3px;
        font-size: 13px;
      }

      .delivery-card span {
        color: var(--text-muted);
        font-size: 12px;
      }

      .details-tabs {
        display: flex;
        justify-content: space-between;
        gap: 8px;
        padding-top: 18px;
        border-top: 1px solid var(--border);
      }

      .details-tabs span {
        color: var(--text-muted);
        font-size: 13px;
        font-weight: 700;
      }

      .details-tabs span:first-child {
        color: var(--primary);
      }

      @media (max-width: 360px) {
        .product-content {
          padding: 16px;
        }

        .product-image-area {
          height: 270px;
        }

        .product-image {
          width: 190px;
          height: 190px;
          font-size: 70px;
        }

        .quantity-control {
          gap: 10px;
        }

        .add-cart-button {
          padding: 11px 8px;
          font-size: 12px;
        }
      }
    </style>
  </head>

  <body>
    <div class="app-container">
      <!-- Sticky mobil menü -->
      <header class="mobile-menu">
        <div class="brand">
          <div class="brand-icon">✦</div>
          <span>NovaMarket</span>
        </div>

        <div class="menu-actions">
          <button class="menu-button" aria-label="Arama">⌕</button>
          <button class="menu-button" aria-label="Menü">☰</button>
        </div>
      </header>

      <main class="product-content">
        <p class="breadcrumb">Ana Sayfa / Elektronik / Ses Sistemleri</p>

        <section class="product-image-area">
          <span class="discount-badge">%25 İNDİRİM</span>

          <div class="product-image">🎧</div>

          <span class="shipping-badge">🚚 KARGO BEDAVA</span>
        </section>

        <section>
          <div class="product-heading">
            <h1 class="product-title">Aura Pro Kablosuz Kulaklık</h1>

            <button class="favorite-button" aria-label="Favorilere ekle">
              ♡
            </button>
          </div>

          <div class="rating-row">
            <span class="stars">★★★★★</span>
            <strong>4,8</strong>
            <span class="review-count">(128 değerlendirme)</span>
          </div>

          <div class="price-row">
            <strong class="current-price">2.249 ₺</strong>
            <span class="old-price">2.999 ₺</span>
          </div>

          <p class="product-description">
            Aktif gürültü engelleme özelliği, uzun pil ömrü ve konforlu
            tasarımıyla gün boyu kullanabileceğiniz yeni nesil kablosuz
            kulaklık.
          </p>
        </section>

        <!-- Renk seçenekleri -->
        <section class="option-section">
          <div class="option-header">
            <h2 class="option-title">Renk</h2>

            <!-- Bu yazı JavaScript ile değiştirilecek -->
            <span id="selected-color" class="option-info">Siyah</span>
          </div>

          <div class="color-list">
            <button
              class="color-chip color-black selected"
              data-color="Siyah"
              aria-label="Siyah renk"
            ></button>

            <button
              class="color-chip color-white"
              data-color="Beyaz"
              aria-label="Beyaz renk"
            ></button>

            <button
              class="color-chip color-red"
              data-color="Kırmızı"
              aria-label="Kırmızı renk"
            ></button>
          </div>
        </section>

        <!-- Ürün adedi ve Sepete Ekle -->
        <section class="cart-action-row">
          <div class="quantity-control">
            <button
              id="decrease-button"
              class="quantity-button"
              aria-label="Ürün azalt"
            >
              −
            </button>

            <span id="quantity-number" class="quantity-number">1</span>

            <button
              id="increase-button"
              class="quantity-button"
              aria-label="Ürün artır"
            >
              +
            </button>
          </div>

          <button id="add-cart-button" class="add-cart-button">
            Sepete Ekle 🛒
          </button>
        </section>

        <div class="delivery-card">
          <div class="delivery-icon">📦</div>

          <div>
            <strong>Hızlı ve ücretsiz teslimat</strong>
            <span>Siparişiniz 2-3 iş günü içinde kargoda.</span>
          </div>
        </div>

        <div class="details-tabs">
          <span>Açıklama</span>
          <span>Özellikler</span>
          <span>Yorumlar</span>
        </div>
      </main>
    </div>

    <script>
      const colorButtons = document.querySelectorAll(".color-chip");
      const selectedColor = document.querySelector("#selected-color");

      const decreaseButton = document.querySelector("#decrease-button");
      const increaseButton = document.querySelector("#increase-button");
      const quantityNumber = document.querySelector("#quantity-number");

      const favoriteButton = document.querySelector(".favorite-button");
      const cartButton = document.querySelector("#add-cart-button");

      let quantity = 1;

      /*
        Renk seçildiğinde:
        1. Önce bütün renklerin selected sınıfı kaldırılır.
        2. Tıklanan renge selected sınıfı eklenir.
        3. Sağdaki renk yazısı data-color değerine göre güncellenir.
      */
      colorButtons.forEach((button) => {
        button.addEventListener("click", () => {
          colorButtons.forEach((item) => {
            item.classList.remove("selected");
          });

          button.classList.add("selected");

          selectedColor.textContent = button.dataset.color;
        });
      });

      /* Ürün adedini azaltma */
      decreaseButton.addEventListener("click", () => {
        if (quantity > 1) {
          quantity--;
          quantityNumber.textContent = quantity;
        }
      });

      /* Ürün adedini artırma */
      increaseButton.addEventListener("click", () => {
        quantity++;
        quantityNumber.textContent = quantity;
      });

      /* Favoriye ekleme */
      favoriteButton.addEventListener("click", () => {
        if (favoriteButton.textContent.trim() === "♡") {
          favoriteButton.textContent = "♥";
          favoriteButton.style.backgroundColor = "#fee2e2";
        } else {
          favoriteButton.textContent = "♡";
          favoriteButton.style.backgroundColor = "white";
        }
      });

      /* Sepete ekleme */
      cartButton.addEventListener("click", () => {
        cartButton.textContent = quantity + " Ürün Eklendi ✓";
        cartButton.style.backgroundColor = "#16a34a";

        setTimeout(() => {
          cartButton.textContent = "Sepete Ekle 🛒";
          cartButton.style.backgroundColor = "";
        }, 1800);
      });
    </script>
  </body>
</html>
```