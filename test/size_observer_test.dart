// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:size_observer/size_observer.dart';

void main() {
  testWidgets('', (WidgetTester tester) async {
    List<Size> sizes = [];

    final SizeObserver observer = SizeObserver (
      onSized: (Size size) {
        sizes.add(size);
      },
      child: Container(
        constraints: BoxConstraints.expand(),
        color: Colors.orange,
      ),
    );

    await tester.pumpWidget(
      Container(
        color: Colors.blue,
        child: Center(
          child: SizedBox(
            width: 100,
            height: 50,
            child: observer,
          ),
        ),
      ),
    );

    expect(sizes, <Size> [Size(100, 50)]);

    await tester.pumpWidget(
      Container(
        color: Colors.blue,
        child: Center(
          child: SizedBox(
            width: 100,
            height: 50,
            child: observer,
          ),
        ),
      ),
    );

    expect(sizes, <Size> [Size(100, 50)]);

    await tester.pumpWidget(
      Container(
        color: Colors.blue,
        child: Center(
          child: SizedBox(
            width: 200,
            height: 200,
            child: observer,
          ),
        ),
      ),
    );

    expect(sizes, <Size> [Size(100, 50), Size(200, 200)]);
  });
}
