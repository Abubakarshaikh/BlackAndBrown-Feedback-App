import 'package:equatable/equatable.dart';

class Branch extends Equatable {
  final String branchName;
  final bool isChecked;
  const Branch({required this.branchName, required this.isChecked});
  @override
  List<Object?> get props => [branchName, isChecked];

  Branch copyWith({
    String? branchName,
    bool? isChecked,
  }) {
    return Branch(
      branchName: branchName ?? this.branchName,
      isChecked: isChecked ?? this.isChecked,
    );
  }
}
