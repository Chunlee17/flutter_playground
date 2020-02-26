import 'package:states_rebuilder/states_rebuilder.dart';

enum ViewState { loading, ready, error }

class BaseViewModel extends StatesRebuilder {
  ViewState _state = ViewState.ready;
  String errorMessage;
  ViewState get state => _state;

  void setState(ViewState viewState) {
    _state = viewState;
    rebuildStates();
  }
}
