// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:handover/core/application/di/app_module.dart' as _i12;
import 'package:handover/core/application/locale/locale_cubit.dart' as _i5;
import 'package:handover/core/data/data_sources/cache_data_source.dart' as _i8;
import 'package:handover/core/data/data_sources/env_variables.dart' as _i3;
import 'package:handover/core/data/data_sources/secure_cache_data_source.dart'
    as _i9;
import 'package:handover/features/shipment/data/data_sources/shipments_data_source.dart'
    as _i10;
import 'package:handover/features/shipment/data/repositories/shipments_repository.dart'
    as _i11;
import 'package:handover/features/shipment/data/services/shipments_service.dart'
    as _i7;
import 'package:injectable/injectable.dart' as _i2;
import 'package:logger/logger.dart' as _i6;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    gh.lazySingleton<_i3.AppEnvVariables>(
        () => _i3.CurrencyConverterEnvVariables());
    gh.lazySingleton<_i4.FlutterSecureStorage>(() => appModule.secureStorage);
    gh.lazySingleton<_i5.LocaleCubit>(() => _i5.LocaleCubit());
    gh.lazySingleton<_i6.Logger>(() => appModule.logger);
    gh.singleton<_i7.ShipmentsService>(_i7.ShipmentsService());
    gh.lazySingleton<_i8.CacheDataSource>(() => _i9.SecureCacheDataSource(
        secureStorage: gh<_i4.FlutterSecureStorage>()));
    gh.factory<_i10.ShipmentsDataSource>(
        () => _i10.ShipmentsDataSourceImpl(gh<_i7.ShipmentsService>()));
    gh.factory<_i11.ShipmentsRepository>(
        () => _i11.ShipmentsRepository(gh<_i10.ShipmentsDataSource>()));
    return this;
  }
}

class _$AppModule extends _i12.AppModule {}
