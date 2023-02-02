import 'package:flutter/material.dart';
import 'dart:math' as math;

const double _trackHeight = 40;
const double _borderWidth = 2;

class CustomSlider extends StatelessWidget {
  final double value;
  final int? divisions;
  final Color trackColor;
  final Color borderColor;
  final ValueChanged<double>? onChanged;

  const CustomSlider({
    Key? key,
    required this.value,
    required this.trackColor,
    required this.borderColor,
    this.divisions,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: _CustomSliderThemeData(
        trackColor: trackColor,
        trackHeight: _trackHeight,
        trackShape: _CustomSliderTrackShape(strokeColor: borderColor),
        thumbShape: _CustomSliderThumb(
          color: Theme.of(context).scaffoldBackgroundColor,
          radius: _trackHeight / 2 * (4 / 3),
          strokeColor: borderColor,
          strokeWidth: _borderWidth,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: _trackHeight / 2),
        child: Slider(
          value: value,
          divisions: divisions,
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class _CustomSliderThemeData extends SliderThemeData {
  _CustomSliderThemeData({
    double? trackHeight,
    Color? trackColor,
    SliderComponentShape? thumbShape,
    SliderTrackShape? trackShape,
  }) : super(
          trackHeight: trackHeight,
          activeTrackColor: trackColor,
          activeTickMarkColor: Colors.transparent,
          inactiveTickMarkColor: Colors.transparent,
          overlayShape: SliderComponentShape.noOverlay,
          thumbShape: thumbShape,
          trackShape: trackShape,
        );
}

/// Base track shape that provides an implementation of [getPreferredRect] for
/// default sizing.
///
/// The height is set from [SliderThemeData.trackHeight] and the width of the
/// parent box.
mixin _BaseSliderTrackShape {
  /// Returns a rect that represents the track bounds that fits within the
  /// [CustomSlider].
  ///
  /// The width is the width of the [CustomSlider]. The height is defined by the
  /// [SliderThemeData.trackHeight].
  ///
  /// The [Rect] is centered both horizontally and vertically within the slider
  /// bounds.
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight!;

    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackRight = trackLeft + parentBox.size.width;
    final double trackBottom = trackTop + trackHeight;

    // If the parentBox's size is less than the slider's size, trackRight will
    // be less than trackLeft, so switch them.
    return Rect.fromLTRB(
      math.min(trackLeft, trackRight),
      trackTop,
      math.max(trackLeft, trackRight),
      trackBottom,
    );
  }
}

class _CustomSliderTrackShape extends SliderTrackShape
    with _BaseSliderTrackShape {
  final Color strokeColor;

  const _CustomSliderTrackShape({required this.strokeColor});

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required Offset thumbCenter,
    Offset? secondaryOffset,
    bool isEnabled = false,
    bool isDiscrete = false,
    required TextDirection textDirection,
  }) {
    Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    // Expand the track's width by the radius of the thumb to ensure that the
    // thumb never overflows the end of the track.
    // Because the slider's underlying logic isn't aware of this, we have to add
    // this amount of padding around the custom slider while building it.
    const thumbRadius = _trackHeight / 2;
    trackRect = Rect.fromLTRB(
      trackRect.left - thumbRadius,
      trackRect.top,
      trackRect.right + thumbRadius,
      trackRect.bottom,
    );

    final Radius trackRadius = Radius.circular(trackRect.height / 2);
    final Paint trackPaint = Paint()..color = sliderTheme.activeTrackColor!;
    final Paint strokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = _borderWidth
      ..color = strokeColor;

    context.canvas.drawRRect(
      RRect.fromRectAndRadius(trackRect, trackRadius),
      trackPaint,
    );
    context.canvas.drawRRect(
      RRect.fromRectAndRadius(trackRect.deflate(_borderWidth / 2), trackRadius),
      strokePaint,
    );
  }
}

class _CustomSliderThumb extends SliderComponentShape {
  final double radius;
  final Color color;
  final Color strokeColor;
  final double strokeWidth;

  const _CustomSliderThumb({
    required this.radius,
    required this.color,
    required this.strokeColor,
    required this.strokeWidth,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) =>
      Size.square(radius * 2);

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final backgroundPaint = Paint()..color = color;
    final strokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = strokeColor;

    // The stroke is drawn centered directly on the radius of the
    // defined circle, with half of its width lying on either side of the
    // circle's circumference. Subtract half the stroke's width from the
    // circle's radius to ensure that the sum of the circle's radius and the
    // width of the stroke lying outside the circumference is equal to the
    // passed radius.
    context.canvas
        .drawCircle(center, radius - strokeWidth / 2, backgroundPaint);
    context.canvas.drawCircle(center, radius - strokeWidth / 2, strokePaint);
  }
}
