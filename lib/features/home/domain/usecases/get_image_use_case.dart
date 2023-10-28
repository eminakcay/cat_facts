import 'package:cat_facts/core/usecase/usecase.dart';
import 'package:cat_facts/features/home/data/repositories/image_repository_impl.dart';
import 'package:cat_facts/features/home/presentation/provider/home_provider.dart';
import 'package:cat_facts/utils/app_context.dart';
import 'package:provider/provider.dart';

class GetImageUseCase implements UseCase<void, void> {
  final ImageRepositoryImpl _repo;
  final AppContext _appContext;

  GetImageUseCase(this._repo, this._appContext);

  @override
  Future<void> call({params}) async {
    final context = _appContext.navigatorContext;

    context.read<HomeProvider>().isImageLoading = true;
    final image = await _repo.getImage();

    if (context.mounted) {
      context.read<HomeProvider>().imageResult = image;
      context.read<HomeProvider>().isImageLoading = false;
    }
  }
}
