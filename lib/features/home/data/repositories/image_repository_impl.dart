import 'dart:typed_data';

import 'package:cat_facts/features/home/data/data_sources/image_api_service.dart';
import 'package:cat_facts/features/home/domain/repositories/image_repository.dart';

class ImageRepositoryImpl implements ImageRepository {
  final ImageApiService _apiService;
  const ImageRepositoryImpl(this._apiService);

  @override
  Future<Uint8List?> getImage() async {
    return await _apiService.fetchImage();
  }
}
