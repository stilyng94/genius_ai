import 'package:dart_openai/dart_openai.dart';
import 'package:fpdart/fpdart.dart';
import 'package:genius_ai/features/code_generation/data/repository/code_gen_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'code_gen_provider.g.dart';

@riverpod
class CodeGenListNotifier extends _$CodeGenListNotifier {
  @override
  List<OpenAIChatCompletionChoiceMessageModel> build() {
    return const [
      OpenAIChatCompletionChoiceMessageModel(
          role: OpenAIChatMessageRole.system, content: demoMarkdown)
    ];
  }

  void updateList(
      ({
        OpenAIChatCompletionChoiceMessageModel userPrompt,
        OpenAIChatCompletionChoiceMessageModel aiResponse
      }) messages) {
    state = [...state, messages.userPrompt, messages.aiResponse];
  }
}

@riverpod
class CodeGenNotifier extends _$CodeGenNotifier {
  @override
  FutureOr<Unit> build() {
    return unit;
  }

  FutureOr<Unit> chatAsync(String prompt) async {
    state = const AsyncLoading();
    final newPrompt = OpenAIChatCompletionChoiceMessageModel(
        content: prompt, role: OpenAIChatMessageRole.user);
    final prompts = [...ref.read(codeGenListNotifierProvider), newPrompt];

    final failureOrSuccess = await ref
        .read(codeGenRepositoryProvider)
        .codeGenAsync(prompts: prompts)
        .run();
    state =
        failureOrSuccess.fold((l) => AsyncError(l, StackTrace.current), (r) {
      ref
          .read(codeGenListNotifierProvider.notifier)
          .updateList((userPrompt: newPrompt, aiResponse: r));
      return const AsyncData(unit);
    });

    return unit;
  }
}

@riverpod
int codeGenIndex(CodeGenIndexRef ref) {
  throw UnimplementedError("Pass a valid index");
}

const demoMarkdown = """
# I'm h1
## I'm h2
### I'm h3
#### I'm h4
###### I'm h5
###### I'm h6

```
class MarkdownHelper {


  Map<String, Widget> getTitleWidget(m.Node node) => title.getTitleWidget(node);

  Widget getPWidget(m.Element node) => p.getPWidget(node);

  Widget getPreWidget(m.Node node) => pre.getPreWidget(node);

}
```


*italic text*

**strong text**

`I'm code`

~~del~~

***~~italic strong and del~~***

> Test for blockquote and **strong**


- ul list
- one
    - aa *a* a
    - bbbb
        - CCCC

1. ol list
2. aaaa
3. bbbb
    1. AAAA
    2. BBBB
    3. CCCC


[I'm link](https://github.com/asjqkkkk/flutter-todos)


- [ ] I'm *CheckBox*

- [x] I'm *CheckBox* too

Test for divider(hr):

---

Test for Table:

header 1 | header 2
---|---
row 1 col 1 | row 1 col 2
row 2 col 1 | row 2 col 2

Image:

![support](assets/script_medias/1675527935336.png)

Image with link:

[![pub package](assets/script_medias/1675527938945.png)](https://pub.dartlang.org/packages/markdown_widget)

Html Image:

<img width="250" height="250" src="assets/script_medias/1675527939855.png"/>

Video:

<video src="http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4">


""";
