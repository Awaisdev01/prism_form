# prism_form

Declarative forms for Flutter — typed fields, composable validators, sealed
submit states, inline errors, and a headless controller. Kill your form
boilerplate.

Part of the **Prism** package family.

## Features

- ✅ Declarative fields: text, email, password (with visibility toggle),
  dropdown, checkbox
- ✅ Composable validators: `required`, `email`, `minLength`, `maxLength`,
  `pattern`, `number` — combine freely with `Validators.all`
- ✅ **Sealed submit states** (`pristine / editing / submitting / success /
  failure`) — Dart 3 exhaustive switching means you can't forget a state
- ✅ Proper error timing: inline errors appear only after the field is
  blurred or a submit was attempted — never on first render
- ✅ Async `submit()` with automatic submitting/success/failure lifecycle
- ✅ Server-side rejection mapping: throw `PrismSubmissionException` with
  per-field errors and they appear inline
- ✅ Headless `PrismFormController` — reuse the same logic with custom UIs
- ✅ Pure Flutter, all six platforms, zero dependencies

## Installation

```yaml
dependencies:
  prism_form: ^0.1.0
```

## Quick start

```dart
final controller = PrismFormController();

PrismForm(
  controller: controller,
  child: Column(
    children: [
      PrismTextField.email(name: 'email', label: 'Email'),
      PrismPasswordField(
        common: PrismFieldCommon(
          name: 'password',
          label: 'Password',
          validators: [Validators.required(), Validators.minLength(8)],
        ),
      ),
      // Submit button reacts to the sealed status:
      ListenableBuilder(
        listenable: controller,
        builder: (context, _) => FilledButton(
          onPressed: controller.status.isSubmitting
              ? null
              : () => controller.submit(api.login),
          child: switch (controller.status) {
            PrismFormSubmitting() => const CircularProgressIndicator(),
            _ => const Text('Sign in'),
          },
        ),
      ),
    ],
  ),
)
```

## Server-side errors

Throw `PrismSubmissionException` from your submit handler; field errors
surface inline, the message becomes the form-level failure:

```dart
controller.submit((values) async {
  final result = await api.register(values);
  if (result.emailTaken) {
    throw const PrismSubmissionException(
      fieldErrors: {'email': 'Already registered'},
      message: 'Check the highlighted fields',
    );
  }
});
```

## Validation

```dart
PrismTextField(
  common: PrismFieldCommon(
    name: 'username',
    label: 'Username',
    validators: [
      Validators.required(),
      Validators.minLength(3),
      Validators.pattern(RegExp(r'^[a-z0-9_]+$'), 'Lowercase letters, digits, _ only'),
    ],
  ),
)
```

## The Prism package family

| Package | What it does |
| --- | --- |
| [prism_markdown](https://pub.dev/packages/prism_markdown) | Markdown widget with full CommonMark + GFM support |
| [prism_code_view](https://pub.dev/packages/prism_code_view) | Syntax-highlighted code viewer (Dart/JSON/YAML built in) |
| [prism_adaptive_scaffold](https://pub.dev/packages/prism_adaptive_scaffold) | Responsive scaffolds: bottom bar → rail → extended rail |
| [prism_adaptive_dialog](https://pub.dev/packages/prism_adaptive_dialog) | Dialogs that become bottom sheets on phones |
| [prism_state_views](https://pub.dev/packages/prism_state_views) | Empty, loading, error, and success states from one widget |
| [prism_master_detail](https://pub.dev/packages/prism_master_detail) | Adaptive master-detail layouts |
| [prism_banner](https://pub.dev/packages/prism_banner) | Dismissible announcement banners |
| [prism_search](https://pub.dev/packages/prism_search) | Adaptive search with suggestions |
| [prism_toast](https://pub.dev/packages/prism_toast) | Adaptive toast notifications |
| [prism_pagination](https://pub.dev/packages/prism_pagination) | Infinite-scroll lists with all states handled |
| **prism_form** | Declarative forms with sealed submit states |

All pure Flutter, all six platforms, MIT licensed, built to work together.

## License

MIT — see [LICENSE](LICENSE).
