part of 'base.dart';

class NotFoundData extends ExtractedData {
  NotFoundData(String key) : super(key: key, data: null);
  @override
  String toString() => notFound;

  @override
  String args(Map<String, dynamic> args) => notFound;

  @override
  String plural(int count, [Map<String, dynamic>? args]) => notFound;

  @override
  String toGender([Gender? gender]) => notFound;
}
