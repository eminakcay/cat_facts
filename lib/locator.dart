import 'package:cat_facts/features/home/data/data_sources/fact_api_service.dart';
import 'package:cat_facts/features/home/data/data_sources/image_api_service.dart';
import 'package:cat_facts/features/home/data/repositories/fact_repository_impl.dart';
import 'package:cat_facts/features/home/data/repositories/image_repository_impl.dart';
import 'package:cat_facts/features/home/domain/usecases/get_fact_use_case.dart';
import 'package:cat_facts/features/home/domain/usecases/get_image_use_case.dart';
import 'package:cat_facts/utils/app_context.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

Future<void> initializeDependencies() async {
  //App Context
  locator.registerSingleton(AppContext());

  //Services
  locator.registerSingleton(FactApiService(locator()));
  locator.registerSingleton(ImageApiService(locator()));

  //Repositories
  locator.registerSingleton(FactRepositoryImpl(locator()));
  locator.registerSingleton(ImageRepositoryImpl(locator()));

  // UseCases
  locator.registerSingleton(GetFactUseCase(locator(), locator()));
  locator.registerSingleton(GetImageUseCase(locator(), locator()));
}
