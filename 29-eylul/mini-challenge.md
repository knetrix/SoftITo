```dart
// Bir bulut kümesinde çalışan servislerin isimlerini içeren bir Set<String> tanımlayın (mükerrer kayıtları elemek için). Ardından bir boolean bool isProduction = true; bayrağı tanımlayın. Eğer ortam prodüksiyon ise listeye "vault-secret-manager" servisini Collection if ile ekleyen ve tüm servisleri içeren bir List<String> oluşturup ekrana yazdırın.

void main() {
  final bool isProduction = true;
  final Set<String> temelServisler = {
    "api-gateway",
    "auth-service",
  };

  final List<String> nihaiDagitimKumesi = [
    ...temelServisler,
    if (isProduction) "vault-secret-manager",
  ];

  print("Dağıtım Kümesi: $nihaiDagitimKumesi");
}
```