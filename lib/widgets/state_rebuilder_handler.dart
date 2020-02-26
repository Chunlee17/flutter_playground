import 'package:flutter/material.dart';
import 'package:flutter_playground/models/base_model.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class StateBuilderHandler<T extends BaseViewModel> extends StatelessWidget {
  final T model;
  final Widget Function(BuildContext) builder;
  final Widget loading;
  final Widget Function(String) error;
  final Function onInitState;
  StateBuilderHandler({this.model, this.builder, this.loading, this.onInitState, this.error});
  @override
  Widget build(BuildContext context) {
    return StateBuilder<T>(
      models: [model],
      initState: (ctx, _) {
        if (onInitState != null) onInitState();
      },
      builder: (ctx, _) {
        switch (model.state) {
          case ViewState.loading:
            return loading;
            break;
          case ViewState.ready:
            return builder(ctx);
            break;
          case ViewState.error:
            return error(model.errorMessage);
            break;
          default:
            return Container();
        }
      },
    );
  }
}
