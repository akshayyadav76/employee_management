
import 'package:get_it/get_it.dart';

import '../data/data_sources/employee_local_data_source.dart';
import '../data/repositories/empolyee_repository_impl.dart';
import '../domain/repositories/employee_repository.dart';
import '../presentation/bloc/employee_cubit.dart';

final getItInstance = GetIt.I;

void registerDependencies() {
  getItInstance.registerLazySingleton<EmployeeLocalDataSource>(
      () => EmployeeLocalDataSourceImpl());

  getItInstance.registerLazySingleton<EmployeeRepository>(
      () => EmployeeRepositoryImpl(getItInstance()));

  getItInstance.registerFactory(() => EmployeeCubit(getItInstance()));
}
