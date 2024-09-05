import 'package:bloc_demo/data/models/dashboard_model.dart';
import 'package:bloc_demo/data/repositories/api/api.dart';
import 'package:dio/dio.dart';

class DashboardRepository {
  API api = API();

  Future<List<DashboardModel>> fetchPosts() async {
    try {
      Response response = await api.sendRequest.get("/posts");
      List<dynamic> postMaps = response.data;
      return postMaps
          .map((postMap) => DashboardModel.fromJson(postMap))
          .toList();
    } catch (ex) {
      rethrow;
    }
  }
}
