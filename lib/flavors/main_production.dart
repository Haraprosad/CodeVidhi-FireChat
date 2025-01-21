import 'package:codevidhi_firechat/core/constants/env_constants.dart';
import 'package:codevidhi_firechat/flavors/app_initializer.dart';
import 'package:codevidhi_firechat/flavors/environment.dart';

void main() async {
  await initializeApp(
    EnvConstants.envProduction,
    'Production App',
    Env.PRODUCTION,
  );
}
