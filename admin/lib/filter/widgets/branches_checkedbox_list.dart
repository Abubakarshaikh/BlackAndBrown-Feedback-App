import 'package:admin/filter/filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:feedo_repository/feedo_repository.dart';

class BranchesCheckedBoxList extends StatelessWidget {
  final List<Branch> branches;
  const BranchesCheckedBoxList({Key? key, required this.branches})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: branches.map((Branch _branch) {
        return BranchCheckedBox(
            branchName: _branch.branchName,
            onEvent: (bool? newValue) {
              context.read<FilterBloc>().add(FilterUpadateBranches(
                  updateBranch: _branch.copyWith(isChecked: newValue)));
            },
            isChecked: _branch.isChecked);
      }).toList(),
    );
  }
}

class BranchCheckedBox extends StatelessWidget {
  final String branchName;
  final bool isChecked;
  final Function(bool?) onEvent;
  const BranchCheckedBox(
      {Key? key,
      required this.branchName,
      required this.onEvent,
      required this.isChecked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 1.5,
      contentPadding: const EdgeInsets.only(right: 16.0),
      title: Text(branchName, style: Theme.of(context).textTheme.bodyText1),
      trailing: Checkbox(
        checkColor: Colors.white,
        fillColor: MaterialStateProperty.all(const Color(0xff1B1B1B)),
        side: const BorderSide(
          color: Color(0xff1B1B1B),
          width: 1.5,
        ),
        value: isChecked,
        onChanged: onEvent,
      ),
    );
  }
}
