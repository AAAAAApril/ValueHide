import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as path;

///获取配置文件
File? getPubspecFile() {
  //项目跟路径
  var rootDirPath = Directory.current.path;
  var pubspecFilePath = path.join(rootDirPath, 'pubspec.yaml');
  var pubspecFile = File(pubspecFilePath);
  return pubspecFile.existsSync() ? pubspecFile : null;
}

///从文件中读取 json
Future<Map<String, dynamic>> readJsonFromFile(File file) async {
  try {
    return Map<String, dynamic>.from(
      jsonDecode(await file.readAsString()) as Map<dynamic, dynamic>,
    );
  } catch (_) {
    return <String, dynamic>{};
  }
}
