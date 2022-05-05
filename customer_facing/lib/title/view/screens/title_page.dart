import 'package:customer_facing/app/models/app_route.dart';
import 'package:customer_facing/form/form.dart';
import 'package:customer_facing/thank_you/bloc/thank_you_bloc.dart';
import 'package:customer_facing/title/title.dart';
import 'package:customer_facing/title/view/widgets/custom_button.dart';
import 'package:customer_facing/title/view/widgets/widgets.dart';
import 'package:feedo_ui/feedo_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/services.dart';

class TitlePage extends StatelessWidget {
  static Page page() => const MaterialPage<void>(child: TitlePage());

  const TitlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String textt = '';
    TextEditingController text = TextEditingController();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
    return Scaffold(
      backgroundColor: FeedoColors.black,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: BlocBuilder<TitleBloc, TitleState>(
          builder: (context, state) {
            if (state is TitleInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is TitleLoaded && state.title.isNotEmpty) {
              context.read<ThankYouBloc>().add(ThankYouTitleAdded(state.title));
              return SingleChildScrollView(
                reverse: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Image(image: AssetImage('assets/logo.jpg')),
                    QuestionTitle(questionTitle: state.title[state.index].ques),
                    const SizedBox(height: 24),
                    state.title[state.index].quesNum == 7 ||
                            state.title[state.index].quesNum == 8
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              InputField(
                                txtController: text,
                                textHint: 'Write Feedback',
                                changeOn: (String newValue) {
                                  textt = newValue;
                                },
                                textInputType: TextInputType.multiline,
                              ),
                              const SizedBox(height: 12),
                              CustomPrimaryButton(
                                onEvent: () {
                                  text.clear();
                                  context.read<TitleBloc>().add(TitleUpdate(
                                          feedback:
                                              state.title[state.index].copyWith(
                                        feedback: textt,
                                      )));

                                  if (state.index == state.title.length - 1) {
                                    const CircularProgressIndicator();
                                    _navigator(context);
                                  }
                                },
                                textValue: 'Submit',
                                theme: Theme.of(context),
                                buttonColor: const Color(0xffED1846),
                                textColor: Colors.white,
                              ),
                            ],
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FeedbackButton(
                                title: "YES",
                                onPushed: () {
                                  context.read<TitleBloc>().add(TitleUpdate(
                                          feedback:
                                              state.title[state.index].copyWith(
                                        feedback: "YES",
                                      )));
                                  if (state.index == state.title.length - 1) {
                                    const CircularProgressIndicator();

                                    _navigator(context);
                                  }
                                },
                                color: const Color(0xffED1846),
                              ),
                              const SizedBox(width: 36),
                              FeedbackButton(
                                title: "NO",
                                onPushed: () {
                                  context.read<TitleBloc>().add(TitleUpdate(
                                          feedback:
                                              state.title[state.index].copyWith(
                                        feedback: "NO",
                                      )));
                                  if (state.index == state.title.length - 1) {
                                    const CircularProgressIndicator();
                                    _navigator(context);
                                  }
                                },
                                color: Colors.green,
                              ),
                            ],
                          ),
                  ],
                ),
              );
            }
            return const Center(
              child: Text("Something went wrong"),
            );
          },
        ),
      ),
    );
  }

  _navigator(BuildContext context) {
    context.flow<String>().update((state) => AppRoute.titleComplete);
  }
}
