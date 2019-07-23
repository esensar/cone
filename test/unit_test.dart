import 'package:test/test.dart';

import 'package:cone/src/utils.dart';

void main() {
  group('Number of new lines to add', () {
    test('Empty', () {
      expect(MeasureNewlines('').numberOfNewlinesToAddBetween(), 0);
    });
    test('Nonempty', () {
      expect(MeasureNewlines('Hello').numberOfNewlinesToAddBetween(), 2);
    });
    test('Nonempty with one trailing newline', () {
      expect(MeasureNewlines('Hello\n').numberOfNewlinesToAddBetween(), 1);
    });
    test('Nonempty with two trailing newlines', () {
      expect(MeasureNewlines('Hello' + '\n' * 2).numberOfNewlinesToAddBetween(),
          0);
    });
  });

  group('Needs new line', () {
    test('Nonempty', () {
      expect(MeasureNewlines('Hello').needsNewline(), true);
    });
    test('Nonempty with one trailing newline', () {
      expect(MeasureNewlines('Hello\n').needsNewline(), false);
    });
  });

  group('Append file', () {
    void testAppendFile(
        String oldContents, String contentsToAdd, String expectedNewContents) {
      final String actualNewContents =
          combineContentsWithLinebreak(oldContents, contentsToAdd);
      expect(actualNewContents, expectedNewContents);
    }

    test('Original is empty', () {
      testAppendFile('', 'Taco Time!', 'Taco Time!\n');
    });
    test('Original is one linebreak', () {
      testAppendFile('\n', 'Taco Time!', '\nTaco Time!\n');
    });
    test('Original is nonempty', () {
      testAppendFile(
          'hello world', 'Taco Time!', 'hello world\n\nTaco Time!\n');
    });
    test('Original is nonempty with one linebreak', () {
      testAppendFile(
          'hello world\n', 'Taco Time!', 'hello world\n\nTaco Time!\n');
    });
    test('Original is nonempty with two linebreaks', () {
      testAppendFile(
          'hello world\n\n', 'Taco Time!', 'hello world\n\nTaco Time!\n');
    });
  });
}