/// String 值的 真实类型
enum ValueType {
  intType('int'),
  doubleType('double'),
  stringType('String');

  const ValueType(this.value);

  ///真实类型名
  final String value;

  ///类型转换模板字符
  String typeParseTemplate(String codeString) {
    switch (this) {
      case ValueType.intType:
        return 'int.parse($codeString)';
      case ValueType.doubleType:
        return 'double.parse($codeString)';
      case ValueType.stringType:
        return codeString;
    }
  }
}
