import 'package:dio/dio.dart';

extension HttpExtensions on Dio {
  //Adds an interceptor to validate the response
  void addStatusCodeValidator(int successCode) {
    interceptors.add(InterceptorsWrapper(onResponse: (response, handler) {
      // On receiving the response, validate if it is success code
      if (response.statusCode != successCode) {
        handler.reject(DioError(
            requestOptions: response.requestOptions,
            response: response,
            type: DioErrorType.other,
            error: "Invalid Status from API"));
      } else {
        //Call the next interceptor
        return handler.next(response);
      }
    }));
  }

  //Add Authorization
  void addAuthorizationToken(String authToken) {
    interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      // Before sending the request, add the custom header
      options.headers["Authorization"] = authToken;
      //Process the requst
      return handler.next(options);
    }));
  }
}
