import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

BoxDecoration getBoxDecoration({double borderRadius = 10.0, bool darker = false, double blorRadius = 5.0}) =>
    BoxDecoration(
      color: Color(0xFF3B405E),
      borderRadius: BorderRadius.circular(borderRadius),
      boxShadow: [
        BoxShadow(
          color: Colors.white.withOpacity(0.1),
          offset: Offset(-2.0, -2.0),
          blurRadius: 5.0,
        ),
        BoxShadow(
          color: Colors.black.withOpacity(0.4),
          offset: Offset(2.0, 2.0),
          blurRadius: blorRadius,
        ),
      ],
    );
