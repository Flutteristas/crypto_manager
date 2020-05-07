import 'package:flutter/material.dart';

class ColorConverter{
  Color _colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }

  Color backgroundColor() => _colorFromHex('2f3c51');
  Color fieldTextColor() => _colorFromHex('AFB6C0');
  Color firstButtonGradient() => _colorFromHex('3ABDB4');
  Color secondButtonGradient() => _colorFromHex('3EC5CC');
}