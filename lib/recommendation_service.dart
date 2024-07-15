import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<String>> fetchRecommendations(String itemId) async {
  final response = await http
      .get(Uri.parse('http://127.0.0.1:5000/recommend?item_id=$itemId'));

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return List<String>.from(data);
  } else if (response.statusCode == 404) {
    print('Item ID not found');
    return [];
  } else {
    throw Exception('Failed to load recommendations');
  }
}
