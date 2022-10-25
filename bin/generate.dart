library april_value_hide;

import 'dart:io';

import 'package:april_value_hide/april_value_hide.dart';

Future<void> main(List<String> args) async {
  try {
    final PubspecConfig config = PubspecConfig();
    await config.init();
    final Generator generator = Generator();
    await generator.generateAsync(config);
  } catch (e) {
    stderr.writeln('ERROR: Failed to generate files.\n$e');
    exit(2);
  }
}
