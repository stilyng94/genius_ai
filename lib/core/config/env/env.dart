import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env', obfuscate: true)
abstract class Env {
  @EnviedField(varName: 'OPEN_AI_KEY')
  static final String openAiKey = _Env.openAiKey;
  @EnviedField(varName: 'REPLICATE_AI_KEY')
  static final String replicateAiKey = _Env.replicateAiKey;
}
