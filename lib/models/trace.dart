class Trace {
  final String id;
  final bool roomWindow;
  final bool roomOutlet;
  final bool kitchenOutlet;
  final bool burner;
  final bool clothesIron;
  final DateTime createdAt;

  Trace({
    required this.id,
    required this.roomWindow,
    required this.roomOutlet,
    required this.kitchenOutlet,
    required this.burner,
    required this.clothesIron,
    required this.createdAt,
  });

  factory Trace.fromDoc(String id, Map<String, dynamic> data) {
    return Trace(
      id: id,
      roomWindow: data["roomWindow"],
      roomOutlet: data["roomOutlet"],
      kitchenOutlet: data["kitchenOutlet"],
      burner: data["burner"],
      clothesIron: data["clothesIron"],
      createdAt: data["createdAt"].toDate(),
    );
  }
}
