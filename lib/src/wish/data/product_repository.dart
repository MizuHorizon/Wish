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
        // print("funkink data $data");
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

  Future<dynamic> addProduct(String userId, String url, bool trackable,
      String description, List tags, double desired_price) async {
    try {
      final Response response = await dio.post(
        "${baseUrl}product/${userId}",
        data: {
          'url': url,
          'trackable': trackable,
          'description': description,
          'tags': tags,
          'desired_price': desired_price
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json', // Set the content type header
          },
        ),
      );
      if (response.statusCode == 200) {
        //print("in the repo ${response.data}");
        var data = response.data['data'];
        print(data);
        // print("funkink data $data");
        // List<Product> products =
        //     List<Product>.from(data.map((json) => Product.fromMap(json)));
        // print("products : $products");
        return " ";
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

  Future<void> deleteProduct(String productId) async {
    try {
      final Response response = await dio.delete(
        "${baseUrl}product/$productId",
      );
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
