mixin YuzmeYetisi {
  void dalisYap() {
    print("Su altına daldı");
  }
}

class TemelYetkili {
  final String ad;
  TemelYetkili({required this.ad});
}

class Denizci extends TemelYetkili with YuzmeYetisi {
  Denizci({required super.ad});

  void seyirEt() {
    print("$ad denize açılıyor...");
  }
}

void main() {
  final denizci = Denizci(ad: "Kaptan Selami");
  denizci.seyirEt();
  denizci.dalisYap();
}
