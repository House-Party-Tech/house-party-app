import 'dart:convert';

import 'package:house_party/http/webclient.dart';
import 'package:house_party/models/product.dart';
import 'package:http/http.dart';

class ProductWebClient {

  final String _productEndpoint = 'produto';

  Future<List<Product>> findAll() async {
    Response response = await client.get(
      Uri.http(urlBase.authority, _productEndpoint
      )
    );
    List<dynamic> responseJson = jsonDecode(response.body);
    return responseJson.map((json) => Product.fromJson(json)).toList();
  }

  Future<Product> findById(int id) async {
    Response response = await client.get(
      Uri.http(urlBase.authority, '$_productEndpoint/$id')
    );
    Product responseJson = jsonDecode(response.body);
    return responseJson;
  }

  Future<List<Product>> findByCategory(int idCategory) async {
    Response response = await client.get(
      Uri.http(urlBase.authority, '$_productEndpoint/categoria?categoria=$idCategory')
    ).timeout(Duration(seconds: 30));

    List<dynamic> responseJson = jsonDecode(utf8.decode(response.bodyBytes));
    return responseJson.map((json) => Product.fromJson(json)).toList();
  }

}
