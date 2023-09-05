import 'package:equatable/equatable.dart';

typedef PositionList = List<Position>;

class Position extends Equatable {
  final int _row, _col;

  Position(this._row, this._col);

  int get row => _row;
  int get col => _col;

  bool isValid() => _row >= 0 && _row < 3 && _col >= 0 && _col < 3;

  @override
  List<Object?> get props => [_row, _col];
}
