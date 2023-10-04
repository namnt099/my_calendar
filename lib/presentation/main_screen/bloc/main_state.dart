import 'package:equatable/equatable.dart';

abstract class MainState extends Equatable {
  const MainState();
}

class InitialState extends MainState {
  @override
  List<Object> get props => [];
}

class Loading extends MainState {
  @override
  List<Object> get props => [];
}
