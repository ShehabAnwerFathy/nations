import 'dart:convert';
import 'dart:developer';
import 'package:nations/nations.dart';
import 'package:nations/src/validation/gender.dart';
import 'enums.dart';

Map<String, dynamic> get _values => Nations.translations.values;
Map<String, dynamic> get _nationValues => Nations.translations.nationValues;

class ExtractedData {
  final String key;
  final dynamic data;

  ExtractedData({
    required this.key,
    required this.data,
  });
  factory ExtractedData.from(String key) => ExtractedData(
        key: key,
        data: extract(key),
      );

  @override
  String toString() {
    if (data != null && data is String) return data;
    log('extraction is not done correctly you have to use the right extractor function');
    return Nations.config.notFoundBuilder(key);
  }

  String toGender(Gender? gender) {
    if (isValidGenderMap(key, data)) {
      switch (gender) {
        case null:
          return toGender(Nations.config.defaultGender);
        case Gender.male:
          return data['male'];
        case Gender.female:
          return data['female'];
        case Gender.other:
          return data['other'] ?? toGender(Nations.config.defaultGender);
      }
    } else {
      log('$key is not valid gender translation');
      return Nations.config.notFoundBuilder(key);
    }
  }
}

dynamic _transFromMap(String key, dynamic values) {
  if (values is! Map) {
    //   print('newx $key' + values.runtimeType.toString());
    //   log('$key values is not a Map !');
    // return 'values is not a map';
    return values;
  }
  if (key.contains('.')) {
    final keys = key.split('.');
    if (keys.length > 1) {
      final firstArg = keys.first;
      // still want to go deeper
      log('firstArg : $firstArg');
      final newKey = key.replaceFirst('$firstArg.', '');
      log('newKey : $newKey');

      return _transFromMap(newKey, values[firstArg]);
    } else {
      return values[keys.first];
    }
  } else {
    return values[key];
  }
}

dynamic extract(String key) {
  final fromValues = _transFromMap(key, _values);

  if (fromValues != null) return fromValues;
  log(
    'key $key does not exist in the project '
    'lang files with the locale ${Nations.locale} ,, '
    'trying to get it from the nations ....',
  );
  final fromNation = _transFromMap(key, _nationValues);
  if (fromNation != null) return fromNation;
  log(
    'key $key does not exist in nation files neither the project '
    'lang files with the locale ${Nations.locale} ,, '
    'trying to get it from the nations ....',
  );
  log('cant get from the nation will return null then !');
}

// String extractGender(String dynamic data, Gender gender) {
//   if (data is! Map) {
//     log('')
//   }
// }
