abstract class Canavar {
  void kukre();
}

class KurtCanavari extends Canavar {
  @override
  void kukre() {
    print("Avuuuu! Kurt uludu.");
  }
}

class EjderhaCanavari extends Canavar {
  @override
  void kukre() {
    print("ROAAAR! Ejderha yeri göğü inletti.");
  }
}

void main() {
  Canavar kurt = KurtCanavari();
  Canavar ejderha = EjderhaCanavari();

  kurt.kukre();
  ejderha.kukre();
}
