import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterInit(0)) {
    on<IncreaseEvent>((event, emit) {
      if (state is CounterInit) {
        final state = this.state as CounterInit;
        emit(CounterLoaded(state.data+1));
      }
      if (state is CounterLoaded) {
        final state = this.state as CounterLoaded;
        emit(CounterLoaded(state.data+1));
      }

    });
    on<DecreaseEvent>((event, emit) {
      if (state is CounterInit) {
        final state = this.state as CounterInit;
        emit(CounterLoaded(state.data-1));
      }
      if (state is CounterLoaded) {
        final state = this.state as CounterLoaded;
        emit(CounterLoaded(state.data-1));
      }
    });
  }
}
