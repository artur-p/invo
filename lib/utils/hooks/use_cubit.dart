import 'package:bloc/bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

T useCubit<T extends Cubit<dynamic>>(
  T Function() builder, [
  List<Object?> keys = const <Object>[],
]) {
  final cubit = useMemoized(builder, keys);

  useEffect(() => cubit.close, [cubit, ...keys]);

  return cubit;
}
