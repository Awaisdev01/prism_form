import 'package:flutter/material.dart';
import 'package:prism_form/prism_form.dart';

/// Demo app for prism_form.
void main() => runApp(const DemoApp());

/// Root widget: a login form demonstrating the sealed submit status.
class DemoApp extends StatefulWidget {
  /// Creates the demo.
  const DemoApp({super.key});

  @override
  State<DemoApp> createState() => _DemoAppState();
}

class _DemoAppState extends State<DemoApp> {
  final _controller = PrismFormController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('prism_form demo')),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: PrismForm(
              controller: _controller,
              child: ListView(
                padding: const EdgeInsets.all(24),
                shrinkWrap: true,
                children: [
                  PrismTextField.email(name: 'email', label: 'Email'),
                  const SizedBox(height: 16),
                  PrismPasswordField(
                    common: PrismFieldCommon(
                      name: 'password',
                      label: 'Password',
                      validators: [
                        Validators.required(),
                        Validators.minLength(8),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  PrismCheckboxField(
                    common: const PrismFieldCommon(name: 'remember'),
                    title: 'Remember me',
                  ),
                  const SizedBox(height: 16),
                  ListenableBuilder(
                    listenable: _controller,
                    builder: (context, _) {
                      return FilledButton(
                        onPressed: _controller.status.isSubmitting
                            ? null
                            : () => _controller.submit((values) async {
                                await Future<void>.delayed(
                                  const Duration(seconds: 1),
                                );
                                if (values['email'] == 'taken@test.com') {
                                  throw const PrismSubmissionException(
                                    fieldErrors: {
                                      'email': 'Already registered',
                                    },
                                  );
                                }
                              }),
                        child: Text(switch (_controller.status) {
                          PrismFormSubmitting() => 'Signing in…',
                          PrismFormFailure(:final message) => 'Retry: $message',
                          _ => 'Sign in',
                        }),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
