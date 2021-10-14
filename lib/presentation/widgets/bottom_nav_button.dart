import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavButton extends StatelessWidget {
  final String? icon;
  final String? label;
  final bool firstBottomNav;
  final Function onPressed;
  final bool tab;
  BottomNavButton({
    Key? key,
    this.icon,
    this.label,
    this.tab = false,
    required this.firstBottomNav,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: tab ? 50 : 75,
      child: NeumorphicButton(
        onPressed: () {},
        style: NeumorphicStyle(
          depth: firstBottomNav ? -2 : 2,
          intensity: firstBottomNav ? -2 : 2,
          shape: firstBottomNav ? NeumorphicShape.convex : NeumorphicShape.concave,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(tab ? 10 : 20)),
          shadowDarkColor: Color(0xFF272C43),
          shadowDarkColorEmboss: Color(0xFF3B405E),
          shadowLightColor: Color(0xFF3B405E),
          shadowLightColorEmboss: Color(0xFF4A5178),
          color: firstBottomNav ? Color(0xFF3B405E) : Color(0xFF424869),
          border: NeumorphicBorder(
            isEnabled: true,
            width: firstBottomNav ? 3 : 1,
            color: firstBottomNav ? Color(0xFF4A5178) : Color.lerp(Color(0xFF424869), Color(0xFF4A5178), 0.4),
          ),
          lightSource: firstBottomNav
              ? LightSource.lerp(LightSource.topLeft, LightSource.bottomLeft, 1)!
              : LightSource.lerp(LightSource.topRight, LightSource.bottomRight, 1)!,
        ),
        child: Center(
          child: icon == null
              ? Text(label!,style: TextStyle(fontSize: 10),)
              : SvgPicture.asset(
                  icon!,
                  color: Color.lerp(Color(0xFF2F9BFF), Color(0xFF68CBFA), 0.9),
                ),
        ),
      ),
    );
  }
}

class ButtonTapped extends StatelessWidget {
  final icon;

  ButtonTapped({
    Key? key,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4),
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.grey[300],
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.1),
                offset: Offset(6.0, 6.0),
                blurRadius: 16.0,
                spreadRadius: 1.0,
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: Offset(-6.0, -6.0),
                blurRadius: 16.0,
                spreadRadius: 1.0,
              ),
            ],
            gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
              Color(0xFF3B405E),
              Color(0xFF3B405E),
              Color(0xFF3B405E),
              Color(0xFF3B405E),
            ], stops: [
              0.1,
              0.3,
              0.8,
              1
            ])),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.grey[300],
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.1),
                  offset: Offset(6.0, 6.0),
                  blurRadius: 16.0,
                  spreadRadius: 1.0,
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: Offset(-6.0, -6.0),
                  blurRadius: 16.0,
                  spreadRadius: 1.0,
                ),
              ],
              gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
                Color(0xFF3B405E),
                Color(0xFF3B405E),
                Color(0xFF3B405E),
                Color(0xFF3B405E),
              ], stops: [
                0,
                0.1,
                0.3,
                1
              ])),
          child: Icon(
            icon,
            size: 35,
            color: Colors.grey[700],
          ),
        ),
      ),
    );
  }
}

class ClyptoCon extends StatelessWidget {
  final icon;

  ClyptoCon({
    Key? key,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.grey[300],
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.1),
              offset: Offset(6.0, 6.0),
              blurRadius: 16.0,
              spreadRadius: 1.0,
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              offset: Offset(-6.0, -6.0),
              blurRadius: 16.0,
              spreadRadius: 1.0,
            ),
          ],
          gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
            Color(0xFF3B405E),
            Color(0xFF3B405E),
            Color(0xFF3B405E),
            Color(0xFF3B405E),
          ], stops: [
            0.1,
            0.3,
            0.8,
            1
          ]),
        ),
        child: icon,
      ),
    );
  }
}
