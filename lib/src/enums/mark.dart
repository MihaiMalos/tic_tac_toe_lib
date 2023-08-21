enum Mark {
  x,
  o,
  empty;

  bool get isEmpty => this == Mark.empty;
  bool isSame(Mark other) => this == other;

  Mark get opposite {
    if (isEmpty) {
      return Mark.empty;
    }
    return Mark.values[(index + 1) % 2];
  }

  static Mark parse(String str) {
    if (str == 'x' || str == 'X') return Mark.x;
    if (str == 'o' || str == 'O') return Mark.o;
    return Mark.empty;
  }
}
