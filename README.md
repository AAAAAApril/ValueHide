## Getting started

Run `flutter pub global activate april_value_hide` in project Terminal for activate this tool.

## Usage

1. Add this in your project `pubspec.yaml` with top level.

```yaml
april_value_hide:
  jsons_dir: 'example/jsons'
  generated_file_dir: 'example'
  generated_file_name: 'HiddenValues'
  offset: '-999'
```

2. There is a json file named `Values1.json` and in directory `example/jsons` witch content like
   this:  
There is support three value types of `int` `double` and `String` only.  

```json
{
  "@desc": "Descriptions of the Dart class who will be generated.",
  "intValueKey": 999,
  "@intValueKey": "Descriptions of the int value.",
  "doubleValueKey": 123.123,
  "@doubleValueKey": "Descriptions of the double value.",
  "stringValueKey": "The value is a String.",
  "@stringValueKey": "Descriptions of the String value."
}
```
3. And also has a json file named `Values2.json` in directory `example/jsons` witch content like
   this:
```json
{
  "intValueKey": 8888
}
```

5. Run `flutter pub global run april_value_hide:generate` in project Terminal for generate Dart file
   with this tool.
---
Then there will be created a file with path `example/HiddenValues.dart` witch has content like this:

```dart
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

```