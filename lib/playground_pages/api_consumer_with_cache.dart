import 'package:flutter/material.dart';
import 'package:flutter_playground/models/post_model.dart';
import 'package:flutter_playground/service/api_provider.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';

class ApiConsumerWithCache extends StatefulWidget {
  @override
  _ApiConsumerWithCacheState createState() => _ApiConsumerWithCacheState();
}

class _ApiConsumerWithCacheState extends State<ApiConsumerWithCache> {
  Future<List<PostModel>> ftPost;
  ApiProvider apiProvider = ApiProvider();

  void fetchPost() async {
    ftPost = apiProvider.getPosts();
  }

  @override
  void initState() {
    fetchPost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Api Consumer with Future"),
        actions: <Widget>[
          SmallIconButton(
            icon: Icon(Icons.refresh),
            onTap: fetchPost,
          )
        ],
      ),
      body: FutureHandler<List<PostModel>>(
        future: ftPost,
        error: (error) {
          return Center(
            child: Text(
              error,
              textAlign: TextAlign.center,
            ),
          );
        },
        ready: (data) {
          return ListView.separated(
            separatorBuilder: (context, index) => Divider(),
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              final post = data[index];
              return ListTile(
                leading: Text(post.id.toString()),
                title: Text(post.title),
                subtitle: Text(post.body),
                onTap: () {},
              );
            },
          );
        },
      ),
    );
  }
}
