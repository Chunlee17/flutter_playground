import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/models/response_model.dart';
import 'package:flutter_playground/widgets/stateful_widget_mixin.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';
import 'package:rxdart/rxdart.dart';

class PaginationExample extends StatefulWidget {
  @override
  _PaginationExampleState createState() => _PaginationExampleState();
}

class _PaginationExampleState extends State<PaginationExample> {
  ResponseModel responseModel;
  BehaviorSubject<List<User>> streamController = BehaviorSubject();
  int currentPage = 0;
  ScrollController scrollController;

  void fetchUser() async {
    int totalPages = responseModel?.totalPages ?? 10;
    currentPage++;
    print("Fetch on page: $currentPage and total page: $totalPages");
    if (currentPage <= totalPages) {
      Response response =
          await Dio().get("https://reqres.in/api/users?page=$currentPage");
      ResponseModel responseModel = ResponseModel.fromJson(response.data);
      if (this.responseModel == null) {
        this.responseModel = responseModel;
        streamController.add(responseModel.users);
      } else {
        List<User> users = [...streamController.value, ...responseModel.users];
        streamController.add(users);
      }
    }
  }

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.offset >=
          scrollController.position.maxScrollExtent) {
        fetchUser();
      }
    });
    fetchUser();
    super.initState();
  }

  @override
  void dispose() {
    streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pagination Example"),
      ),
      body: StreamHandler<List<User>>(
        stream: streamController.stream,
        ready: (users) {
          return ListView.builder(
            itemCount: users.length,
            controller: scrollController,
            itemBuilder: (BuildContext context, int index) {
              final user = users[index];
              return Container(
                height: 300,
                child: ListTile(
                  title: Text(user.email),
                  subtitle: Text(user.firstName),
                ),
              );
            },
          );
        },
      ),
    );
  }
}