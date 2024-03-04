// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:wish/src/constants.dart';

class TrackProductScreen extends ConsumerStatefulWidget {
  static const routeName = "/track-screen";
  List prices;
  String name;
  int desiredPrice;
  TrackProductScreen({
    required this.prices,
    required this.name,
    required this.desiredPrice,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TrackProductScreenState();
}

class _TrackProductScreenState extends ConsumerState<TrackProductScreen> {
  bool _isFocused = false;
  TextEditingController desired_price = TextEditingController();
  List<FlSpot> chartData = [];
  double maxY = 0, minY = 1e9;
  void _generateCharData() {
    List priceData = widget.prices;
    chartData = priceData.map((data) {
      // Extract price and date from each item
      data = jsonDecode(data);
      int price = data['price'];
      maxY = max(maxY, price.toDouble());
      minY = min(minY, price.toDouble());
      String dateString = data['date'];
      print("price $price, date : $dateString");
      // Parse the date string into a DateTime object
      DateTime date = DateTime.parse(dateString);
      // Return a FlSpot with X-coordinate as the timestamp (in seconds) and Y-coordinate as the price
      return FlSpot(
          date.millisecondsSinceEpoch.toDouble() / 1000, price.toDouble());
    }).toList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _generateCharData();
    print("$minY $maxY");
  }

  @override
  Widget build(BuildContext context) {
    List<Color> gradientColors = [Colors.green, Colors.greenAccent];
    int currentPrice = jsonDecode(widget.prices.last)['price'];
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.appBackgroundColor,
        centerTitle: true,
        leading: SizedBox(
          height: 30,
          width: 30,
          child: IconButton(
            icon: SvgPicture.asset(
              'assets/icons/send-square.svg',
              width: 30.0,
              height: 30.0,
              color: Colors.white,
            ),
            onPressed: () {
              // Implement your custom back button functionality here
              Navigator.of(context).pop();
            },
          ),
        ),
        title: const Text(
          "Details",
          style: TextStyle(color: AppColors.appActiveColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(
              thickness: 0.7,
              color: AppColors.dividerColor,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.name}",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Container(
                      height: 58,
                      width: 144,
                      child: Text(
                        "₹${currentPrice}",
                        style: const TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                          color: AppColors.greenDark,
                        ),
                      )),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      padding:
                          const EdgeInsets.only(left: 8, top: 10, bottom: 10),
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      width: size.width,
                      height: size.height / 2.3,
                      child: LineChart(
                        LineChartData(
                            borderData: FlBorderData(show: false),
                            minY: minY,
                            maxY: maxY * 1.5,
                            baselineY: 1000,
                            lineTouchData: LineTouchData(
                              touchTooltipData: LineTouchTooltipData(
                                tooltipBgColor: Colors
                                    .transparent, // Set background color of tooltip
                                fitInsideHorizontally: true,
                                fitInsideVertically: true,
                                getTooltipItems: (touchedSpots) {
                                  return touchedSpots
                                      .map((LineBarSpot touchedSpot) {
                                    // Determine the price change
                                    double priceChange =
                                        touchedSpot.y - widget.desiredPrice;
                                    // Determine the color based on price change
                                    Color tooltipColor = priceChange >= 0
                                        ? Colors.green
                                        : Colors.red;
                                    // Determine the icon based on price change
                                    IconData iconData = priceChange >= 0
                                        ? Icons.arrow_upward
                                        : Icons.arrow_downward;
                                    // Build the tooltip item
                                    return LineTooltipItem(
                                      '${DateTime.fromMillisecondsSinceEpoch((touchedSpot.x * 1000).toInt()).toString()}',
                                      TextStyle(color: tooltipColor),
                                      children: [
                                        TextSpan(
                                          text:
                                              ' Price: ${touchedSpot.y.toStringAsFixed(2)}',
                                          style: TextStyle(color: tooltipColor),
                                        ),
                                      ],
                                    );
                                  }).toList();
                                },
                              ),
                            ),
                            gridData: const FlGridData(drawVerticalLine: false),
                            showingTooltipIndicators: [],
                            titlesData: const FlTitlesData(
                              bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false)),
                              rightTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false)),
                              topTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false)),
                            ),
                            lineBarsData: [
                              LineChartBarData(
                                spots: chartData,
                                dotData: FlDotData(
                                  show: false,
                                  getDotPainter:
                                      (spot, percent, barData, index) =>
                                          FlDotCirclePainter(
                                    radius: 8,
                                    color: Colors.white,
                                    strokeWidth: 2,
                                    strokeColor: AppColors.greenDark,
                                  ),
                                ),
                                belowBarData: BarAreaData(
                                  spotsLine: const BarAreaSpotsLine(
                                    show:
                                        true, // Whether to show the spots line
                                    flLineStyle: FlLine(
                                      color: AppColors
                                          .greenDark, // Color of the line
                                      strokeWidth: 0.2, // Width of the line
                                    ),
                                  ),
                                  show: true,
                                  gradient: LinearGradient(
                                    colors: gradientColors
                                        .map((color) => color.withOpacity(0.19))
                                        .toList(),
                                  ),
                                ),
                                color: AppColors.greenDark,
                              ),
                            ]),
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.easeIn,
                      ),
                    ),
                  ),
                  const Text(
                    "You will receive notifications, when the price hits.",
                    style: TextStyle(color: AppColors.appActiveColor),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (text) {
                      setState(() {});
                    },
                    onTap: () {
                      setState(() {
                        _isFocused = true;
                      });
                    },
                    onEditingComplete: () {
                      setState(() {
                        _isFocused = false;
                      });
                      print("onediting complete");
                      widget.desiredPrice = int.parse(desired_price.text);
                      desired_price.clear();
                      FocusScope.of(context).unfocus();
                    },
                    onSubmitted: (text) {
                      setState(() {
                        _isFocused = false;
                      });
                      print("on submitted");
                    },
                    controller: desired_price,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.edit_notifications,
                        color: _isFocused
                            ? AppColors.appActiveColor
                            : AppColors.greenDark,
                      ),
                      hintText: "₹${widget.desiredPrice}",
                      hintStyle: TextStyle(color: AppColors.greenDark),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.greenDark, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColors.appActiveColor, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      filled: true,
                      fillColor: AppColors.appBackgroundColor,
                      // Set text color of entered text
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Text(
                        "${widget.name} price is currently being tracked per hour.\nCheck the best price and get notifications about the price drops."),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MaterialButton(
                        onPressed: () {},
                        child: Container(
                          height: 50,
                          width: 150,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.dividerColor),
                            gradient: const RadialGradient(
                              center: Alignment(-0, 2),

                              radius: 2.3,
                              // begin: Alignment(1, -0.00),
                              // end: Alignment(0, -1),
                              colors: [
                                Color(0xFF6D7178),
                                Color(0xFF000000),
                              ],
                              tileMode: TileMode.mirror,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: const Center(
                            child: Text(
                              "Get Now",
                              style: TextStyle(
                                  color: AppColors.appActiveColor,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {},
                        child: Container(
                          height: 55,
                          width: 150,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.redColor),
                            gradient: const RadialGradient(
                              center: Alignment(-0, 2),

                              radius: 2.3,
                              // begin: Alignment(1, -0.00),
                              // end: Alignment(0, -1),
                              colors: [
                                Color.fromARGB(255, 96, 52, 52),
                                Color(0xFF000000),
                              ],
                              tileMode: TileMode.mirror,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: const Center(
                            child: Text(
                              "Disable",
                              style: TextStyle(
                                  color: AppColors.appActiveColor,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
