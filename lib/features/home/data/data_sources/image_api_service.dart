import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:cat_facts/core/constants/constants.dart';
import 'package:cat_facts/core/enums/api_error.dart';
import 'package:cat_facts/features/home/presentation/provider/home_provider.dart';
import 'package:cat_facts/utils/app_context.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class ImageApiService {
  final AppContext _appContext;
  const ImageApiService(this._appContext);

  Future<Uint8List?> fetchImage() async {
    final provider = Provider.of<HomeProvider>(
      _appContext.navigatorContext,
      listen: false,
    );

    final uri = Uri.parse('$IMAGE_BASE_URL$IMAGE_PATH');
    Response? response;
    try {
      response = await http.get(uri);
    } on TimeoutException catch (_) {
      provider.apiError = ApiError.timeout;
    } on SocketException catch (_) {
      provider.apiError = ApiError.connection;
    } on Error catch (_) {
      provider.apiError = ApiError.unknown;
    }

    if (response != null && response.statusCode == 200) {
      final image = response.bodyBytes;
      provider.apiError = null;

      return image;
    } else {
      log('Failed to fetch image!');
      return null;
    }
  }
}
