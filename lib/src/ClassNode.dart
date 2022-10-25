import 'StringNode.dart';

///json 文件生成的 Dart class 节点
class ClassNode {
  const ClassNode({
    required this.name,
    required this.strings,
    required this.description,
  });

  factory ClassNode.fromJson(String name, Map<String, dynamic> json) {
    final Map<String, StringNode> strings = <String, StringNode>{};
    for (var entry in json.entries) {
      if (!entry.key.startsWith('@')) {
        strings[entry.key] = StringNode.fromJson(entry.key, json);
      }
    }
    return ClassNode(
      name: name,
      strings: strings,
      description: json['@desc'] as String?,
    );
  }

  ///生成的 class 的名字
  final String name;

  ///内部的所有字符串
  final Map<String, StringNode> strings;

  ///给这个 class 的描述（即：注释）
  final String? description;
}
