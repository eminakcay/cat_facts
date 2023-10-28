import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:developer';

import 'package:cat_facts/core/constants/constants.dart';
import 'package:cat_facts/core/enums/api_error.dart';
import 'package:cat_facts/features/home/data/models/fact_model.dart';
import 'package:cat_facts/features/home/presentation/provider/home_provider.dart';
import 'package:cat_facts/utils/app_context.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class FactApiService {
  final AppContext _appContext;
  const FactApiService(this._appContext);

  Future<FactModel?> fetchFact() async {
    final provider = Provider.of<HomeProvider>(
      _appContext.navigatorContext,
      listen: false,
    );

    final uri = Uri.parse('$FACT_BASE_URL$FACT_PATH');
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
      final mapBody =
          jsonDecode(const Utf8Decoder().convert(response.bodyBytes))
              as Map<String, dynamic>;

      FactModel fact = FactModel.fromMap(mapBody);
      provider.apiError = null;

      return fact;
    } else {
      log('Failed to fetch fact!');
      return null;
    }
  }
}
