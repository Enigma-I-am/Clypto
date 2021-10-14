import 'package:clypto/presentation/details/cubit/detail_cubit.dart';
import 'package:clypto/presentation/home/view/charts/drawing.dart';
import 'package:clypto/presentation/home/view/home.dart';
import 'package:clypto/presentation/res/assets/svg_assets.dart';
import 'package:clypto/presentation/widgets/bottom_nav_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class DetailsPage extends StatelessWidget {
  DetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.lerp(Color(0xFF3B405E), Color(0xFF444A6D), 0.5),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 30),
                child: TopBar(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Overview',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          color: NeumorphicTheme.isUsingDark(context) ? Color(0xFFD2D6EF) : Color(0xFFD2D6EF),
                        ),
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    // Align(
                    //   alignment: Alignment.centerRight,
                    //   child: SectionNeuSwitch(),
                    // ),
                  ],
                ),
              ),
              Gap(10),
              // Overview item
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ETHNueIcon(),
                      Gap(30),
                      Text(
                        'Ethereum Balance',
                        style: TextStyle(
                          color: Color(0xFF717796),
                        ),
                      ),
                      Gap(5),
                      BlocBuilder<DetailCubit, DetailState>(
                        builder: (context, state) {
                          switch (state.status) {
                            case ClptoDetailStatus.initial:
                            case ClptoDetailStatus.loadingExchangeBalance:
                            case ClptoDetailStatus.exchangeBalanceFailure:
                              return Center(
                                  child: Text(
                                '\$0.00',
                                style: TextStyle(color: Color(0xFFD2D6EF), fontSize: 35),
                              ));
                            case ClptoDetailStatus.exchangeBalanceSuccess:
                              return Text(
                                '${state.exchangeBalance!.clyptoData.clyptoBalnce}',
                                style: TextStyle(color: Color(0xFFD2D6EF), fontSize: 35),
                              );
                            default:
                              return Center(
                                child: Text(
                                  '\$0.00',
                                  style: TextStyle(color: Color(0xFFD2D6EF), fontSize: 35),
                                ),
                              );
                          }
                        },
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 10,
                            width: 10,
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Color.lerp(Color(0xFFFFAA5C), Color(0xFFF29239), 1),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFF3B405E),
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                          ),
                          Gap(3),
                          Text(
                            'Daily',
                            style: TextStyle(
                              color: Color(0xFF717796),
                            ),
                          ),
                        ],
                      ),
                      Text('24.320\$'),
                      Gap(50),
                      Row(
                        children: [
                          Container(
                            height: 10,
                            width: 10,
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Color.lerp(Color(0xFF612FF5), Color(0xFF855CFF), 1),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFF3B405E),
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                          ),
                          Gap(3),
                          Text(
                            'Monthly',
                            style: TextStyle(
                              color: Color(0xFF717796),
                            ),
                          ),
                        ],
                      ),
                      Text('24.320\$'),
                    ],
                  ),
                ],
              ),
              Gap(30),
              // Graph
              Chart(
                isDetailScreen: true,
              ),
              Gap(30),
              // Tab bars

              // AppBar
              ClyptoAppBar(),
              Gap(20),
              // Exchange list
              ClyptoExchangeList(),
            ],
          ),
        ),
      ),
    );
  }
}

class ClyptoExchangeList extends StatelessWidget {
  const ClyptoExchangeList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      width: double.maxFinite,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.1),
            offset: Offset(-2.0, -2.0),
            blurRadius: 5.0,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            offset: Offset(2.0, 2.0),
            blurRadius: 5.0,
          ),
        ],
        color: Color(0xFF3B405E),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: BlocBuilder<DetailCubit, DetailState>(
        builder: (context, state) {
          switch (state.status) {
            case ClptoDetailStatus.initial:
            case ClptoDetailStatus.loading:
              return Center(child: CircularProgressIndicator());
            case ClptoDetailStatus.failure:
              return Center(child: Text(state.resMessage ?? 'Failed'));
            case ClptoDetailStatus.success:
              return Column(
                children: [
                  ...state.exchanges.map(
                    (e) {
                      var index = state.exchanges.indexOf(e);
                      return ExchangeItem(
                        name: '${e.clyptoName}',
                        amount: '${e.clyptoAmount}',
                        icon: index % 2 == 0 ? SvgAssets.ETH : SvgAssets.XPR,
                        color: index % 2 == 0
                            ? Color.alphaBlend(
                                Color(0xFFD2D6EF),
                                Color(0xFF9299C2),
                              )
                            : Color(0xFF555FEB),
                      );
                    },
                  ),
                ],
              );
            default:
              return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class ClyptoAppBar extends StatelessWidget {
  const ClyptoAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Gap(20),
        Expanded(
          child: BottomNavButton(
            firstBottomNav: false,
            onPressed: () {},
            label: 'Daily',
            tab: true,
          ),
        ),
        Gap(20),
        Expanded(
          child: BottomNavButton(
            firstBottomNav: true,
            onPressed: () {},
            label: 'Weekly',
            tab: true,
          ),
        ),
        Gap(20),
        Expanded(
          child: BottomNavButton(
            firstBottomNav: false,
            onPressed: () {},
            label: 'Monthly',
            tab: true,
          ),
        ),
        Gap(20),
      ],
    );
  }
}

class ExchangeItem extends StatelessWidget {
  const ExchangeItem({Key? key, required this.amount, required this.name, required this.icon, this.color})
      : super(key: key);
  final String name;
  final String amount;
  final String icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gap(10),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: ETHNueIcon(
                icon: icon,
                color: color,
              ),
            ),
            Gap(10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name),
                Gap(5),
                Text('\$$amount'),
              ],
            ),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ItemExchangeProgressBar(),
                Gap(8),
                Text('15%'),
                Gap(8),
                SvgPicture.asset(
                  SvgAssets.INCOME,
                  color: Color.lerp(Color(0xFF2F9BFF), Color(0xFF68CBFA), 0.9),
                  height: 10,
                  width: 10,
                ),
              ],
            ),
            Gap(10),
          ],
        ),
        Gap(25),
        Divider(),
        Gap(10),
      ],
    );
  }
}

class Divider extends StatelessWidget {
  const Divider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.5,
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      width: double.maxFinite,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.1),
            offset: Offset(1.0, 1.0),
            blurRadius: 1.0,
          ),
          BoxShadow(
            color: Colors.black,
            offset: Offset(-1.0, -1.0),
            blurRadius: 1.0,
          ),
        ],
        color: Color(0xFF3B405E),
        borderRadius: BorderRadius.circular(15.0),
      ),
    );
  }
}

class ETHNueIcon extends StatelessWidget {
  final String? icon;
  final Color? color;
  ETHNueIcon({this.icon = SvgAssets.ETH, this.color = const Color(0xFF555FEB)});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      // margin: const EdgeInsets.symmetric(horizontal: 15.0),
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
            blurRadius: 2.0,
          ),
        ],
        color: Color(0xFF3B405E),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(
        child: SvgPicture.asset(
          icon!,
          color: color,
          height: 20,
          width: 20,
        ),
      ),
    );
  }
}

class ItemExchangeProgressBar extends StatelessWidget {
  final double width;
  ItemExchangeProgressBar({this.width = 40});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4,
      width: width,
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
          Spacer(
            flex: 1,
          ),
          Expanded(
            flex: 3,
            child: Container(
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
                color: Color(0xFFB4BE23),
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
          ),
          Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }
}
