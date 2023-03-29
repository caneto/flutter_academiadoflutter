import 'dart:convert';

abstract class RequestMapping {
  final Map<String, dynamic> data;

  RequestMapping.empty() : data = {};

  RequestMapping(String dataRequest) : data = jsonDecode(dataRequest) {
    map();
  }

  void map();
}