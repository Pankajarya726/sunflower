import 'dart:collection';
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:practice/endpoints.dart';
import 'package:practice/home/model/content_response.dart';
import 'package:practice/main.dart';

class Repository {
  Future<List<Content>> getTeams() async {
    List<Content> teams = [];

    try {
      Map<String, dynamic> queryParam = {"type": "Sport"};

      Response response = await dio.get(Endpoints.getTeamList, queryParameters: queryParam);

      log("response --> ${response.data}");

      if (response.statusCode == 200) {
        Map<String, dynamic> result = HashMap<String, dynamic>();
        List<dynamic> d = jsonDecode(response.data);
        // List<dynamic> d = result["content"];
        d.forEach((element) {
          Map map = element as Map;

          teams.add(Content(name: map["name"]));
        });

        // log("result --> ${result}");
        // ContentResponse res = ContentResponse.fromJson(result.toString());
        // teams = res.content;
      }

      return teams;
    } catch (exception) {
      debugPrint("exception--->$exception");
      return teams;
    }
  }

  Future<List<Content>> getGroups() async {
    List<Content> groups = [];

    try {
      Map<String, dynamic> queryParam = {"type": "Sport", "game": "Rugby"};

      Response response = await dio.get(Endpoints.getGroupList, queryParameters: queryParam);

      if (response.statusCode == 200) {
        ContentResponse res = ContentResponse.fromJson(response.toString());

        groups = res.content;
      }

      return groups;
    } catch (exception) {
      debugPrint("exception--->$exception");
      return groups;
    }
  }
}
