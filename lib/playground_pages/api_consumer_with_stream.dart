import 'package:flutter/material.dart';
import 'package:flutter_playground/bloc/base_extend_bloc.dart';
import 'package:flutter_playground/models/post_model.dart';
import 'package:flutter_playground/service/api_provider.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';

class ApiConsumerWithStream extends StatefulWidget {
  @override
  _ApiConsumerWithStreamState createState() => _ApiConsumerWithStreamState();
}

class _ApiConsumerWithStreamState extends State<ApiConsumerWithStream> {
  ApiProvider apiProvider = ApiProvider();
  PostModel postModel;
  BaseExtendBloc<List<PostModel>> baseBloc = BaseExtendBloc();

  void fetchPost() async {
    try {
      baseBloc.addData(null);
      var data = await apiProvider.getPosts();
      postModel = await apiProvider.getSinglePost();
      baseBloc.addData(data);
    } catch (e) {
      baseBloc.addError(e);
    }
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
        title: Text("Api Consumer With Stream"),
        actions: <Widget>[
          SmallIconButton(
            icon: Icon(Icons.refresh),
            onTap: fetchPost,
          )
        ],
      ),
      body: StreamHandler<List<PostModel>>(
        stream: baseBloc.stream,
        error: (error) {
          return Center(
            child: Text(
              error,
              textAlign: TextAlign.center,
            ),
          );
        },
        ready: (data) {
          return Column(
            children: <Widget>[
              Card(
                child: Text(postModel.body),
              ),
              Expanded(
                child: ListView.separated(
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
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
