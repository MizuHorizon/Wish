import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wish/src/constants.dart';
import 'package:wish/src/wish/models/product_model.dart';
import 'package:wish/src/wish/presentation/Screens/Signin_screen.dart';
import 'package:wish/src/wish/presentation/Screens/developers_screen.dart';
import 'package:wish/src/wish/presentation/controllers/productController.dart';
import 'package:wish/src/wish/presentation/controllers/userController.dart';
import 'package:wish/src/wish/presentation/utils/dotted_line.dart';

Drawer HomePageDrawer(
    BuildContext context, int _selectedIndex, Function(int) _onItemTapped) {
  //UserController userController = UserController();

  Future<void> signOut(WidgetRef ref) async {
    await ref.read(userControllerProvider.notifier).logout().then((value) {
      print("user state updated");
      ref.read(productModelProvider.notifier).update((state) => []);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SignInScreen()));
    });
  }

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
            Navigator.pushNamed(context, DevelopersScreen.routename);
          },
        ),
        const Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: MySeparator(color: AppColors.dividerColor),
        ),
        Consumer(builder: (context, ref, child) {
          final userController = ref.watch(userControllerProvider);
          return ListTile(
            title: Row(
              children: [
                const Icon(
                  Icons.logout,
                  color: AppColors.appActiveColor,
                ),
                const SizedBox(width: 10),
                Container(
                  child: userController.isLoading
                      ? const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColors.appActiveColor,
                            ),
                          ),
                        )
                      : const Text(
                          'Logout',
                          style: TextStyle(color: AppColors.appActiveColor),
                        ),
                )
              ],
            ),
            selected: _selectedIndex == 2,
            onTap: () async {
              _onItemTapped(2);
              signOut(ref);
            },
          );
        }),
      ],
    ),
  );
}
