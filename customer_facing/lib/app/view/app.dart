import 'package:authentication_repository/authentication_repository.dart';
import 'package:customer_facing/app/app.dart';
import 'package:customer_facing/form/bloc/form_bloc.dart';
import 'package:customer_facing/thank_you/bloc/thank_you_bloc.dart';
import 'package:feedo_repository/feedo_repository.dart';
import 'package:feedo_ui/feedo_ui.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../title/title.dart';

class App extends StatelessWidget {
  final AuthenticationRepository _authenticationRepository;
  const App(
      {Key? key, required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                AppBloc(authenticationRepository: _authenticationRepository),
          ),
          BlocProvider<FormBloc>(create: (context) => FormBloc()),
          // BlocProvider<QuestionBloc>(
          //     create: (context) =>
          //         QuestionBloc(FirebaseFeedoRepository())..add(QuestionLoad())),
          BlocProvider<TitleBloc>(
              create: (context) => TitleBloc(FirebaseFeedoRepository())
                ..add(TitleLoad())),
          BlocProvider<ThankYouBloc>(
              create: (context) =>
                  ThankYouBloc(FirebaseFeedoRepository())..add(ThankYouLoad())),
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: FeedoTheme.standard,
      home: FlowBuilder(
        state: context.select((AppBloc bloc) => bloc.state.status),
        onGeneratePages: onGenerateAppViewPages,
      ),
    );
  }
}
