part of 'app_bloc.dart';

class AppState extends Equatable {
  const AppState._({
    required this.status,
    this.user = User.empty,
  });

  const AppState.authenticated(User user)
      : this._(status: AppRoutes.authenticate, user: user);

  const AppState.unauthenticated() : this._(status: AppRoutes.unauthenticate);

  final String status;
  final User user;

  @override
  List<Object> get props => [status, user];
}
