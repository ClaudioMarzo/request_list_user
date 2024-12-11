import 'package:dio/dio.dart';
import 'package:user_list/model/user_model.dart';
import 'package:user_list/service/i_user_service.dart';

class UserService extends IUserService {
  final Dio dio;
  final String baseUrl;

  UserService(this.baseUrl, {required this.dio});

  @override
  Future<List<UserModel>?> getUserList() async {
    try {
      final response = await dio.get(baseUrl);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => UserModel.fromJson(json)).toList();
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }
}
