import 'dart:convert';
import 'package:api/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductService {
  Future<List<Product>> getProducts() async {
    Uri url = Uri.parse('https://dummyjson.com/products');
    http.Response response = await http.get(url);
    List<dynamic> data = jsonDecode(response.body)['products'];
    return data.map((e) => Product.fromJson(e)).toList();
  }
}
