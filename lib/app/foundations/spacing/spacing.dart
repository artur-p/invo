import 'package:flutter/material.dart';

abstract class InvoSpaces {
  static const space3 = 3.0;
  static const space4 = 4.0;
  static const space8 = 8.0;
  static const space10 = 10.0;
  static const space12 = 12.0;
  static const space13 = 13.0;
  static const space16 = 16.0;
  static const space20 = 20.0;
  static const space24 = 24.0;
  static const space32 = 32.0;
  static const space40 = 40.0;
  static const space48 = 48.0;
  static const space56 = 56.0;
  static const space64 = 64.0;
  static const space72 = 72.0;
  static const space80 = 80.0;
  static const space88 = 88.0;
}

class InvoSpace extends SizedBox {
  const InvoSpace._height(double value) : super(height: value);

  const InvoSpace._width(double value) : super(width: value);

  factory InvoSpace.v4() => const InvoSpace._height(InvoSpaces.space4);
  factory InvoSpace.v8() => const InvoSpace._height(InvoSpaces.space8);
  factory InvoSpace.v12() => const InvoSpace._height(InvoSpaces.space12);
  factory InvoSpace.v16() => const InvoSpace._height(InvoSpaces.space16);
  factory InvoSpace.v20() => const InvoSpace._height(InvoSpaces.space20);
  factory InvoSpace.v24() => const InvoSpace._height(InvoSpaces.space24);
  factory InvoSpace.v32() => const InvoSpace._height(InvoSpaces.space32);
  factory InvoSpace.v40() => const InvoSpace._height(InvoSpaces.space40);
  factory InvoSpace.v48() => const InvoSpace._height(InvoSpaces.space48);
  factory InvoSpace.v56() => const InvoSpace._height(InvoSpaces.space56);
  factory InvoSpace.v64() => const InvoSpace._height(InvoSpaces.space64);
  factory InvoSpace.v72() => const InvoSpace._height(InvoSpaces.space72);
  factory InvoSpace.v80() => const InvoSpace._height(InvoSpaces.space80);
  factory InvoSpace.v88() => const InvoSpace._height(InvoSpaces.space88);

  factory InvoSpace.h4() => const InvoSpace._width(InvoSpaces.space4);
  factory InvoSpace.h8() => const InvoSpace._width(InvoSpaces.space8);
  factory InvoSpace.h12() => const InvoSpace._width(InvoSpaces.space12);
  factory InvoSpace.h16() => const InvoSpace._width(InvoSpaces.space16);
  factory InvoSpace.h20() => const InvoSpace._width(InvoSpaces.space20);
  factory InvoSpace.h24() => const InvoSpace._width(InvoSpaces.space24);
  factory InvoSpace.h32() => const InvoSpace._width(InvoSpaces.space32);
  factory InvoSpace.h40() => const InvoSpace._width(InvoSpaces.space40);
  factory InvoSpace.h48() => const InvoSpace._width(InvoSpaces.space48);
  factory InvoSpace.h56() => const InvoSpace._width(InvoSpaces.space56);
  factory InvoSpace.h64() => const InvoSpace._width(InvoSpaces.space64);
  factory InvoSpace.h72() => const InvoSpace._width(InvoSpaces.space72);
  factory InvoSpace.h80() => const InvoSpace._width(InvoSpaces.space80);
  factory InvoSpace.h88() => const InvoSpace._width(InvoSpaces.space88);

  factory InvoSpace.vSafeAreaTop(BuildContext context) =>
      InvoSpace._height(MediaQuery.of(context).padding.top);

  factory InvoSpace.vSafeAreaBottom(BuildContext context) =>
      InvoSpace._height(MediaQuery.of(context).padding.bottom);
}
