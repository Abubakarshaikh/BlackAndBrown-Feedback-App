import 'package:customer_facing/app/models/app_route.dart';
import 'package:customer_facing/thank_you/bloc/thank_you_bloc.dart';
import 'package:feedo_ui/feedo_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/services.dart';

class ThankYouPage extends StatelessWidget {
  static Page page() => const MaterialPage<void>(child: ThankYouPage());

  const ThankYouPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
    context.read<ThankYouBloc>().add(ThankYouFirebaseAdded());
    _navigate(context);
    return Scaffold(
      backgroundColor: FeedoColors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(image: AssetImage('assets/logo.jpg')),
          Center(
            child: Text(
              "Thank you for your Feedback!",
              style: Theme.of(context).textTheme.headline2!.copyWith(
                  color: FeedoColors.white, fontWeight: FeedoFontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  _navigate(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 1800), () {
      return context
          .flow<String>()
          .update((state) => AppRoute.authenticatedComplete);
    });
  }
}
