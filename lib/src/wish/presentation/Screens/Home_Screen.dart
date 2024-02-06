import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wish/src/constants.dart';
import 'package:wish/src/wish/presentation/controllers/userController.dart';
import 'package:wish/src/wish/presentation/utils/homepage_drawer.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const routeName = "/home-screen";
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedIndex = 0;
  UserController userController = UserController();
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      drawer: HomePageDrawer(context, _selectedIndex, _onItemTapped),
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text("Home"),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      body: const Column(
        children: [
          Divider(
            thickness: 0.7,
            color: AppColors.dividerColor,
          )
        ],
      ),
    );
  }
}
