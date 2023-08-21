class Position {
  final int _row, _col;

  Position(this._row, this._col);

  int get row => _row;
  int get col => _col;

  bool isValid() => _row >= 0 && _row < 3 && _col >= 0 && _col < 3;
}
