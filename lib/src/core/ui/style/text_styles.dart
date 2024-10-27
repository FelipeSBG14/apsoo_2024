import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyles {
  static TextStyles? _i;
  // Avoid self isntance
  TextStyles._();
  static TextStyles get i {
    _i ??= TextStyles._();
    return _i!;
  }

  String get fontFamily => 'retrogaming';

  TextStyle get textRegular => GoogleFonts.roboto(
        fontSize: 16,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
      );

  TextStyle get textButtonLabel => textRegular.copyWith(fontSize: 14);
  TextStyle get textTitle => textRegular.copyWith(fontSize: 22);
}

extension TextStylesExtensions on BuildContext {
  TextStyles get textStyles => TextStyles.i;
}
