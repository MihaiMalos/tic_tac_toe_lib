typedef MarkMatrix = List<List<Mark>>;

enum Mark {
  x,
  o,
  empty;

  bool get isEmpty => this == Mark.empty;
  bool isSame(Mark other) => this == other;

  Mark get opposite => isEmpty ? Mark.empty : Mark.values[(index + 1) % 2];

  static Mark parse(String str) {
    List<String> input = ['x', 'o', '.'];
    List<Mark> output = [Mark.x, Mark.o, Mark.empty];
    int index = input.indexOf(str);
    if (index == -1) throw Exception("Invalid string");
    return output[index];
  }
}
