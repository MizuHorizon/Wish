import 'package:flutter/material.dart';
import 'package:wish/src/constants.dart';
import 'package:wish/src/wish/presentation/Screens/Signin_screen.dart';
import 'package:wish/src/wish/presentation/controllers/userController.dart';
import 'package:wish/src/wish/presentation/utils/dotted_line.dart';

Drawer HomePageDrawer(
    BuildContext context, int _selectedIndex, Function(int) _onItemTapped) {
  UserController userController = UserController();
  return Drawer(
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
              ),
            ),
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
            _onItemTapped(0);
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
            _onItemTapped(1);
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
            _onItemTapped(2);
            userController.logout(context);
            Navigator.pushNamed(context, SignInScreen.routeName);
          },
        ),
      ],
    ),
  );
}
