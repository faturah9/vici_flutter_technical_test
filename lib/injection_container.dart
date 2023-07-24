import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vici_technical_test/features/register/domain/datas/dao/register_dao.dart';

import 'core/database/db_provider.dart';
import 'features/cart/domain/datas/dao/cart_dao.dart';
import 'features/cart/domain/datas/dao_impl/cart_dao_impl.dart';
import 'features/cart/domain/repository/cart_repository.dart';
import 'features/cart/domain/repository_impl/cart_repository_impl.dart';
import 'features/cart/presentation/cubit/cart_cubit.dart';
import 'features/discover/domain/datas/dao/discover_dao.dart';
import 'features/discover/domain/datas/dao_impl/discover_dao_impl.dart';
import 'features/discover/domain/repository/discover_repository.dart';
import 'features/discover/domain/repository_impl/discover_repository_impl.dart';
import 'features/discover/presentation/cubit/new_discover_cubit.dart';
import 'features/login/domain/datas/dao/login_dao.dart';
import 'features/login/domain/datas/dao_impl/login_dao_impl.dart';
import 'features/login/domain/repository/login_repository.dart';
import 'features/login/domain/repository_impl/login_repository_impl.dart';
import 'features/login/presentation/bloc/login_bloc.dart';
import 'features/register/domain/datas/dao_impl/register_dao_impl.dart';
import 'features/register/domain/repository/register_repository.dart';
import 'features/register/domain/repository_impl/register_repository_impl.dart';
import 'features/register/presentation/bloc/register_bloc.dart';
import 'utils/session_manager.dart';

final sl = GetIt.instance;

Future<GetIt> init() async {
  /// Bloc
  if (!sl.isRegistered<LoginBloc>()) {
    sl.registerLazySingleton(() => LoginBloc());
  }
  if (!sl.isRegistered<RegisterBloc>()) {
    sl.registerLazySingleton(() => RegisterBloc());
  }
  if (!sl.isRegistered<NewDiscoverCubit>()) {
    sl.registerLazySingleton(() => NewDiscoverCubit());
  }
  if (!sl.isRegistered<CartCubit>()) {
    sl.registerLazySingleton(() => CartCubit());
  }

  ///database
  final dbClient = DbClient();
  final db = await dbClient();
  if (!sl.isRegistered<Database>()) {
    sl.registerLazySingleton(() => db);
  }

  ///dao
  if (!sl.isRegistered<RegisterDao>()) {
    sl.registerLazySingleton(() => RegisterDaoImpl());
  }

  if (!sl.isRegistered<LoginDao>()) {
    sl.registerLazySingleton(() => LoginDaoImpl());
  }
  if (!sl.isRegistered<DiscoverDao>()) {
    sl.registerLazySingleton(() => DiscoverDaoImpl());
  }
  if (!sl.isRegistered<CartDao>()) {
    sl.registerLazySingleton(() => CartDaoImpl());
  }

  /// Use cases

  /// Repository
  if (!sl.isRegistered<RegisterRepository>()) {
    sl.registerLazySingleton(() => RegisterRepositoryImpl());
  }
  if (!sl.isRegistered<LoginRepository>()) {
    sl.registerLazySingleton(() => LoginRepositoryImpl());
  }
  if (!sl.isRegistered<DiscoverRepository>()) {
    sl.registerLazySingleton(() => DiscoverRepositoryImpl());
  }
  if (!sl.isRegistered<CartRepository>()) {
    sl.registerLazySingleton(() => CartRepositoryImpl());
  }

  /// Data sources
  // if (!sl.isRegistered<AcqDisbursementRemoteDataSource>()) {
  //   sl.registerLazySingleton(() => AcqDisbursementRemoteDataSource());
  // }

  /// Core
  // if (!sl.isRegistered<ApiClient>()) {
  //   sl.registerLazySingleton(() => ApiClient());
  // }

  /// External
  final sharedPreferences = await SharedPreferences.getInstance();
  if (!sl.isRegistered<SharedPreferences>()) {
    sl.registerLazySingleton(() => sharedPreferences);
  }
  if (!sl.isRegistered<AppSharedPreferences>()) {
    sl.registerLazySingleton(() => AppSharedPreferencesImpl());
  }
  return sl;
}
