import 'package:flutter_test/flutter_test.dart';
import 'package:nations/nations.dart';

import '../../widgets/app.dart';

void main() {
  setUp(() async {
    await Nations.boot(NationsTestConfig());
    await Nations.load(Nations.locale);
  });
  test('it translate simple key', () {
    expect('package_name'.tr, equals('أمم'));
  });
  test('it translate to male Gender', () {
    expect('gender'.trMale, equals('ذكر'));
  });
  test('it translate to female Gender', () {
    expect('gender'.trFemale, equals('انثي'));
  });
  test('it translate to the default Gender', () {
    expect('gender'.gender, equals('ذكر'));
  });
  test('it translate and replace Args', () {
    expect('args_key'.args({'name': "ملك"}), equals("اهلا بك يا ملك"));
  });

  group('pluralization', () {
    test('it support pluralization', () {
      expect('apples'.plural(1), equals("تفاحه واحده"));
      expect('apples'.plural(2), equals("اثنان تفاحات"));
      expect('apples'.plural(5), equals("خمسه تفاحات"));
      expect('apples'.plural(10), equals("عشرة تفاحات"));
      expect('apples'.plural(14), equals(" تفاحات 14"));
      expect('apples'.plural(15), equals(" تفاحات 15"));
      expect('apples'.plural(65), equals("اكثر من ستون الي سبعون تفاحة"));
    });
  });
}