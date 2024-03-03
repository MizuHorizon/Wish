// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

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
  @override
  Widget build(BuildContext context) {
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
      body: Column(
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
                  style: TextStyle(
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
                      style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                        color: AppColors.greenDark,
                      ),
                    )),
                Container(
                  width: size.width,
                  height: size.height / 2.3,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
