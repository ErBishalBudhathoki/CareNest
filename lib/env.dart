const bool isProduction = bool.fromEnvironment('dart.vm.product');

const debugConfig = {
  'baseUrl': 'com.bishal.invoice',
};

const releaseConfig = {
  'baseUrl': 'com.bishal.invoice',
};

const env = isProduction ? releaseConfig : debugConfig;
