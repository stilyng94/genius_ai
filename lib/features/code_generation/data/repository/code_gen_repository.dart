import 'package:dart_openai/dart_openai.dart';
import 'package:fpdart/fpdart.dart';
import 'package:genius_ai/features/code_generation/data/data_source/code_gen_data_source.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'code_gen_repository.g.dart';

abstract class ICodeGenRepository {
  TaskEither<String, OpenAIChatCompletionChoiceMessageModel> codeGenAsync(
      {required List<OpenAIChatCompletionChoiceMessageModel> prompts});
}

class CodeGenRepository implements ICodeGenRepository {
  final HttpCodeGenDataSource httpCodeGenDataSource;

  CodeGenRepository(this.httpCodeGenDataSource);

  @override
  TaskEither<String, OpenAIChatCompletionChoiceMessageModel> codeGenAsync(
      {required List<OpenAIChatCompletionChoiceMessageModel> prompts}) {
    return TaskEither.tryCatch(
      () async => await httpCodeGenDataSource.codeGenAsync(prompts: prompts),
      (error, stackTrace) => error.toString(),
    );
  }
}

@riverpod
ICodeGenRepository codeGenRepository(CodeGenRepositoryRef ref) {
  return CodeGenRepository(ref.watch(httpCodeGenDataSourceProvider));
}
