import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:invo_app/app/di/injector.config.dart';

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: true,
)
void configureDependencies({required Environment environment}) {
  GetIt.I.$initGetIt(environment: environment.name);
}
