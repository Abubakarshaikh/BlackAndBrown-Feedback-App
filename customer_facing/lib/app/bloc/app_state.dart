part of 'app_bloc.dart';
class AppState extends Equatable {
  const AppState._({
    required this.status,
    this.user = User.empty,
  });

  const AppState.authenticated(User user)
      : this._(status: AppRoute.authenticated, user: user);

  const AppState.unauthenticated() : this._(status: AppRoute.unauthenticated);

  final String status;
  final User user;

  @override
  List<Object> get props => [status, user];
}