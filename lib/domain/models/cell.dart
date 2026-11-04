class Cell {
  Cell({required this.x, required this.y, this.available = true});

  factory Cell.fromJson(Map<String, dynamic> json) {
    return Cell(x: json['x'], y: json['y']);
  }

  int x;

  int y;

  bool available;

  Map<String, dynamic> toJson() {
    return {
      'x': x.toString(),
      'y' : y.toString(),
    };
  }

  @override
  String toString() {
    return '($x,$y)';
  }

  @override
  bool operator ==(Object other) {
    return other is Cell && other.x == x && other.y == y;
  }

  @override
  int get hashCode => Object.hash(x, y, available);
}