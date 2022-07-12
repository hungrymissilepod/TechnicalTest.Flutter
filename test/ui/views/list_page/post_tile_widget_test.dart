import 'package:flutter/material.dart';
import 'package:flutter_tech_task/models/post.dart';
import 'package:flutter_tech_task/ui/views/list_page/post_tile_widget.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PostTile - Widget Tests', () {
    testWidgets('PostTile - Expect title and body when Post object is NOT null',
        (WidgetTester tester) async {
      Post _post = Post('post-title', 'post-body', 0);
      await tester.pumpWidget(_WidgetUnderTest(post: _post));

      expect(find.text('post-title'), findsOneWidget);
      expect(find.text('post-body'), findsOneWidget);
    });

    testWidgets(
        'PostTile - Expect title and body fallbacks when Post object is null',
        (WidgetTester tester) async {
      await tester.pumpWidget(const _WidgetUnderTest(post: null));

      expect(find.text('Title'), findsOneWidget);
      expect(find.text('Body'), findsOneWidget);
    });

    testWidgets('PostTile - Check title TextStyle',
        (WidgetTester tester) async {
      Post _post = Post('post-title', 'post-body', 0);
      await tester.pumpWidget(_WidgetUnderTest(post: _post));

      // Find the title text widget
      final Text titleText =
          tester.firstWidget(find.text('post-title')) as Text;
      expect(titleText.style?.fontSize, 16);
      expect(titleText.style?.fontWeight, FontWeight.bold);

      // Find the body text widget
      final Text bodyText = tester.firstWidget(find.text('post-body')) as Text;
      expect(bodyText.style?.fontSize, isNot(16));
    });
  });
}

class _WidgetUnderTest extends StatelessWidget {
  const _WidgetUnderTest({required this.post, Key? key}) : super(key: key);

  final Post? post;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(
        child: PostTile(
          post: post,
        ),
      ),
    );
  }
}
