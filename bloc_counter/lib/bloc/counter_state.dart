part of 'counter_bloc.dart';

abstract class CounterState extends Equatable {
  const CounterState();

  @override
  List<Object> get props => [];
}

class CounterInit extends CounterState {
  final int data;
  CounterInit(this.data);
  @override
  List<Object> get props => [data];
}

class CounterLoaded extends CounterState {
  final int data;

  CounterLoaded(this.data);
  @override
  List<Object> get props => [data];
}
