// To parse this JSON data, do
//
//     final contentResponse = contentResponseFromMap(jsonString);

import 'dart:convert';

class ContentResponse {
  ContentResponse({
    required this.content,
  });

  List<Content> content;

  factory ContentResponse.fromJson(String str) => ContentResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ContentResponse.fromMap(Map<String, dynamic> json) => ContentResponse(
        content: json["content"] == null ? [] : List<Content>.from(json["content"].map((x) => Content.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "content": content == null ? null : List<dynamic>.from(content.map((x) => x.toMap())),
      };
}

class Content {
  Content({
    required this.name,
  });

  String name;

  factory Content.fromJson(String str) => Content.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Content.fromMap(Map<String, dynamic> json) => Content(
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toMap() => {
        "name": name == null ? null : name,
      };
}
