part of 'counter_bloc.dart';

abstract class CounterEvent extends Equatable {
  const CounterEvent();

  @override
  List<Object> get props => [];
}

class IncreaseEvent extends CounterEvent {
  final int counter;
  const IncreaseEvent(this.counter);
  @override
  List<Object> get props => [counter];
}

class DecreaseEvent extends CounterEvent {
    final int counter;
  @override
  List<Object> get props => [counter];
  const DecreaseEvent(this.counter);
}
