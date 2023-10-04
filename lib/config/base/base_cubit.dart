import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:my_calendar/config/base/rx.dart';
import 'package:my_calendar/widgets/views/state_layout.dart';

abstract class BaseCubit<BaseState> extends BlocBase<BaseState> {
  BaseCubit(BaseState initialState) : super(initialState);

  final List<dynamic> loadMoreList = [];

  final BehaviorSubject<List<dynamic>> loadMoreListController =
      BehaviorSubject();

  Stream<List<dynamic>> get loadMoreListStream => loadMoreListController.stream;

  int loadMorePage = 1;
  bool canLoadMore = true;
  bool loadMoreRefresh = true;
  bool loadMoreLoading = false;

  final BehaviorSubject<StateLayout> _state =
      BehaviorSubject<StateLayout>.seeded(StateLayout.showLoading);
  final _canLoadMoreSub = BehaviorSubject<bool>.seeded(false);

  Stream<bool> get loadMoreStream => _canLoadMoreSub.stream;

  Sink<bool> get loadMoreSink => _canLoadMoreSub.sink;

  Stream<StateLayout> get stateStream => _state.stream;

  void updateStateError() {
    _state.sink.add(StateLayout.showError);
  }

  void showLoading() {
    _state.wellAdd(StateLayout.showLoading);
  }

  void showError() {
    _state.wellAdd(StateLayout.showError);
  }

  void showEmpty() {
    _state.wellAdd(StateLayout.showEmpty);
  }

  void showContent() {
    _state.wellAdd(StateLayout.showContent);
  }
}
