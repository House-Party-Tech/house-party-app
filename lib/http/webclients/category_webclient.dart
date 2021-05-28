import 'dart:convert';

import 'package:house_party/http/webclient.dart';
import 'package:house_party/models/category.dart';
import 'package:http/http.dart';

class CategoryWebClient {

  String categoryEndpoint = 'categoria';

  Future<List<Category>> findAll() async {
    final Response response = await client.get(
      Uri.http(
        urlBase.authority,
        categoryEndpoint
      ),
    ).timeout(Duration(seconds: 30));
    final List<dynamic> responseJson = jsonDecode(utf8.decode(response.bodyBytes));
    return responseJson.map((json) => Category.fromJson(json)).toList();
  }
}
