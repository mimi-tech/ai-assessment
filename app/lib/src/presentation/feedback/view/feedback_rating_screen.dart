import 'package:ai_assessment/l10n/l10n.dart';
import 'package:ai_assessment/src/presentation/feedback/bloc/feedback_rating_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A feedback rating screen with a 5-star rating system
/// and dynamic emoji that changes based on the selected rating.
class FeedbackRatingScreen extends StatelessWidget {
  const FeedbackRatingScreen({super.key, this.feedbackRatingBloc});

  final FeedbackRatingBloc? feedbackRatingBloc;

  @override
  Widget build(BuildContext context) {
    final bloc = feedbackRatingBloc ?? FeedbackRatingBloc();
    return BlocProvider.value(value: bloc, child: const _FeedbackRatingView());
  }
}

class _FeedbackRatingView extends StatelessWidget {
  const _FeedbackRatingView();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: Text(
          l10n.feedbackTitle,
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<FeedbackRatingBloc, FeedbackRatingState>(
        listener: (context, state) {
          if (state.uiState == FeedbackUiState.submitted) {
            _showSuccessDialog(context, l10n);
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              // Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 24,
                  ),
                  child: Column(
                    children: [
                      // Heading section
                      Text(
                        l10n.feedbackHeadingPrincipal,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l10n.feedbackSubheading,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black45,
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: 36),

                      // Emoji section (centered)
                      Center(child: _AnimatedEmoji(rating: state.rating)),

                      const SizedBox(height: 16),

                      // Rating label (centered)
                      Center(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 250),
                          child: Column(
                            key: ValueKey(state.rating),
                            children: [
                              Text(
                                _ratingLabel(state.rating, l10n),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black87,
                                ),
                              ),
                              if (state.rating > 0) ...[
                                const SizedBox(height: 4),
                                Text(
                                  l10n.feedbackStarCount(state.rating),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black45,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 28),

                      // Star rating row (centered)
                      Center(
                        child: _StarRatingRow(
                          rating: state.rating,
                          onRatingChanged: (rating) {
                            context.read<FeedbackRatingBloc>().add(
                              FeedbackRatingChanged(rating: rating),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 36),

                      // Comment field with label
                      _CommentField(
                        l10n: l10n,
                        onChanged: (comment) {
                          context.read<FeedbackRatingBloc>().add(
                            FeedbackCommentChanged(comment: comment),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom pinned button
              _SubmitButton(
                l10n: l10n,
                isEnabled:
                    state.rating > 0 &&
                    state.uiState != FeedbackUiState.submitting,
                isLoading: state.uiState == FeedbackUiState.submitting,
                onPressed: () {
                  context.read<FeedbackRatingBloc>().add(
                    const FeedbackSubmitted(),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  String _ratingLabel(int rating, AppLocalizations l10n) {
    return switch (rating) {
      1 => l10n.feedbackRatingTerrible,
      2 => l10n.feedbackRatingBad,
      3 => l10n.feedbackRatingOkay,
      4 => l10n.feedbackRatingGood,
      5 => l10n.feedbackRatingExcellent,
      _ => l10n.feedbackRatingPlaceholder,
    };
  }

  void _showSuccessDialog(BuildContext context, AppLocalizations l10n) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        icon: const Icon(
          Icons.check_circle_rounded,
          color: Color(0xFF2196F3),
          size: 48,
        ),
        title: Text(l10n.feedbackSuccessTitle),
        content: Text(l10n.feedbackSuccessMessage),
        actions: [
          FilledButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFF2196F3),
            ),
            child: Text(l10n.commonDone),
          ),
        ],
      ),
    );
  }
}

// -------------------------------------------------------------------
// Animated emoji widget
// -------------------------------------------------------------------
class _AnimatedEmoji extends StatelessWidget {
  const _AnimatedEmoji({required this.rating});

  final int rating;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      switchInCurve: Curves.easeOutBack,
      switchOutCurve: Curves.easeIn,
      transitionBuilder: (child, animation) {
        return ScaleTransition(scale: animation, child: child);
      },
      child: Container(
        key: ValueKey(rating),
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFF2196F3).withValues(alpha: 0.08),
        ),
        alignment: Alignment.center,
        child: Text(
          _emojiForRating(rating),
          style: const TextStyle(fontSize: 64),
        ),
      ),
    );
  }

  String _emojiForRating(int rating) {
    return switch (rating) {
      1 => '😡',
      2 => '😞',
      3 => '😐',
      4 => '😊',
      5 => '🤩',
      _ => '🤔',
    };
  }
}

// -------------------------------------------------------------------
// Star rating row
// -------------------------------------------------------------------
class _StarRatingRow extends StatelessWidget {
  const _StarRatingRow({required this.rating, required this.onRatingChanged});

  final int rating;
  final ValueChanged<int> onRatingChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        final starIndex = index + 1;
        final isSelected = starIndex <= rating;

        return GestureDetector(
          onTap: () => onRatingChanged(starIndex),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: AnimatedScale(
              scale: isSelected ? 1.15 : 1.0,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOutBack,
              child: Icon(
                isSelected ? Icons.star_rounded : Icons.star_outline_rounded,
                size: 48,
                color: isSelected
                    ? const Color(0xFF2196F3)
                    : const Color(0xFFBDBDBD),
              ),
            ),
          ),
        );
      }),
    );
  }
}

// -------------------------------------------------------------------
// Comment text field with label
// -------------------------------------------------------------------
class _CommentField extends StatelessWidget {
  const _CommentField({required this.l10n, required this.onChanged});

  final AppLocalizations l10n;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.feedbackCommentLabel,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          onChanged: onChanged,
          maxLines: 5,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            hintText: l10n.feedbackCommentHint,
            hintStyle: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 14,
              height: 1.5,
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.all(16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFF2196F3),
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// -------------------------------------------------------------------
// Pinned submit button at bottom
// -------------------------------------------------------------------
class _SubmitButton extends StatelessWidget {
  const _SubmitButton({
    required this.l10n,
    required this.isEnabled,
    required this.isLoading,
    required this.onPressed,
  });

  final AppLocalizations l10n;
  final bool isEnabled;
  final bool isLoading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Divider(height: 1, thickness: 1, color: Colors.grey.shade200),
        SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: isEnabled ? onPressed : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2196F3),
                  disabledBackgroundColor: const Color(
                    0xFF2196F3,
                  ).withValues(alpha: 0.4),
                  foregroundColor: Colors.white,
                  disabledForegroundColor: Colors.white.withValues(alpha: 0.7),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                child: isLoading
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: Colors.white,
                        ),
                      )
                    : Text(l10n.feedbackSubmit),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
