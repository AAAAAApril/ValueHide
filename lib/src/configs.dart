import 'dart:io';

import 'package:yaml/yaml.dart';
import 'package:path/path.dart' as path;

import 'utils.dart';

const String configNodeName = 'april_value_hide';
const String jsonsDirNodeName = 'jsons_dir';
const String generatedFileDirNodeName = 'generated_file_dir';
const String generatedFileNameNodeName = 'generated_file_name';
const String offsetNodeName = 'offset';

///从 pubspec.yaml 文件读取到的配置
class PubspecConfig {
  ///存放需要隐藏的值的 json 文件们的文件夹路径
  late final String jsonFilesParentDirectoryPath;

  ///生成的 Dart 文件路径
  late final String generatedFilePath;

  ///给字符串的字节码的偏移量
  late final int offset;

  ///初始化（从 pubspec.yaml 中读取配置）
  Future<void> init() async {
    final File? pubspecFile = getPubspecFile();
    if (pubspecFile == null) {
      throw Exception('未找到 [pubspec.yaml] 文件');
    }

    /// pubspec.yaml  文件内容
    final YamlMap yamlContent = loadYaml(pubspecFile.readAsStringSync());

    ///配置节点
    final YamlMap? parentNode = yamlContent[configNodeName];
    if (parentNode == null) {
      throw Exception('未找到 [$configNodeName] 节点，该节点用于添加配置信息');
    }

    /// 需要隐藏的 json 文件们所在的文件夹 路径
    jsonFilesParentDirectoryPath = parentNode[jsonsDirNodeName] as String;

    /// 生成的 Dart 文件路径
    generatedFilePath = path.join(
      parentNode[generatedFileDirNodeName] as String,
      '${parentNode[generatedFileNameNodeName] as String}.dart',
    );

    ///需要偏移的量
    offset = int.tryParse(
            (parentNode[offsetNodeName] as Object?)?.toString() ?? '0') ??
        0;
  }
}
