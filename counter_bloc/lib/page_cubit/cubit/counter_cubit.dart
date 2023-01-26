
import 'package:bloc/bloc.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
   CounterCubit() : super(CounterStateInitial());
}