import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:test_2/model.dart';

class CommentProvider extends ChangeNotifier {
  List<Comment> _comments = [];

  List<Comment> get comments => _comments;

  Future<void> fetchComments() async {
    try {
      final response = await http.get(
          Uri.parse('https://jsonplaceholder.typicode.com/posts/1/comments'));
      if (response.statusCode == 200) {
        List<dynamic> responseData = json.decode(response.body);
        _comments = responseData.map((data) => Comment.fromJson(data)).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to load comments: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to load comments: $error');
    }
  }

  void removeComment(int index) {
    _comments.removeAt(index);
    notifyListeners();
  }
}
