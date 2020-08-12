import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/models/response_model.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';
import 'package:rxdart/rxdart.dart';

class PaginationExample extends StatefulWidget {
  @override
  _PaginationExampleState createState() => _PaginationExampleState();
}

class _PaginationExampleState extends State<PaginationExample> {
  ResponseModel responseModel;
  BehaviorSubject<List<User>> streamController = BehaviorSubject();
  int currentPage = 1;
  int totalPages = 10;

  void fetchUser() async {
    if (currentPage <= totalPages) {
      print("Fetch on page: $currentPage and total page: $totalPages");
      Response response = await Dio().get("https://reqres.in/api/users?page=$currentPage");
      ResponseModel responseModel = ResponseModel.fromJson(response.data);
      currentPage++;
      totalPages = responseModel?.totalPages ?? 1;
      print("next page: $currentPage and total page: $totalPages");
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
          return PaginatedListView(
            itemCount: users.length,
            hasMoreData: currentPage <= totalPages,
            onGetMoreData: fetchUser,
            itemBuilder: (context, index) {
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
