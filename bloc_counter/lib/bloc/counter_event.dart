part of 'counter_bloc.dart';

abstract class CounterEvent extends Equatable {
  const CounterEvent();
  @override
  List<Object> get props => [];
}

class IncreaseEvent extends CounterEvent {
  final int data;
  IncreaseEvent(this.data);
  @override
  List<Object> get props => [data];
}

class DecreaseEvent extends CounterEvent {
  final int data;
  DecreaseEvent(this.data);
  @override
  List<Object> get props => [data];
}
