import 'base_env.dart';

class DevEnv implements BaseEnv {
  //@override
  //String get baseUrl => 'http://10.0.2.2:3003';

  @override
  String get baseUrl => 'http://192.168.185.44:3003'; //Redmi

  // @override
  // String get baseUrl => "http://192.168.100.111:3003";  //Engee

  @override
  bool get isDev => true;
}
