class Niveles {
  final List<int> barreras;
  final List<int> monedas;
  final List<int> enemigo;
  final List enemigo2;
  final int meta;

  Niveles(this.barreras, this.monedas, this.enemigo, this.enemigo2, this.meta);

  Niveles.fromJson(Map<String, dynamic> json)
      : barreras = json["barreras"],
        monedas = json["monedas"],
        enemigo = json["enemigo"],
        enemigo2 = json["enemigo2"],
        meta = json["meta"];
}

Map<String, dynamic> nivelA = {
  "barreras": [130],
  "monedas": [130],
  "enemigo": [130],
  "enemigo2": [],
  "meta": 130
};
