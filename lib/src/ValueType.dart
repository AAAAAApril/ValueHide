/// String 值的 真实类型
enum ValueType {
  intType('int'),
  doubleType('double'),
  stringType('String');

  const ValueType(this.value);

  ///真实类型名
  final String value;
}

extension ValueTypeListExt on List<ValueType> {
  ValueType fromValue(String value) {
    try {
      return firstWhere((element) => element.value == value);
    } catch (_) {
      return ValueType.stringType;
    }
  }
}
