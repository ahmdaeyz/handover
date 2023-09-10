import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@module
abstract class AppModule {
  @lazySingleton
  FlutterSecureStorage get secureStorage {
    const androidOptions = AndroidOptions(
      encryptedSharedPreferences: true,
    );
    const storage = FlutterSecureStorage(aOptions: androidOptions);

    return storage;
  }

  @lazySingleton
  Logger get logger => Logger(
        printer: PrettyPrinter(),
      );
}
