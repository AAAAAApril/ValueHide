library april_value_hide;

import 'dart:io';

import 'package:april_value_hide/april_value_hide.dart';

Future<void> main(List<String> args) async {
  try {
    // final Generator generator = Generator();
    // final PubspecConfig config = PubspecConfig();
    // await generator.generateAsync(config);
  } catch (e) {
    stderr.writeln('ERROR: Failed to generate files.\n$e');
    exit(2);
  }
}
