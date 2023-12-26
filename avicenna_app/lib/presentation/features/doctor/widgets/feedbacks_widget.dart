import 'package:avicenna_app/application/feedback/feedback_bloc.dart';
import 'package:avicenna_app/domain/entries/doctor/doctor.dart';
import 'package:avicenna_app/presentation/constants/colors.dart';
import 'package:avicenna_app/presentation/constants/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FeedbacksWidget extends StatelessWidget {
  final Doctor doctor;
  const FeedbacksWidget({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) =>
            FeedbackBloc()..add(GetFeedBacks(doctorId: doctor.id)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              AppLocalizations.of(context)!.feedbacks,
              style: FontStyles.BLACK_BOLD_18,
            ),
            BlocBuilder<FeedbackBloc, FeedbackState>(
              builder: (context, state) {
                if (state is FeedBacksFetched) {
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: state.feedbacks
                          .map((e) => ListTile(
                                titleAlignment: ListTileTitleAlignment.top,
                                title: e.comment != null
                                    ? Text(
                                        e.comment!,
                                        style: FontStyles.BLACK_REGULAR_16,
                                      )
                                    : const Text('-'),
                                leading: const CircleAvatar(
                                    child: Icon(Icons.account_circle_rounded)),
                                subtitle: RatingBar.builder(
                                  itemSize: 20,
                                  ignoreGestures: true,
                                  initialRating: e.rating.toDouble(),
                                  direction: Axis.horizontal,
                                  itemCount: 5,
                                  // itemPadding:
                                  //     EdgeInsets.symmetric(horizontal: 4.0),
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star_rounded,
                                    color: AppColors.primary,
                                  ),
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  },
                                ),
                              ))
                          .toList(),
                    ),
                  );
                }
                return const CircularProgressIndicator.adaptive();
              },
            )
          ],
        ),
      ),
    );
  }
}
