class EnviromentConfig {
  static const appName = String.fromEnvironment('LITB_APP_NAME');
  static const appSuffix = String.fromEnvironment('LITB_APP_SUFFIX');
  static const isDev = appSuffix == '.dev';
  static const databaseName =
      isDev ? 'fengshuinumber_dev.db' : 'fengshuinumber.db';
}
