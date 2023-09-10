import 'package:handover/core/data/models/exceptions/application_exception.dart';
import 'package:handover/generated/l10n.dart';
import 'package:logger/logger.dart';

Future<T> resolveOrThrow<T>(
  Future<T> Function() target, {
  String? context,
}) async {
  final logger = Logger();
  try {
    return await target();
  } on Exception catch (e, s) {
    logger.e('DataSourceError:\n $e', error: e, stackTrace: s);

    throw GenericApplicationException(message: S.current.somethingIsWrong);
  } catch (e, s) {
    logger.e('DataSourceError:\n $e', error: e, stackTrace: s);

    throw GenericApplicationException(message: S.current.somethingIsWrong);
  }
}
