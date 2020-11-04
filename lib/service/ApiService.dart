import 'dart:convert';
import 'package:flutter_app/model/Employe.dart';
import 'package:http/http.dart' as http;

class APiService {
  Future<Employee> fetchEmployee() async {
    final response =  await http.get('https://dummy.restapiexample.com/api/v1/employees',
        headers: {
      "Accept": "application/json"
    });
    if (response.body.isNotEmpty) {
      return Employee.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to employee list');
    }
  }
}