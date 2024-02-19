import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wish/src/constants.dart';
import 'package:wish/src/wish/data/product_repository.dart';
import 'package:wish/src/wish/models/product_model.dart';
import 'package:wish/src/wish/presentation/controllers/userController.dart';

final productControllerProvider =
    StateNotifierProvider.autoDispose<ProductController, AsyncValue<void>>(
        (ref) => ProductController(
              product: ProductRepository(),
            ));

class ProductController extends StateNotifier<AsyncValue<void>> {
  ProductController({required this.product}) : super(const AsyncData(null));
  final ProductRepository product;

  Future<List<Product>?> getAllProducts() async {
    state = const AsyncLoading();

    List<Product>? _userProducts;
    final newState = await AsyncValue.guard(() async {
      final prefs = await SharedPreferences.getInstance();

      String? userId = await prefs.getString('userId');
      print("userId : $userId");
      _userProducts = await product.getAllProducts(userId!);
      print("userProducts : $_userProducts");
    });
    if (mounted) {
      state = newState;
    }

    print("here is the products $_userProducts");
    return _userProducts;
  }
}
