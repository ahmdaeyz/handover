import 'package:dartz/dartz.dart';
import 'package:handover/core/data/models/exceptions/application_exception.dart';
import 'package:handover/core/domain/entities/failures/failure.dart';
import 'package:handover/generated/l10n.dart';

Future<Either<Failure, R>> conclude<R>(
  Future<R> Function() target, {
  String? context,
}) async {
  try {
    return Right(await target());
  } on ApplicationException catch (e) {
    return Left(
      GenericFailure(message: e.toString()),
    );
  } catch (e) {
    return Left(GenericFailure(message: S.current.somethingIsWrong));
  }
}
