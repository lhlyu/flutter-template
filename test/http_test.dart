import 'dart:convert';

import 'package:flutter_template/models/result.dart';
import 'package:flutter_template/utils/http.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('测试http', () async {
      final response = await httpService.get('/images/1/1');
      final r = Result.fromJson(response.data);
      expect(r.page, 1);
  });
}