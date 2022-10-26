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

2. There is a json file named `Values.json` and in directory `example/jsons` witch content like
   this:

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

3. Run `flutter pub global run april_value_hide:generate` in project Terminal for generate Dart file
   with this tool.
4. 