import 'dart:typed_data';

import 'package:cat_facts/core/enums/api_error.dart';
import 'package:cat_facts/features/home/data/models/fact_model.dart';
import 'package:cat_facts/features/home/domain/entities/fact_entity.dart';
import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  FactEntity? _fact;
  ApiError? _apiError;
  Uint8List? _image;
  bool _isImageLoading = false;
  bool _isFactLoading = false;
  bool _isInitialized = false;

  FactEntity? get factEntity => _fact;
  Uint8List? get image => _image;
  ApiError? get apiError => _apiError;
  bool get isImageLoading => _isImageLoading;
  bool get isFactLoading => _isFactLoading;
  bool get isInitialized => _isInitialized;

  set factResult(FactModel? fact) {
    if (fact != null) _apiError = null;
    _fact = fact?.toEntity();
    _checkDataInitialized();
    notifyListeners();
  }

  set imageResult(Uint8List? img) {
    if (img != null) _apiError = null;
    _image = img;
    _checkDataInitialized();
    notifyListeners();
  }

  set apiError(ApiError? error) {
    _apiError = error;
    notifyListeners();
  }

  set isImageLoading(bool isLoading) {
    _isImageLoading = isLoading;
    notifyListeners();
  }

  set isFactLoading(bool isLoading) {
    _isFactLoading = isLoading;
    notifyListeners();
  }

  _checkDataInitialized() {
    bool isInitialized = factEntity != null && image != null;
    bool isLoading = isImageLoading || isFactLoading;

    _isInitialized = isInitialized && !isLoading;
  }
}
