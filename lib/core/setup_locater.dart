import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:user_list/service/user_service.dart';
import 'package:user_list/view_models/view_model.dart';

final getIt = GetIt.instance;
const _baseUrl = 'https://jsonplaceholder.typicode.com/usersdsd';

void setupLocater() {
  // Configuração do Dio
  getIt.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: const Duration(milliseconds: 5000),
        receiveTimeout: const Duration(milliseconds: 3000),
      ),
    ),
  );

  // Registro do UserService com Dio injetado
  getIt.registerLazySingleton<UserService>(() => UserService(_baseUrl, dio: getIt<Dio>()));

  // Registro do UserViewModel
  getIt.registerLazySingleton<ViewModel>(() => ViewModel(userServic: getIt<UserService>()));
}
