import 'package:customer_facing/app/app.dart';
import 'package:customer_facing/app/models/app_route.dart';
import 'package:customer_facing/form/bloc/form_bloc.dart';
import 'package:customer_facing/thank_you/bloc/thank_you_bloc.dart';
import 'package:customer_facing/form/form.dart';
import 'package:customer_facing/title/view/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/services.dart';

class FormPage extends StatelessWidget {
  static Page page() => MaterialPage<void>(child: FormPage());

  FormPage({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    context.read<ThankYouBloc>().add(ThankYouUserEmailAdded(user.email!));
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
    return BlocConsumer<FormBloc, FormsState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is FormsStateLoaded) {
          return Scaffold(
            backgroundColor: const Color(0xff1B1B1B),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 24),
                        const Image(
                          height: 90,
                          image: AssetImage("assets/logo.jpg"),
                        ),
                        const SizedBox(height: 28),
                        InputField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Phone Number.';
                              }
                              return null;
                            },
                            icon: Icons.phone,
                            textInputType: TextInputType.number,
                            textHint: 'Enter Number',
                            changeOn: (newValue) => context
                                .read<FormBloc>()
                                .add(FormEventNumber(number: newValue))),
                        const SizedBox(height: 8),
                        InputField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Your Name.';
                              }
                              return null;
                            },
                            icon: Icons.person,
                            textInputType: TextInputType.name,
                            textHint: 'Enter Name',
                            changeOn: (newValue) => context
                                .read<FormBloc>()
                                .add(FormEventName(name: newValue))),
                        const SizedBox(height: 24),
                        CustomPrimaryButton(
                          onEvent: state.name != null && state.number != null
                              ? () {
                                  context
                                      .read<ThankYouBloc>()
                                      .add(ThankYouFormAdded(
                                        CustomerForm(
                                            name: state.name ?? '',
                                            number: state.number ?? ''),
                                      ));
                                  context
                                      .flow<String>()
                                      .update((state) => AppRoute.formComplete);
                                }
                              : () {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text("Please fill the form"),
                                  ));
                                },
                          textValue: 'Next',
                          theme: Theme.of(context),
                          buttonColor: const Color(0xffED1846),
                          textColor: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: Text("Something went wrong"),
            ),
          );
        }
      },
    );
  }
}
