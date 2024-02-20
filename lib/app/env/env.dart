import '../print.dart';
import 'base_env.dart';
import 'dev_env.dart';

class Env {
  factory Env() {
    return _singleton;
  }

  Env._internal();

  static final Env _singleton = Env._internal();

  static const String dev = 'dev';
  static const String prod = 'prod';
  static const String staging = 'staging';

  late BaseEnv config;
  late String env;

  init(String environment) {
    config = _getConfig(environment);
    env = environment;
    printty("environment initialized....");
  }

  BaseEnv _getConfig(String environment) {
    switch (environment) {
      case Env.dev:
        return DevEnv();
      default:
        return DevEnv();
    }
  }
}
