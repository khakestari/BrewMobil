import 'package:retrofit/http.dart';

import '../../app/constant.dart';

@RestApi(baseUrl: Constant.baseUrl)
abstract class AppServiceClient {}
