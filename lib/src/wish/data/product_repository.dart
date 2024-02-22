import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:wish/src/constants.dart';
import 'package:wish/src/wish/models/product_model.dart';

class ProductRepository {
  final dio = Dio();

  Future<List<Product>> getAllProducts(String userId) async {
    try {
      final Response response =
          await dio.get("${baseUrl}product/", queryParameters: {
        'id': userId,
      });
      if (response.statusCode == 201) {
        //print("in the repo ${response.data}");
        var data = response.data['data'];
        print("funkink data $data");
        List<Product> products =
            List<Product>.from(data.map((json) => Product.fromMap(json)));
        // print("products : $products");
        return products;
      } else {
        throw response.data;
      }
    } catch (e) {
      if (e is DioException) {
        if (e.error is SocketException) {
          throw ('Server is not reachable.');
        } else if (e.response!.statusCode == 404) {
          throw e.response!.data['message'];
        } else {
          print('Dio error: ${e.message}');
          throw 'Dio error: ${e.message}';
        }
      } else {
        print('Error: $e');
        throw '$e';
      }
    }
  }
}
