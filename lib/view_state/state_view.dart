import 'package:user_list/model/user_model.dart';

abstract class StateViewModel {}

class StateIdle implements StateViewModel {
  const StateIdle();
}

class StateLoading implements StateViewModel {
  const StateLoading();
}

class StateSucess implements StateViewModel {
  final List<UserModel> userList;
  const StateSucess(this.userList);
}

class StateErro implements StateViewModel {
  final String message;
  const StateErro(this.message);
}
