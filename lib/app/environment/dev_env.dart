import 'package:envied/envied.dart';
import 'package:flutter_project/app/environment/app_configuration.dart';

part 'dev_env.g.dart';

@Envied(obfuscate: true, path: AppConfiguration.developmentPath)
final class DevEnv implements AppConfiguration {
  
  @EnviedField(varName: 'BASE_URL')
  static final String _baseUrl = _DevEnv._baseUrl;

  @EnviedField(varName: 'API_KEY')
  static final String _apiKey = _DevEnv._apiKey;

  @override
  String get baseUrl => _baseUrl;

  @override
  String get apiKey => _apiKey;
}
