# HostelTrack — Team 6 Hostel Expense Tracker

A Flutter app concept for recording hostel-related costs such as rent, mess fees, laundry, electricity, maintenance, fines and personal purchases.

## Included features
- Dashboard with this-month and all-time spending totals.
- Add expense form with title, amount validation, category, date, paid-to field and note.
- Expense detail view with delete confirmation.
- Summary screen with category-wise totals.
- Provider (`ChangeNotifier`) shared state.
- SharedPreferences local persistence; no internet is required for saved records.
- Loading, empty and basic error/retry states.

## Project structure
- `lib/models` — expense data model
- `lib/services` — local storage
- `lib/providers` — shared app state
- `lib/screens` — dashboard, add, detail and summary screens
- `lib/widgets` — reusable expense tile
- `test` — starter widget test

## Run locally
1. Install Flutter stable and Android Studio with Android SDK tools.
2. Open this folder in Android Studio or a terminal.
3. Run `flutter pub get`.
4. Run `flutter analyze`.
5. Run `flutter test`.
6. Connect an Android phone with USB debugging enabled and run `flutter run`.
7. Create a release APK with `flutter build apk --release`.

## Team responsibilities (assign and update)
- Member 1: dashboard and expense history.
- Member 2: add-expense form and validation.
- Member 3: detail screen, summary screen and testing/documentation.

Each member must make genuine commits for their own contribution and understand the code they present.

## Before submission
- This is an initial source package. It has **not yet been verified by a Flutter build or physical-device test**.
- Run all commands above and fix any errors before calling it working.
- Add at least 3 real screenshots to this README.
- Add the final APK to the repository or provide the required submission link.
- Record actual defects found and their fixes in a defect log.
- Verify the app on a physical Android phone and prepare the required demo.
- Update member names and actual responsibilities; do not claim work that was not done.

## Notes
All data is stored locally on the device using SharedPreferences. Uninstalling the app or clearing its data may remove these records. Category totals include all saved dates; the monthly total uses the current calendar month.
