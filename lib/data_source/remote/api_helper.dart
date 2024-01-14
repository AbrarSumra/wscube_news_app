import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as https;

import 'api_exception.dart';

class ApiHelper {
  Future<dynamic> getApi(String url) async {
    var uri = Uri.parse(url);

    try {
      var response = await https.get(uri);
      return returnDataResponse(response);
    } on SocketException {
      throw FetchDataException(body: "Internet Error");
    }
  }

  dynamic returnDataResponse(https.Response response) {
    switch (response.statusCode) {
      case 200:
        var actualData = response.body;
        var mData = jsonDecode(actualData);
        return mData;

      case 400:
        throw BadRequestException(body: response.body.toString());

      case 401:
      case 403:
        throw UnauthorisedException(body: response.body.toString());

      case 500:
      default:
        throw FetchDataException(
            body:
                "Error occurred while Communication with Server with StatusCode : ${response.statusCode}");
    }
  }
}
