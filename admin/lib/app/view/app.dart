import 'package:authentication_repository/authentication_repository.dart';
import 'package:admin/app/app.dart';
import 'package:feedo_ui/feedo_ui.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin/feedbacks/feedbacks.dart';
import 'package:admin/filter/filter.dart';
import 'package:feedo_repository/feedo_repository.dart';

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
          BlocProvider<FeedbacksBloc>(
              create: (context) => FeedbacksBloc(FirebaseFeedoRepository())
                ..add(FeedbacksLoad())),
          BlocProvider(
              create: (context) =>
                  FilterBloc(FirebaseFeedoRepository())..add(FilterLoad())),
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
