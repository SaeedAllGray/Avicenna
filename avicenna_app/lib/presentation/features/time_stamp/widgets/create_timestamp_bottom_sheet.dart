import 'dart:io';

import 'package:avicenna_app/application/time_slot/time_slot_bloc.dart';
import 'package:avicenna_app/domain/entries/time_slot/time_slot.dart';
import 'package:avicenna_app/presentation/constants/colors.dart';
import 'package:avicenna_app/presentation/constants/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class CreateTimeStampBottonSheet extends StatefulWidget {
  const CreateTimeStampBottonSheet({super.key});

  @override
  State<CreateTimeStampBottonSheet> createState() =>
      _CreateTimeStampBottonSheetState();
}

class _CreateTimeStampBottonSheetState
    extends State<CreateTimeStampBottonSheet> {
  DateTime selectedStartDateTime = DateTime.now();
  DateTime selectedEndDateTime = (DateTime.now()).add(const Duration(hours: 1));
  ExpansionTileController startDateExpansionTileController =
      ExpansionTileController();
  ExpansionTileController endDateExpansionTileController =
      ExpansionTileController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 700,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,

            // mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ExpansionTile(
                controller: startDateExpansionTileController,
                onExpansionChanged: (value) {
                  if (value) {
                    endDateExpansionTileController.collapse();
                    startDateExpansionTileController.expand();
                  }
                },
                shape: const RoundedRectangleBorder(),
                initiallyExpanded: true,
                trailing: Text(
                  DateFormat('MMMM d, hh:mm', Platform.localeName)
                      .format(selectedStartDateTime),
                  style: FontStyles.GRAY_MEDIUM_16,
                ),
                title: Text(
                  AppLocalizations.of(context)!.starts,
                  style: FontStyles.BLACK_MEDIUM_22,
                ),
                children: [
                  SizedBox(
                    height: 200,
                    child: CupertinoDatePicker(
                      minimumDate: DateTime.now(),
                      mode: CupertinoDatePickerMode.dateAndTime,
                      use24hFormat: true,
                      showDayOfWeek: true,
                      onDateTimeChanged: (DateTime newDate) {
                        setState(() {
                          selectedStartDateTime = newDate;
                          selectedEndDateTime =
                              newDate.add(const Duration(hours: 1));
                        });
                      },
                    ),
                  ),
                ],
              ),
              ExpansionTile(
                controller: endDateExpansionTileController,
                onExpansionChanged: (value) {
                  if (value) {
                    startDateExpansionTileController.collapse();
                    endDateExpansionTileController.expand();
                  }
                },
                shape: const RoundedRectangleBorder(),
                initiallyExpanded: false,
                trailing: Text(
                  DateFormat('MMMM d, hh:mm', Platform.localeName)
                      .format(selectedEndDateTime),
                  style: FontStyles.GRAY_MEDIUM_16,
                ),
                title: Text(
                  AppLocalizations.of(context)!.ends,
                  style: FontStyles.BLACK_MEDIUM_22,
                ),
                children: [
                  SizedBox(
                    height: 200,
                    child: CupertinoDatePicker(
                      initialDateTime: selectedEndDateTime,
                      minimumDate: selectedStartDateTime
                          .add(const Duration(minutes: 30)),
                      mode: CupertinoDatePickerMode.time,
                      use24hFormat: true,
                      showDayOfWeek: true,
                      onDateTimeChanged: (DateTime newDate) {
                        setState(() {
                          selectedEndDateTime = newDate;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary),
                child: Text(AppLocalizations.of(context)!.make_appointment),
                onPressed: () {
                  BlocProvider.of<TimeSlotBloc>(context).add(
                    CreateTimeSlot(
                      timeSlot: TimeSlot(
                        confirmed: false,
                        id: 1,
                        date: selectedStartDateTime,
                        start: selectedStartDateTime,
                        end: selectedEndDateTime,
                        patientId: 1,
                        doctorId: 1,
                      ),
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        AppLocalizations.of(context)!
                            .time_stamp_creation_confirmation,
                      ),
                    ),
                  );
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
              ),
              TextButton(
                child: Text(AppLocalizations.of(context)!.cancel),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
