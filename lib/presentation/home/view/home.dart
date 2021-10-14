import 'package:clypto/di/di.dart';
import 'package:clypto/handlers/navigation_service.dart';
import 'package:clypto/presentation/details/view/details.dart';
import 'package:clypto/presentation/home/cubit/counter_cubit.dart';
import 'package:clypto/presentation/home/view/charts/drawing.dart';
import 'package:clypto/presentation/res/assets/svg_assets.dart';
import 'package:clypto/presentation/widgets/bottom_nav_button.dart';
import 'package:clypto/presentation/widgets/box_decoration.dart';
import 'package:clypto/utils/margin.dart';
import 'package:clypto/utils/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeView();
  }
}

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);
  
  final _navService = getIt<NavigationHandler>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.lerp(Color(0xFF3B405E), Color(0xFF444A6D), 0.5),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 12, right: 12, top: 10),
                child: TopBar(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.normal,
                          color: NeumorphicTheme.isUsingDark(context) ? Color(0xFFD2D6EF) : Color(0xFFD2D6EF),
                        ),
                      ),
                      Gap(5),
                      Text(
                        'Jenny Doe',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: NeumorphicTheme.isUsingDark(context) ? Color(0xFFD2D6EF) : Color(0xFFD2D6EF),
                        ),
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    Align(
                      alignment: Alignment.centerRight,
                      child: NeumorphicButton(
                        padding: const EdgeInsets.all(10.0),
                        onPressed: () => _navService.pushNamed(Routes.DETAILS),
                        style: NeumorphicStyle(
                          depth: 4,
                          intensity: 6,
                          // surfaceIntensity: 0.55,
                          shape: NeumorphicShape.flat,
                          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
                          shadowDarkColor: Color(0xFF272C43),
                          shadowLightColor: Color(0xFF3B405E),
                          color: Color(0xFF3B405E),
                          border: NeumorphicBorder(
                            isEnabled: true,
                            width: 1,
                            color: Color.lerp(Color(0xFF272C43), Color(0xFF5F6791), 0.4),
                          ),
                          lightSource: LightSource.lerp(LightSource.topLeft, LightSource.left, 0.5)!,
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            SvgAssets.ALERT,
                            color: Color.lerp(Color(0xFFD2D6EF), Color(0xFF9299C2), 0.9),
                            height: 15,
                            width: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Gap(10),
              NueHomeChart(),
              Gap(20),
              Container(
                margin: EdgeInsets.only(left: 12, right: 12, top: 10),
                child: Row(
                  children: [Text("Balance"), Spacer(), Text("\$8,540")],
                ),
              ),
              Gap(20),
              NueProgressBar(),
              Gap(20),
              NeumorphicSelector(),
              Gap(30),
              Row(
                children: [
                  Expanded(
                    child: CrptoIncomeExpense(
                      icon: SvgAssets.INCOME,
                      amount: '\$8,540',
                      type: 'Income',
                      color: Color.lerp(Color(0xFF2F9BFF), Color(0xFF68CBFA), 0.9),
                    ),
                  ),
                  Gap(10),
                  Expanded(
                    child: CrptoIncomeExpense(
                      icon: SvgAssets.EXPENSE,
                      amount: '\$8,540',
                      type: 'Expense',
                      color: Color.lerp(Color(0xFFF47169), Color(0xFFFF8080), 0.9),
                    ),
                  ),
                ],
              ),
              Gap(20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ClyptoBottomNav(),
    );
  }
}

class CounterText extends StatelessWidget {
  const CounterText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final count = context.select((CounterCubit cubit) => cubit.state);
    return Text('$count', style: theme.textTheme.headline1);
  }
}

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final List<Widget> actions;

  static const double kToolbarHeight = 110.0;

  const TopBar({required this.title, required this.actions});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18.0),
      child: Row(
        children: [
          title,
          Spacer(),
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: actions,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class CrptoIncomeExpense extends StatelessWidget {
  final String icon;
  final String amount;
  final String type;
  final Color? color;

  CrptoIncomeExpense({required this.icon, required this.amount, required this.type, required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      height: 75,
      decoration: getBoxDecoration(),
      child: Container(
        child: Row(
          children: [
            Gap(5),
            Container(
              margin: const EdgeInsets.all(15.0),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.1),
                    offset: Offset(-2.0, 2.0),
                    blurRadius: 5.0,
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    offset: Offset(-2.0, -2.0),
                    blurRadius: 5.0,
                  ),
                ],
                color: Color(0xFF3B405E),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Center(
                  child: SvgPicture.asset(
                    icon,
                    color: color,
                  ),
                ),
              ),
            ),
            Gap(10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(type),
                Gap(5),
                Text(amount),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class NeumorphicSelector extends StatelessWidget {
  final double _elementHeight = 14;
  final double _spacing = 10;

  Widget _buildSimpleButton(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
        depth: 4,
        shape: NeumorphicShape.concave,
        boxShape: NeumorphicBoxShape.circle(),
        lightSource: LightSource.lerp(LightSource.topRight, LightSource.bottomRight, 1)!,
        shadowDarkColor: Color(0xFF272C43),
        shadowDarkColorEmboss: Color(0xFF3B405E),
        shadowLightColor: Color(0xFF3B405E),
        shadowLightColorEmboss: Color(0xFF4A5178),
        color: Color(0xFF424869),
        border: NeumorphicBorder(
          isEnabled: true,
          width: 1,
          color: Color(0xFF4A5178),
        ),
      ),
      child: SizedBox(
        height: _elementHeight,
        width: _elementHeight,
      ),
    );
  }

  Widget _buildSelectedButton(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
        depth: -20,
        shape: NeumorphicShape.convex,
        boxShape: NeumorphicBoxShape.circle(),
        lightSource: LightSource.lerp(LightSource.topLeft, LightSource.bottomLeft, 1)!,
        shadowDarkColor: Color(0xFF272C43),
        shadowDarkColorEmboss: Color(0xFF3B405E),
        shadowLightColor: Color(0xFF3B405E),
        shadowLightColorEmboss: Color(0xFF4A5178),
        color: Color(0xFF424869),
        border: NeumorphicBorder(
          isEnabled: true,
          width: 2,
          color: Color(0xFF4A5178),
        ),
      ),
      child: SizedBox(
        height: _elementHeight,
        width: _elementHeight,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildSelectedButton(context),
        SizedBox(
          width: _spacing,
        ),
        _buildSimpleButton(context),
        SizedBox(
          width: _spacing,
        ),
        _buildSimpleButton(context),
      ],
    );
  }
}

class NueProgressBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 12,
        right: 12,
      ),
      // padding: EdgeInsets.only(top:10,bottom: 10),
      height: 15,
      width: double.maxFinite,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.1),
            offset: Offset(2.0, 2.0),
            blurRadius: 1.0,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            offset: Offset(-2.0, -2.0),
            blurRadius: 3.0,
          ),
        ],
        color: Color(0xFF3B405E),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 7,
              margin: EdgeInsets.all(3),
              // padding: EdgeInsets.only(left: 300),
              // width: 10,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.1),
                    offset: Offset(-2.0, -2.0),
                    blurRadius: 2.0,
                  ),
                  BoxShadow(
                    color: Colors.transparent,
                    offset: Offset(2.0, 2.0),
                    blurRadius: 1.0,
                  ),
                ],
                color: Color(0xFFF47169),
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}

class NueHomeChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 12, right: 12, top: 10),
      height: context.screenHeight(0.45),
      decoration: getBoxDecoration(),
      child: Column(
        children: [
          Gap(20),
          Row(
            children: [
              Gap(20),
              ETHNueIcon(),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ItemExchangeProgressBar(width: 60),
                  Gap(25),
                  SvgPicture.asset(
                    SvgAssets.EXPENSE,
                    color: Color.lerp(Color(0xFF2F9BFF), Color(0xFF68CBFA), 0.9),
                    height: 10,
                    width: 10,
                  ),
                ],
              ),
              Gap(20),
            ],
          ),
          Spacer(),
          Chart(
            isDetailScreen: false,
          )
        ],
      ),
    );
  }
}

class ClyptoBottomNav extends StatelessWidget {
  final firstBottomNav = true;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 25, right: 10, left: 10),
        child: Row(
          children: [
            Gap(10),
            Expanded(
              child: BottomNavButton(
                firstBottomNav: firstBottomNav,
                onPressed: () {},
                icon: SvgAssets.HOME,
                tab: true,
              ),
            ),
            Gap(45),
            Expanded(
              child: BottomNavButton(
                firstBottomNav: false,
                onPressed: () {},
                icon: SvgAssets.TRANSACTIONS,
                tab: true,
              ),
            ),
            Gap(45),
            Expanded(
              child: BottomNavButton(
                firstBottomNav: false,
                onPressed: () {},
                icon: SvgAssets.WALLLET,
                tab: true,
              ),
            ),
            Gap(45),
            Expanded(
              child: BottomNavButton(
                firstBottomNav: false,
                onPressed: () {},
                icon: SvgAssets.SETTINGS,
                tab: true,
              ),
            ),
            Gap(10),
          ],
        ),
      ),
    );
  }
}
