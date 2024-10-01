import 'package:dio/dio.dart';

class DioHelper{
  static late Dio dio;
  static init(){
    dio=Dio(
      BaseOptions(receiveDataWhenStatusError: true,
        baseUrl: 'https://wger.de',
      )
    );
  }
  static Future<Response?> getdata({required String url,required Map<String ,dynamic> query})
  async{
      return await dio?.get(url,queryParameters: query);
}
}

