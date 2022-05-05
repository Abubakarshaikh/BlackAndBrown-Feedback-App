import 'package:admin/app/models/app_routes.dart';
import 'package:admin/feedbacks/feedbacks.dart';
import 'package:admin/filter/filter.dart';
import 'package:flutter/material.dart';
import 'package:excel/excel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:admin/feedbacks/widgets/widgets.dart';
import 'dart:io';
import 'package:admin/app/app.dart';
import 'package:feedo_repository/feedo_repository.dart';
import 'package:flow_builder/flow_builder.dart';

class Constants {
  static const String filter = 'Filter';

  static const List<String> choices = <String>[filter];
}

class FeedbacksPage extends StatelessWidget {
  static Page page() => const MaterialPage<void>(child: FeedbacksPage());
  const FeedbacksPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    late List<Feedbacks> _feedbacksExcel;
    if (user.isEmpty) {
      context.read<AppBloc>().add(AppLogoutRequested());
    }
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  context.read<AppBloc>().add(AppLogoutRequested());
                },
                icon: const Icon(Icons.logout)),
            IconButton(
              onPressed: () async {
                exportToExcel(_feedbacksExcel);
              },
              icon: const Icon(Icons.download),
            ),
            PopupMenuButton<String>(
              onSelected: (value) {
                choiceAction(value, context);
              },
              itemBuilder: (BuildContext context) {
                return Constants.choices.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            )
          ],
          leading: const Padding(
            padding: EdgeInsets.all(3),
            child: Image(image: AssetImage("assets/logo.jpg")),
          ),
          backgroundColor: const Color(0xff1B1B1B),
          title: Text(
            "Feedbacks",
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: Colors.white),
          ),
        ),
      ),
      body: BlocBuilder<FeedbacksBloc, FeedbacksState>(
        builder: (context, state) {
          if (state is FeedbacksInitial) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          }
          if (state is FeedbacksLoaded) {
            final _feedbacks = state.feedbacks.where((e) {
              return user.email!.substring(0, user.email!.indexOf("@")) ==
                      e.userEmail.substring(0, e.userEmail.indexOf("@")) ||
                  user.email!.substring(0, user.email!.indexOf("@")) == "admin";
            }).toList();
            _feedbacksExcel = _feedbacks;
            context
                .read<FilterBloc>()
                .add(FilterFeedbacks(feedbacks: _feedbacks));
            return state.feedbacks.isNotEmpty
                ? ListView(
                    children: _feedbacks.map((feedbacks) {
                      return FeedbacksCard(feedback: feedbacks);
                    }).toList(),
                  )
                : Center(
                    child: Text("No Feedbacks available!",
                        style: Theme.of(context).textTheme.bodyText1),
                  );
          }
          return const Center(
            child: Text("Something went wrong!"),
          );
        },
      ),
    );
  }

  void choiceAction(String choice, BuildContext context) {
    if (choice == Constants.filter) {
      context.read<FeedbacksBloc>().add(FeedbacksLoad());
      context.flow<String>().update((state) => AppRoutes.authenticateComplete);
    }
  }

  Future<void> exportToExcel(List<Feedbacks> customerfeedback) async {
    final excel = Excel.createExcel();
    final Sheet sheet = excel[excel.getDefaultSheet()!];

    for (var i = 0; i < customerfeedback.length; i++) {
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i))
          .value = customerfeedback[i].branch;

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i))
          .value = customerfeedback[i].condition;

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i))
          .value = customerfeedback[i].userEmail;

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: i))
          .value = customerfeedback[i].time;

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: i))
          .value = customerfeedback[i].questions.map((e) => e.ques).toString();
      sheet
              .cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: i))
              .value =
          customerfeedback[i].questions.map((e) => e.feedback).toString();
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: i))
          .value = customerfeedback[i].name;
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: i))
          .value = customerfeedback[i].number;
    }

    excel.save(fileName: "MyData.xlsx");
    var fileBytes = excel.save();
    final String path = (await getApplicationSupportDirectory()).path;
    final String fileName = '$path/output_file_name.xlsx';
    final File file = File(fileName);
    await file.writeAsBytes(fileBytes!, flush: true);
    OpenFile.open(fileName);
  }
}
