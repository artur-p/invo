import 'package:bloc/bloc.dart';

abstract class InvoCubit<State> extends Cubit<State> {
  InvoCubit(super.initialState);

  @override
  void emit(State state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
