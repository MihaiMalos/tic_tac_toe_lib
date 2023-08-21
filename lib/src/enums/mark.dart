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
}
