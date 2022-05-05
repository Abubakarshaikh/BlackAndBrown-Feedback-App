import 'package:admin/app/models/app_routes.dart';
import 'package:admin/feedbacks/feedbacks.dart';
import 'package:admin/filter/filter.dart';
import 'package:feedo_ui/feedo_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin/filter/widgets/widgets.dart';
import 'package:feedo_repository/feedo_repository.dart';
import 'package:admin/app/app.dart';
import 'package:flow_builder/flow_builder.dart';

class FilterScreen extends StatelessWidget {
  static Page page() => const MaterialPage<void>(child: FilterScreen());

  const FilterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    context.read<FilterBloc>().add(FilterEmail(email: user.email!));
    return Scaffold(
      appBar: AppBar(
        title: Text("Filter",
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: FeedoColors.white)),
        backgroundColor: const Color(0xff1B1B1B),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: BlocBuilder<FilterBloc, FilterState>(
          builder: (context, state) {
            if (state is FilterInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is FilterLoaded) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ConditionRadioButton(condition: state.condition),
                  const Divider(),
                  DateRangePickerWidget(dateRange: state.dateTimeRange),
                  const Divider(),
                  Expanded(
                    child: BranchesCheckedBoxList(branches: state.branches),
                  ),
                  const Divider(),
                  FilterButton(
                    branches: state.branches,
                    condition: state.condition,
                    dateTimeRange: state.dateTimeRange,
                  ),
                ],
              );
            }
            return const Center(
              child: Text("SomeThing went Wrong"),
            );
          },
        ),
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final Condition condition;
  final List<Branch> branches;
  final DateTimeRange? dateTimeRange;
  const FilterButton(
      {Key? key,
      required this.condition,
      required this.branches,
      required this.dateTimeRange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: const Color(0xff1B1B1B),
      ),
      onPressed: dateTimeRange != null
          ? () {
              List<DateTime> days = [];
              for (int i = 0;
                  i <=
                      dateTimeRange!.end
                          .difference(dateTimeRange!.start)
                          .inDays;
                  i++) {
                days.add(dateTimeRange!.start.add(Duration(days: i)));
              }
              context.read<FeedbacksBloc>().add(FeedbacksFilter(
                    condition: condition,
                    branches: branches,
                    dateTime: days,
                  ));
              context.flow<String>().update((state) => AppRoutes.authenticate);
            }
          : () {
              context.read<FeedbacksBloc>().add(FeedbacksFilter(
                    condition: condition,
                    branches: branches,
                    dateTime: const [],
                  ));
              context.flow<String>().update((state) => AppRoutes.filterationComplete);
            },
      child: Text(
        "Filter",
        style:
            Theme.of(context).textTheme.button!.copyWith(color: Colors.white),
      ),
    );
  }
}
