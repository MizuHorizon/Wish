import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wish/src/constants.dart';
import 'package:wish/src/wish/presentation/Screens/Signin_screen.dart';
import 'package:wish/src/wish/presentation/controllers/userController.dart';
import 'package:wish/src/wish/presentation/utils/dotted_line.dart';

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
      drawer: Drawer(
        width: 250,
        backgroundColor: AppColors.appBackgroundColor,
        child: ListView(
          children: [
            const SizedBox(
              height: 27,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.appActiveColor,
                    ))
              ],
            ),
            const Divider(
              thickness: 0.7,
              color: AppColors.dividerColor,
            ),
            ListTile(
              title: const Row(
                children: [
                  Icon(
                    Icons.person_sharp,
                    color: AppColors.appActiveColor,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Profile',
                    style: TextStyle(color: AppColors.appActiveColor),
                  ),
                ],
              ),
              selected: _selectedIndex == 0,
              onTap: () {
                // Update the state of the app
                _onItemTapped(0);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: MySeparator(color: AppColors.dividerColor),
            ),
            ListTile(
              title: const Row(
                children: [
                  Icon(
                    Icons.question_mark_rounded,
                    color: AppColors.appActiveColor,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Developer Contact',
                    style: TextStyle(color: AppColors.appActiveColor),
                  ),
                ],
              ),
              selected: _selectedIndex == 1,
              onTap: () {
                // Update the state of the app
                _onItemTapped(1);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: MySeparator(color: AppColors.dividerColor),
            ),
            ListTile(
              title: const Row(
                children: [
                  Icon(
                    Icons.logout,
                    color: AppColors.appActiveColor,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Logout',
                    style: TextStyle(color: AppColors.appActiveColor),
                  ),
                ],
              ),
              selected: _selectedIndex == 2,
              onTap: () {
                // Update the state of the app
                _onItemTapped(2);
                userController.logout(context);
                // Then close the drawer
                Navigator.pushNamed(context, SignInScreen.routeName);
              },
            ),
          ],
        ),
      ),
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
