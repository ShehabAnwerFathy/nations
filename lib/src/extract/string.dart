part of 'base.dart';

class StringData extends ExtractedData<String> {
  StringData(String key, String value) : super(key: key, data: value);

  @override
  String args(Map<String, dynamic> args) => replaceArgsOf(data, args);

  @override
  String toString() => data;

  @override
  String plural(int count, [Map<String, dynamic>? args]) => notFound;

  @override
  String toGender([Gender? gender]) => notFound;
}
