import 'package:cat_facts/features/home/data/data_sources/fact_api_service.dart';
import 'package:cat_facts/features/home/data/models/fact_model.dart';
import 'package:cat_facts/features/home/domain/repositories/fact_repository.dart';

class FactRepositoryImpl implements FactRepository {
  final FactApiService _apiService;
  const FactRepositoryImpl(this._apiService);

  @override
  Future<FactModel?> getFact() async {
    return await _apiService.fetchFact();
  }
}
