import 'value_type.dart';

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

///字符串节点
class StringNode {
  const StringNode({
    required this.key,
    required this.value,
    required this.description,
    required this.realType,
  });

  factory StringNode.fromJson(String key, Map<String, dynamic> json) {
    dynamic realValue = json[key];
    ValueType realType;
    if (realValue is int) {
      realType = ValueType.intType;
    } else if (realValue is double) {
      realType = ValueType.doubleType;
    } else if (realValue is String) {
      realType = ValueType.stringType;
    } else {
      throw Exception('ERROR: The value type  of key [$key] is not supported.');
    }
    return StringNode(
      key: key,
      value: realValue.toString(),
      description: json['@$key'] as String?,
      realType: realType,
    );
  }

  ///这个字符串节点的 key
  final String key;

  ///这个字符串节点的 value（字符串类型）
  final String value;

  ///对这个字符串的描述（即：注释）
  final String? description;

  ///字符串最终需要转换成的类型
  final ValueType realType;
}
