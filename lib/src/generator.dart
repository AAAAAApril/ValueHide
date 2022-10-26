import 'dart:convert';
import 'dart:io';

import 'package:april_value_hide/src/nodes.dart';
import 'package:path/path.dart' as path;

import 'configs.dart';

///生成器
class Generator {
  const Generator();

  /// 生成代码
  Future<void> generateAsync(PubspecConfig config) async {
    //存放 json 文件的文件夹
    final Directory jsonFilesDirectory = Directory(path.join(
      Directory.current.path,
      config.jsonFilesParentDirectoryPath,
    ));
    if (!(await jsonFilesDirectory.exists())) {
      //没有这个文件，不需要生成代码
      stdout.writeln(
        'INFO: There is no json files need to generate in directory [${config.jsonFilesParentDirectoryPath}].',
      );
      return;
    }
    //该文件夹下的所有文件
    final List<FileSystemEntity> files =
        await jsonFilesDirectory.list().toList();
    //所有最终需要生成的 class
    final List<ClassNode> classNodes = <ClassNode>[];
    for (var file in files) {
      //是文件
      if (file is! File) {
        continue;
      }
      final List<String> fileNameAndSuffix =
          path.basename(file.path).split('.');
      //是 json 文件
      if (fileNameAndSuffix.last != 'json') {
        continue;
      }
      try {
        //文件内容 json
        Map map = jsonDecode(await file.readAsString()) as Map;
        if (map.isEmpty) {
          continue;
        }
        //添加 class 节点
        classNodes.add(
          ClassNode.fromJson(
            // class 名字
            fileNameAndSuffix.first,
            //具体内容
            Map<String, dynamic>.from(map),
          ),
        );
      } catch (_) {
        //ignore
      }
    }
    if (classNodes.isEmpty) {
      stdout.writeln('INFO: There is no json files need to generate.');
      return;
    }

    ///构造文件内容
    final StringBuffer buffer = StringBuffer();
    buffer.write(fileHeaderTemplate(config.offset));
    // 将最后的代码写入文件
    for (var node in classNodes) {
      buffer.write(
        node.classCodeTemplate(
          decodeFunctionName: '_fromIntList',
          encoder: (realValueString) => _toIntList(
            offset: config.offset,
            value: realValueString,
          ),
        ),
      );
    }

    ///查找并创建结果文件
    File resultFile = File(path.join(
      Directory.current.path,
      config.generatedFilePath,
    ));
    if (!(await resultFile.exists())) {
      resultFile = await resultFile.create(recursive: true);
    }

    ///将内容写入到文件
    await resultFile.writeAsString(buffer.toString());
  }

  ///文件头代码模板
  String fileHeaderTemplate(int offset) {
    final StringBuffer buffer = StringBuffer();
    buffer.writeln('// generated code , do not change by yourself');
    buffer.writeln("import 'dart:convert';");
    buffer.writeln();
    buffer.writeln('''
String _fromIntList(List<int> value) {
  return utf8.decode(
    value
        .map<int>((e) => e + ($offset))
        .map<int>((e) => ~e)
        .toList(),
  );
}
''');
    return buffer.toString();
  }

  ///将字符串转为字节数组
  List<int> _toIntList({
    //需要转码的字符串
    required String value,
    //偏移量
    required int offset,
  }) {
    return utf8
        .encode(value)
        .map<int>((e) => ~e)
        .map<int>((e) => e - offset)
        .toList();
  }
}
