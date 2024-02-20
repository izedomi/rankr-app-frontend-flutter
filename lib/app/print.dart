import 'package:flutter/foundation.dart';

void printty(dynamic val) {
  if (kDebugMode) {
    print(val.toString());
  }
}
