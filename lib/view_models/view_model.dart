import 'package:flutter/material.dart';
import 'package:user_list/model/user_model.dart';
import 'package:user_list/service/i_user_service.dart';
import 'package:user_list/view_state/state_view.dart';

class ViewModel {
  final IUserService userServic;

  ViewModel({required this.userServic});

  ValueNotifier<StateViewModel> getUser = ValueNotifier<StateViewModel>(const StateIdle());

  void _setStateIdle() => getUser.value = const StateIdle();
  void _setStateLoading() => getUser.value = const StateLoading();
  void _setStateSucess(List<UserModel>? userList) => getUser.value = StateSucess(userList!);
  void _setStateErro(String message) => getUser.value = StateErro(message);

  Future<void> getUserModel() async {
    _setStateLoading();
    try {
      final List<UserModel>? userList = await userServic.getUserList();
      userList != null && userList.isNotEmpty ? _setStateSucess(userList) : _setStateErro('No users found');
    } catch (e) {
      _setStateErro(e.toString());
    }
  }

  void clearUserList() {
    _setStateIdle();
  }
}
