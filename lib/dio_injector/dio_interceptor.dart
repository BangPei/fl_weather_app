import 'package:dio/dio.dart';
import 'package:weather_app/common/common.dart';
import 'package:weather_app/dio_injector/navigation_service.dart';
import 'package:weather_app/dio_injector/setup_locator.dart';

class DioInterceptors extends InterceptorsWrapper {
  final Dio dio;
  DioInterceptors(this.dio);
  final NavigationService _nav = locator<NavigationService>();

  @override
  Future onError(err, handler) async {
    int? responseCode = err.response?.statusCode;
    var data = err.response?.data;
    // ignore: avoid_print
    print(data);
    if (responseCode != null) {
      if (responseCode == 403) {
        //
      } else {
        Common.modalInfo(
          _nav.navKey.currentContext!,
          title: data.message ?? "Something went wrong !",
          message: "Error",
        );
      }
    } else {
      Common.modalInfo(
        _nav.navKey.currentContext!,
        title: data.message ?? "Something went wrong !",
        message: "Error",
      );
    }
    super.onError(err, handler);
  }
}
