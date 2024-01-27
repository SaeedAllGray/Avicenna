import 'package:avicenna_app/application/feedback/feedback_bloc.dart';
import 'package:avicenna_app/domain/entries/doctor/doctor.dart';
import 'package:avicenna_app/domain/entries/feedback/feedback.dart' as feedback;

import 'package:avicenna_app/presentation/constants/colors.dart';
import 'package:avicenna_app/presentation/constants/fonts.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingBottomSheet extends StatefulWidget {
  final Doctor doctor;
  const RatingBottomSheet({super.key, required this.doctor});

  @override
  State<RatingBottomSheet> createState() => _RatingBottomSheetState();
}

class _RatingBottomSheetState extends State<RatingBottomSheet> {
  final TextEditingController messageTextEditingController =
      TextEditingController();
  int stars = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => FeedbackBloc(),
        child: BlocListener<FeedbackBloc, FeedbackState>(
          listener: (context, state) {
            if (state is FeedBackCreated) {
              Navigator.pop(context);
            }
          },
          child: BlocBuilder<FeedbackBloc, FeedbackState>(
            builder: (context, state) {
              return SizedBox(
                height: 800,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        '${AppLocalizations.of(context)!.rate} ${widget.doctor.user.firstName} ${widget.doctor.user.lastName}',
                        style: FontStyles.BLACK_BOLD_24,
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(AppLocalizations.of(context)!.rate),
                        trailing: RatingBar.builder(
                          itemSize: 35,
                          initialRating: 0,
                          direction: Axis.horizontal,
                          itemCount: 5,
                          // itemPadding:
                          //     EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star_rounded,
                            color: AppColors.primary,
                          ),
                          onRatingUpdate: (rating) {
                            setState(() {
                              stars = rating.toInt();
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: messageTextEditingController,
                          minLines: 5,
                          maxLines: 7,
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.message,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: AppColors.primaryPale,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: AppColors.primaryPale,
                              ),
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary),
                        onPressed: () {
                          BlocProvider.of<FeedbackBloc>(context).add(
                            LeaveFeedBack(
                              feedback: feedback.Feedback(
                                rating: stars,
                                doctorId: widget.doctor.user.id,
                                comment: messageTextEditingController.text,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          AppLocalizations.of(context)!.submit,
                        ),
                      ),
                      TextButton(
                        style: ElevatedButton.styleFrom(
                            foregroundColor: AppColors.primary),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.cancel,
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
