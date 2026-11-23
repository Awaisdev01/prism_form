# Changelog

## 0.1.0

- Initial release.
- `PrismForm` + `PrismFormScope` — declarative container with inherited
  controller.
- `PrismFormController` — headless state: values, validators, touched
  tracking, sealed `PrismFormStatus` lifecycle, async `submit()` with
  `PrismSubmissionException` field-error mapping, and `reset()`.
- Fields: `PrismTextField` (+ `.email` factory), `PrismPasswordField`,
  `PrismDropdownField`, `PrismCheckboxField`.
- `Validators`: required, email, minLength, maxLength, pattern, number, and
  composable `all`.
