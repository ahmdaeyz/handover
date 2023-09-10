import 'package:get_it/get_it.dart';
import 'package:handover/core/application/di/injection_container.config.dart';
import 'package:injectable/injectable.dart';

GetIt getIt = GetIt.instance;

@InjectableInit()
Future<GetIt> initializeDI() async => getIt.init();
