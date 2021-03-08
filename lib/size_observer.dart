// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library size_observer;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

typedef void SizeCallback(Size size);

class SizeObserver extends SingleChildRenderObjectWidget {
  const SizeObserver({
    Key? key,
    Widget? child,
    required this.onSized,
  }) : super(key: key, child: child);

  final SizeCallback onSized;

  @override
  _RenderSizeObserver createRenderObject(BuildContext context) {
    return _RenderSizeObserver(
      onLayoutChangedCallback: onSized,
    );
  }
}

class _RenderSizeObserver extends RenderProxyBox {
  _RenderSizeObserver({
    RenderBox? child,
    required this.onLayoutChangedCallback,
  }) : super(child);

  final SizeCallback onLayoutChangedCallback;

  Size? _oldSize;

  @override
  void performLayout() {
    super.performLayout();
    if (size != _oldSize) onLayoutChangedCallback(size);
    _oldSize = size;
  }
}
