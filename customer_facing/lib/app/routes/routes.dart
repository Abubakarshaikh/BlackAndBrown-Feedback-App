import 'package:customer_facing/app/models/app_route.dart';
import 'package:customer_facing/form/form.dart';
import 'package:customer_facing/thank_you/view/thank_you_page.dart';
import 'package:customer_facing/title/title.dart';
import 'package:flutter/widgets.dart';
import 'package:customer_facing/signin/signin.dart';

List<Page> onGenerateAppViewPages(String state, List<Page<dynamic>> pages) {
  switch (state) {
    case AppRoute.authenticatedComplete:
      return [
        FormPage.page(),
      ];
    case AppRoute.formComplete:
      return [
        FormPage.page(),
        TitlePage.page(),
      ];
    case AppRoute.titleComplete:
      return [
        TitlePage.page(),
        ThankYouPage.page(),
      ];
    case AppRoute.authenticated:
      return [
        // QuestionsPage.page(),
        FormPage.page(),
      ];
    case AppRoute.unauthenticated:
    default:
      return [LoginPage.page()];
  }
}
