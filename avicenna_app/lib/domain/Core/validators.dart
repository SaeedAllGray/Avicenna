import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Validators {
  final RegExp _firstNameRegExp = RegExp(r'^[a-zA-Z]+(?:[\s-][a-zA-Z]+)*$');
  final RegExp _lastNameRegExp = RegExp(r'^[a-zA-Z]+(?:[\s-][a-zA-Z]+)*$');
  final RegExp _usernameRegExp = RegExp(r'^[a-zA-Z0-9_]+$');
  final RegExp _passwordRegExp = RegExp(r'^.{8}$');
  final RegExp _ssnRegExp = RegExp(r'^\d{8}$');
  final RegExp _phoneNumberRegExp = RegExp(r'^\d{10}$');
  final RegExp _addressRegExp = RegExp(r'^[a-zA-Z0-9\s,.-]+$');
  final RegExp _emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
  final RegExp _dateRegExp = RegExp(
      r'^(19\d{2}|20[0-1]\d|202[0-4])-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01])$');

  String? validateFirstname(BuildContext context, String? value) {
    if (value != null && !_firstNameRegExp.hasMatch(value)) {
      return AppLocalizations.of(context)!.error;
    }
    return null;
  }

  String? validatePhoneNumber(BuildContext context, String? value) {
    if (value != null && !_phoneNumberRegExp.hasMatch(value)) {
      return AppLocalizations.of(context)!.error;
    }
    return null;
  }

  String? validateLastname(BuildContext context, String? value) {
    if (value != null && !_lastNameRegExp.hasMatch(value)) {
      return AppLocalizations.of(context)!.error;
    }
    return null;
  }

  String? validatePassword(BuildContext context, String? value) {
    if (value != null && !_passwordRegExp.hasMatch(value)) {
      return AppLocalizations.of(context)!.error;
    }
    return null;
  }

  String? validateAddress(BuildContext context, String? value) {
    if (value != null && !_addressRegExp.hasMatch(value)) {
      return AppLocalizations.of(context)!.error;
    }
    return null;
  }

  String? validateEmail(BuildContext context, String? value) {
    if (value != null && !_emailRegExp.hasMatch(value)) {
      return AppLocalizations.of(context)!.error;
    }
    return null;
  }

  String? validateDate(BuildContext context, String? value) {
    if (value != null && !_dateRegExp.hasMatch(value)) {
      return AppLocalizations.of(context)!.error;
    }
    return null;
  }

  String? validateUsername(BuildContext context, String? value) {
    if (value != null && !_usernameRegExp.hasMatch(value)) {
      return AppLocalizations.of(context)!.error;
    }
    return null;
  }

  String? validateSSN(BuildContext context, String? value) {
    if (value != null && !_ssnRegExp.hasMatch(value)) {
      return AppLocalizations.of(context)!.error;
    }
    return null;
  }
}
