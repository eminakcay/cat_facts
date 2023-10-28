import 'package:cat_facts/features/home/data/models/fact_model.dart';

abstract class FactRepository {
  Future<FactModel?> getFact();
}
