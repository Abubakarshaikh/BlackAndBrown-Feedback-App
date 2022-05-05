import 'package:customer_facing/app/models/app_route.dart';
import 'package:customer_facing/form/form.dart';
import 'package:customer_facing/questions/bloc/question_bloc.dart';
import 'package:customer_facing/thank_you/bloc/thank_you_bloc.dart';
import 'package:customer_facing/title/bloc/title_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'questions_list_tile.dart';
import 'package:customer_facing/app/bloc/app_bloc.dart';
import 'package:feedo_repository/feedo_repository.dart';
import 'package:flow_builder/flow_builder.dart';

class QuestionsPage extends StatelessWidget {
  static Page page() => const MaterialPage<void>(child: QuestionsPage());
  const QuestionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       context.read<AppBloc>().add(AppLogoutRequested());
        //     },
        //     icon: const Icon(Icons.logout),
        //   ),
        // ],
        leading: const Padding(
          padding: EdgeInsets.all(3),
          child: Image(image: AssetImage("assets/logo.jpg")),
        ),
        backgroundColor: const Color(0xff1B1B1B),
        title: Text("Multi Questions",
            style: Theme.of(context).textTheme.bodyText1!),
      ),
      body: BlocBuilder<QuestionBloc, QuestionState>(
        builder: (context, state) {
          if (state is QuestionInitial) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          } else if (state is QuestionLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ListView(
                    children: state.questionLoaded.map((Question question) {
                      return QuestionListTile(
                        question: question.ques,
                        isChecked: question.isChecked,
                        onChanged: (bool? newValue) {
                          context.read<QuestionBloc>().add(QuestionUpdate(
                              updatedQuestion:
                                  question.copyWith(isChecked: newValue)));
                        },
                      );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xff1B1B1B),
                      ),
                      onPressed: () {},
                      //   context.read<TitleBloc>().add(TitleLoad(
                      //       title: state.questionLoaded
                      //           .where((element) => element.isChecked == true)
                      //           .toList()));
                      //   context
                      //       .flow<String>()
                      //       .update((state) => AppRoute.authenticatedComplete);

                      child: Text(
                        "Save",
                        style: Theme.of(context).textTheme.button,
                      )),
                ),
              ],
            );
          }
          return const Center(
            child: Text("Something went wrong"),
          );
        },
      ),
    );
  }
}
