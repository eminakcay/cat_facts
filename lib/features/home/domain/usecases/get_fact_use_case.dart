import 'package:cat_facts/core/usecase/usecase.dart';
import 'package:cat_facts/features/home/data/repositories/fact_repository_impl.dart';
import 'package:cat_facts/features/home/presentation/provider/home_provider.dart';
import 'package:cat_facts/utils/app_context.dart';
import 'package:provider/provider.dart';

class GetFactUseCase implements UseCase<void, void> {
  final FactRepositoryImpl _repo;
  final AppContext _appContext;

  GetFactUseCase(this._repo, this._appContext);

  @override
  Future<void> call({params}) async {
    final context = _appContext.navigatorContext;

    context.read<HomeProvider>().isFactLoading = true;
    final fact = await _repo.getFact();

    if (context.mounted) {
      context.read<HomeProvider>().factResult = fact;
      context.read<HomeProvider>().isFactLoading = false;
    }
  }
}
