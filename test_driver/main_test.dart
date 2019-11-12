// Copyright 2019, the Chromium project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

Future<void> main() async {
  final FlutterDriver driver = await FlutterDriver.connect();

  tearDownAll(() async {
    driver.close();
  });

  test('Driver.screenshot', () async{
    List<int> screenshot = await driver.screenshot();
    expect(screenshot, isNotEmpty);
  });
}
