import 'package:admin/app/models/app_routes.dart';
import 'package:admin/feedbacks/feedbacks.dart';
import 'package:admin/filter/filter.dart';
import 'package:flutter/widgets.dart';
import 'package:admin/signin/signin.dart';

List<Page> onGenerateAppViewPages(String state, List<Page<dynamic>> pages) {
  switch (state) {
    case AppRoutes.authenticateComplete:
      return [
        FeedbacksPage.page(),
        FilterScreen.page(),
      ];
    case AppRoutes.filterationComplete:
      return [
        FeedbacksPage.page(),
      ];
    case AppRoutes.authenticate:
      return [FeedbacksPage.page()];
    case AppRoutes.unauthenticate:
    default:
      return [LoginPage.page()];
  }
}
