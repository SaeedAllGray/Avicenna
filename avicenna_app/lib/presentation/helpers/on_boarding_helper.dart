import 'package:avicenna_app/infrastructure/data_sources/local/local_source.dart';
import 'package:avicenna_app/presentation/constants/api_constant.dart';
import 'package:avicenna_app/presentation/constants/colors.dart';
import 'package:avicenna_app/presentation/constants/fonts.dart';
import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnBoardingHelper {
  static List<GlobalKey> doctorKeys = [
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey()
  ];

  static List<TargetFocus> doctorTargets() {
    List<TargetFocus> targets = [];
    targets.addAll([
      TargetFocus(
        keyTarget: doctorKeys[0],
        alignSkip: Alignment.topRight,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                      AppLocalizations.of(context)!
                          .doctor_onboarding_1_describtion,
                      style: FontStyles.WHITE_MEDIUM_24),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.white),
                    onPressed: () {
                      doctorTutorial.next();
                    },
                    child: Text(
                      AppLocalizations.of(context)!.close,
                    ),
                  )
                ],
              );
            },
          ),
        ],
      ),
      TargetFocus(
        keyTarget: doctorKeys[1],
        alignSkip: Alignment.topRight,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                      AppLocalizations.of(context)!
                          .doctor_onboarding_2_describtion,
                      style: FontStyles.WHITE_MEDIUM_24),
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.white),
                      onPressed: () {
                        doctorTutorial.next();
                      },
                      child: Text(AppLocalizations.of(context)!.close))
                ],
              );
            },
          ),
        ],
      ),
      TargetFocus(
        keyTarget: doctorKeys[2],
        alignSkip: Alignment.topRight,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                      AppLocalizations.of(context)!
                          .doctor_onboarding_3_describtion,
                      style: FontStyles.WHITE_MEDIUM_24),
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.white),
                      onPressed: () {
                        doctorTutorial.next();
                      },
                      child: Text(AppLocalizations.of(context)!.close))
                ],
              );
            },
          ),
        ],
      ),
    ]);

    return targets;
  }

  static TutorialCoachMark doctorTutorial = TutorialCoachMark(
    targets: doctorTargets(), // List<TargetFocus>
    onFinish: () {
      LocalSource.getInstance().setIsAppLaunchedForTheFirstTime('true');
      ApiConstants.setIsTheFirstTimeAppLaunch();
    },
  );
  static List<GlobalKey> patientKeys = [
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey()
  ];

  static List<TargetFocus> patientTargets() {
    List<TargetFocus> targets = [];
    targets.addAll([
      TargetFocus(
        keyTarget: patientKeys[0],
        alignSkip: Alignment.topRight,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                      AppLocalizations.of(context)!
                          .patient_obboarding_1_description,
                      style: FontStyles.WHITE_MEDIUM_24),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.white),
                    onPressed: () {
                      patientTutorial.next();
                    },
                    child: Text(
                      AppLocalizations.of(context)!.close,
                    ),
                  )
                ],
              );
            },
          ),
        ],
      ),
      TargetFocus(
        keyTarget: patientKeys[1],
        alignSkip: Alignment.topRight,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                      AppLocalizations.of(context)!
                          .doctor_onboarding_1_describtion,
                      style: FontStyles.WHITE_MEDIUM_24),
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.white),
                      onPressed: () {
                        patientTutorial.next();
                      },
                      child: Text(AppLocalizations.of(context)!.close))
                ],
              );
            },
          ),
        ],
      ),
    ]);

    return targets;
  }

  static TutorialCoachMark patientTutorial = TutorialCoachMark(
    targets: patientTargets(), // List<TargetFocus>
    onFinish: () {
      LocalSource.getInstance().setIsAppLaunchedForTheFirstTime('true');
      ApiConstants.setIsTheFirstTimeAppLaunch();
    },
  );
}
