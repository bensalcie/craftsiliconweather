// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter/services.dart' as _i281;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../../features/home/data/datasources/get_forecast_remote_datasource.dart'
    as _i1073;
import '../../../features/home/data/datasources/get_weather_remote_datasource.dart'
    as _i950;
import '../../../features/home/data/repositories/get_forecast_repository_impl.dart'
    as _i335;
import '../../../features/home/data/repositories/get_weather_repository_impl.dart'
    as _i437;
import '../../../features/home/domain/repositories/get_forecast_repository.dart'
    as _i986;
import '../../../features/home/domain/repositories/get_weather_repository.dart'
    as _i356;
import '../../../features/home/domain/usecases/get_forecast_usecase.dart'
    as _i1036;
import '../../../features/home/domain/usecases/get_weather_usecase.dart'
    as _i889;
import '../../../features/home/presentation/bloc/get_forecast_bloc.dart'
    as _i931;
import '../../../features/home/presentation/bloc/get_weather_bloc.dart'
    as _i695;
import '../../../features/home/presentation/bloc/location_permission_bloc.dart'
    as _i761;
import '../../../features/home/presentation/bloc/search_weather_bloc.dart'
    as _i205;
import '../data/datasources/local/storage_utils.dart' as _i910;
import '../network/dio_config.dart' as _i150;
import 'module_injection.dart' as _i237;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModules = _$RegisterModules();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModules.prefs,
      preResolve: true,
    );
    gh.singleton<_i281.MethodChannel>(() => registerModules.channel);
    gh.lazySingleton<_i910.StorageUtils>(
        () => _i910.StorageUtils(gh<_i460.SharedPreferences>()));
    gh.factory<_i695.GetWeatherBloc>(() => _i695.GetWeatherBloc(
          gh<_i889.GetWeatherUseCase>(),
          gh<_i910.StorageUtils>(),
        ));
    gh.factory<_i205.SearchWeatherBloc>(() => _i205.SearchWeatherBloc(
          gh<_i889.GetWeatherUseCase>(),
          gh<_i910.StorageUtils>(),
        ));
    gh.factory<_i761.LocationPermissionBloc>(
        () => _i761.LocationPermissionBloc(gh<_i910.StorageUtils>()));
    gh.factory<String>(
      () => registerModules.baseUrl,
      instanceName: 'BaseUrl',
    );
    gh.lazySingleton<_i889.GetWeatherUseCase>(
        () => _i889.GetWeatherUseCase(gh<_i356.GetWeatherRepository>()));
    gh.lazySingleton<_i361.Dio>(
        () => registerModules.dio(gh<String>(instanceName: 'BaseUrl')));
    gh.lazySingleton<_i150.DioClient>(() => _i150.DioClient(gh<_i361.Dio>()));
    gh.lazySingleton<_i1073.GetForecastRemoteDataSource>(
        () => _i1073.GetForecastRemoteDataSourceImpl(gh<_i150.DioClient>()));
    gh.lazySingleton<_i950.GetWeatherRemoteDataSource>(
        () => _i950.GetWeatherRemoteDataSourceImpl(gh<_i150.DioClient>()));
    gh.lazySingleton<_i356.GetWeatherRepository>(() =>
        _i437.GetWeatherRepositoryImpl(gh<_i950.GetWeatherRemoteDataSource>()));
    gh.lazySingleton<_i986.GetForecastRepository>(() =>
        _i335.GetForecastRepositoryImpl(
            gh<_i1073.GetForecastRemoteDataSource>()));
    gh.lazySingleton<_i1036.GetForecastUseCase>(
        () => _i1036.GetForecastUseCase(gh<_i986.GetForecastRepository>()));
    gh.factory<_i931.GetForecastBloc>(
        () => _i931.GetForecastBloc(gh<_i1036.GetForecastUseCase>()));
    return this;
  }
}

class _$RegisterModules extends _i237.RegisterModules {}
