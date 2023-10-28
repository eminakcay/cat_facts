import 'package:cat_facts/core/constants/constants.dart';

enum ApiError {
  connection(CONNECTION_ERROR),
  timeout(TIMEOUT_ERROR),
  unknown(UNKNOWN_ERROR);

  final String name;
  const ApiError(this.name);
}
