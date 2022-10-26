// generated code , do not change by yourself
import 'dart:convert';

String _fromIntList(List<int> value) {
  return utf8.decode(
    value
        .map<int>((e) => e + (-999))
        .map<int>((e) => ~e)
        .toList(),
  );
}


/// Descriptions of the Dart class who will be generated.
class Values1 {
  Values1._();

  /// Descriptions of the int value.
  /// >>>999<<<
  static final int intValueKey = int.parse(_fromIntList(const <int>[941, 941, 941]));

  /// Descriptions of the double value.
  /// >>>123.123<<<
  static final double doubleValueKey = double.parse(_fromIntList(const <int>[949, 948, 947, 952, 949, 948, 947]));

  /// Descriptions of the String value.
  /// >>>The value is a String.<<<
  static final String stringValueKey = _fromIntList(const <int>[914, 894, 897, 966, 880, 901, 890, 881, 897, 966, 893, 883, 966, 901, 966, 915, 882, 884, 893, 888, 895, 952]);
}

class Values2 {
  Values2._();

  /// >>>8888<<<
  static final int intValueKey = int.parse(_fromIntList(const <int>[942, 942, 942, 942]));
}
