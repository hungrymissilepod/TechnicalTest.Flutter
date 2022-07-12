import 'package:flutter/material.dart';
import 'package:flutter_tech_task/models/post.dart';
import 'package:flutter_tech_task/ui/views/details_page/save_button_widget.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SaveButton - Widget Tests', () {
    testWidgets(
        'SaveButton - Check UI when user alredy has downloaded the post',
        (WidgetTester tester) async {
      Post _post = Post('post-title', 'post-body', 0);
      await tester.pumpWidget(_WidgetUnderTest(
        post: _post,
        hasPost: true,
      ));

      // Check the text and icon on the button
      expect(find.text('Saved'), findsOneWidget);
      expect(find.byIcon(Icons.check), findsOneWidget);

      // Tap the button
      await tester.tap(find.byType(TextButton));
      await tester.pump();

      // Expect to see snakcbar message
      expect(find.text('Post alredy downloaded'), findsOneWidget);
    });

    testWidgets(
        'SaveButton - Check UI when user alredy has NOT downloaded the post',
        (WidgetTester tester) async {
      Post _post = Post('post-title', 'post-body', 0);
      await tester.pumpWidget(_WidgetUnderTest(
        post: _post,
        hasPost: false,
      ));

      // Check the text and icon on the button
      expect(find.text('Save For Offline'), findsOneWidget);
      expect(find.byIcon(Icons.download), findsOneWidget);
    });

    testWidgets(
        'SaveButton - Check error handling when the post object is null',
        (WidgetTester tester) async {
      await tester.pumpWidget(const _WidgetUnderTest(
        post: null,
        hasPost: true,
      ));

      // Tap the button
      await tester.tap(find.byType(TextButton));
      await tester.pump();

      // Expect to see snakcbar message
      expect(find.text('Error saving post'), findsOneWidget);
    });
  });
}

class _WidgetUnderTest extends StatelessWidget {
  const _WidgetUnderTest({required this.post, required this.hasPost, Key? key})
      : super(key: key);

  final Post? post;
  final bool hasPost;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(
        child: Scaffold(
            body: SaveButton(
          post: post,
          hasPost: hasPost,
        )),
      ),
    );
  }
}
