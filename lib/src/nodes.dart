import 'value_type.dart';

///json 文件生成的 Dart class 节点
class ClassNode {
  const ClassNode({
    required this.name,
    required this.strings,
    required this.descriptions,
  });

  factory ClassNode.fromJson(String name, Map<String, dynamic> json) {
    final Map<String, StringNode> strings = <String, StringNode>{};
    for (var entry in json.entries) {
      if (!entry.key.startsWith('@')) {
        strings[entry.key] = StringNode.fromJson(entry.key, json);
      }
    }
    final List<String> descriptions = <String>[];
    dynamic desc = json['@desc'];
    //注释是 字符串
    if (desc is String) {
      descriptions.addAll(
        desc.split('\n')..removeWhere((element) => element.isEmpty),
      );
    }
    //注释是 数组
    else if (desc is List) {
      descriptions.addAll(
        desc.map<String>((e) => '$e').toList()
          ..removeWhere((element) => element.isEmpty),
      );
    }
    return ClassNode(
      name: name,
      strings: strings,
      descriptions: descriptions,
    );
  }

  ///生成的 class 的名字
  final String name;

  ///内部的所有字符串
  final Map<String, StringNode> strings;

  ///给这个 class 的描述（即：注释）
  final List<String> descriptions;

  String classCodeTemplate({
    //把字节码转回原始值的函数名
    required String decodeFunctionName,
    //把原始值转为字节码的函数
    required List<int> Function(String realValueString) encoder,
  }) {
    final StringBuffer buffer = StringBuffer();
    //空白行
    buffer.writeln();
    // 注释
    for (var element in descriptions) {
      buffer.writeln('/// $element');
    }
    //类名
    buffer.writeln('class $name {');
    //匿名构造函数
    buffer.writeln('  $name._();');
    // 所有的静态属性
    for (var value in strings.values) {
      buffer.write(
        value.fieldCodeTemplate(
          decodeFunctionName: decodeFunctionName,
          encodedValue: encoder.call(value.value),
        ),
      );
    }
    //右括号
    buffer.writeln('}');
    return buffer.toString();
  }
}

///字符串节点
class StringNode {
  const StringNode({
    required this.key,
    required this.value,
    required this.descriptions,
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
    final List<String> descriptions = <String>[];
    dynamic desc = json['@$key'];
    //注释是 字符串
    if (desc is String) {
      descriptions.addAll(
        desc.split('\n')..removeWhere((element) => element.isEmpty),
      );
    }
    //注释是 数组
    else if (desc is List) {
      descriptions.addAll(
        desc.map<String>((e) => '$e').toList()
          ..removeWhere((element) => element.isEmpty),
      );
    }
    return StringNode(
      key: key,
      value: realValue.toString(),
      descriptions: descriptions,
      realType: realType,
    );
  }

  ///这个字符串节点的 key
  final String key;

  ///这个字符串节点的 value（字符串类型）
  final String value;

  ///对这个字符串的描述（即：注释）
  final List<String> descriptions;

  ///字符串最终需要转换成的类型
  final ValueType realType;

  /// 静态属性代码模板
  String fieldCodeTemplate({
    //把字节码转回原始值的函数名
    required String decodeFunctionName,
    //位移过的字节码数组
    required List<int> encodedValue,
  }) {
    final StringBuffer buffer = StringBuffer();
    //空白行
    buffer.writeln();
    // 注释
    for (var element in descriptions) {
      buffer.writeln('  /// $element');
    }
    //原始值
    buffer.writeln('  /// >>>$value<<<');
    //代码
    buffer.writeln(
      '  static final ${realType.value} $key ='
      ' ${realType.typeParseTemplate("$decodeFunctionName(const <int>$encodedValue)")};',
    );
    return buffer.toString();
  }
}
