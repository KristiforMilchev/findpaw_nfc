import 'package:application/implementations/exception_manager.dart';
import 'package:application/implementations/local_storage.dart';
import 'package:application/implementations/nfc_service.dart';
import 'package:application/implementations/observer.dart';
import 'package:application/implementations/page_router_service.dart';
import 'package:application/implementations/tag_repository.dart';

import 'package:get_it/get_it.dart';
import 'package:infrastructure/interfaces/iexception_manager.dart';
import 'package:infrastructure/interfaces/ilocal_storage.dart';
import 'package:infrastructure/interfaces/infc_service.dart';
import 'package:infrastructure/interfaces/iobserver.dart';
import 'package:infrastructure/interfaces/ipage_router_service.dart';
import 'package:infrastructure/interfaces/itag_repository.dart';

GetIt getIt = GetIt.I;
void registerDependency() {
  Observer observer = Observer();
  LocalStorage localStorage = LocalStorage();
  TagRepository tagRepository = TagRepository(localStorage);
  getIt.registerSingleton<IExceptionManager>(ExceptionManager());
  getIt.registerSingleton<IPageRouterService>(PageRouterService(observer));
  getIt.registerSingleton<IObserver>(observer);
  getIt.registerSingleton<INfcService>(NfcService(observer, tagRepository));
  getIt.registerSingleton<IlocalStorage>(localStorage);
  getIt.registerSingleton<ITagRepository>(tagRepository);

  /// TPM Not implemented
}

void registerFactory<T>(FactoryFunc<T> func) {
  getIt.registerFactory(() => func);
}

void registerSingleton<T>(FactoryFunc<T> instance) {
  getIt.registerSingleton(instance);
}

void registerLazySingleton<T>(FactoryFunc<T> func) {
  getIt.registerLazySingleton(() => func);
}
