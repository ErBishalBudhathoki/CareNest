import 'package:flutter/foundation.dart';

class ApiResponse {
  // _data will hold any response converted into
  // its own object. For example user.
  Object _data = '';

  // apiError will hold the error object
  Object apiError = {};

  Object get data {
    debugPrint("Datas:$_data");
    return _data;
  }

  set data(Object data) {
    _data = data;
    debugPrint("Data: $_data");
  }
}
