import 'package:flutter/material.dart';
import 'package:pend_tech/library/intro_views_flutter-2.4.0/lib/Constants/constants.dart';
import 'package:pend_tech/library/intro_views_flutter-2.4.0/lib/Models/page_button_view_model.dart';


/// Skip, Next, and Back button class

class DefaultButton extends StatelessWidget {
  //callback for skip button
  final VoidCallback onTap;

  //view model
  final PageButtonViewModel pageButtonViewModel;
  final Widget child;

  //Constructor
  DefaultButton({
    required this.onTap,
    required this.pageButtonViewModel,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    //Calculating opacity to create a fade in effect
    double opacity = 1.0;
    final TextStyle style = DefaultTextStyle.of(context).style;
    if (pageButtonViewModel.activePageIndex ==
            pageButtonViewModel.totalPages - 2 &&
        pageButtonViewModel.slideDirection == SlideDirection.rightToLeft) {
      opacity = 1.0 - pageButtonViewModel.slidePercent;
    } else if (pageButtonViewModel.activePageIndex ==
            pageButtonViewModel.totalPages - 1 &&
        pageButtonViewModel.slideDirection == SlideDirection.leftToRight) {
      opacity = pageButtonViewModel.slidePercent;
    }

    return FlatButton(
      onPressed: onTap,
      child: Opacity(
        opacity: opacity,
        child: DefaultTextStyle.merge(
          style: style,
          child: child,
        ), //Text
      ), //Opacity
    ); //FlatButton
  }
}

/// Done Button class

class DoneButton extends StatelessWidget {
  //Callback
  final VoidCallback onTap;

  //View Model
  final PageButtonViewModel pageButtonViewModel;
  final Widget child;

  //Constructor
  DoneButton({
    required this.onTap,
    required this.pageButtonViewModel,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    //Calculating opacity so as to create a fade in effect
    double opacity = 1.0;
    final TextStyle style = DefaultTextStyle.of(context).style;
    if (pageButtonViewModel.activePageIndex ==
            pageButtonViewModel.totalPages - 1 &&
        pageButtonViewModel.slideDirection == SlideDirection.leftToRight) {
      opacity = 1.0 - pageButtonViewModel.slidePercent;
    }

    return FlatButton(
      onPressed: onTap,
      child: Opacity(
        opacity: opacity,
        child: DefaultTextStyle.merge(
          style: style,
          child: child, //Text
        ),
      ), //Opacity
    ); //FlatButton
  }
}

class PageIndicatorButtons extends StatelessWidget {
  //Some variables
  final int activePageIndex;
  final int totalPages;
  final VoidCallback onPressedDoneButton; //Callback for Done Button
  final VoidCallback onPressedNextButton;
  final VoidCallback onPressedBackButton;
  final VoidCallback onPressedSkipButton; //Callback for Skip Button
  final SlideDirection slideDirection;
  final double slidePercent;
  final bool showSkipButton;
  final bool showNextButton;
  final bool showBackButton;

  final Widget doneText;
  final Widget skipText;
  final Widget nextText;
  final Widget backText;
  final TextStyle textStyle;

  final bool doneButtonPersist;

  Widget _getDoneORNextButton() {
    if ((activePageIndex < totalPages - 1 ||
            (activePageIndex == totalPages - 1 &&
                slideDirection == SlideDirection.leftToRight)) &&
        showNextButton) {
      return DefaultButton(
        child: nextText,
        onTap: onPressedNextButton,
        pageButtonViewModel: PageButtonViewModel(
          //View Model
          activePageIndex: activePageIndex,
          totalPages: totalPages,
          slidePercent: slidePercent,
          slideDirection: slideDirection,
        ),
      );
    } else if (activePageIndex == totalPages - 1 ||
        (activePageIndex == totalPages - 2 &&
                slideDirection == SlideDirection.rightToLeft ||
            doneButtonPersist)) {
      return DoneButton(
        child: doneText,
        onTap: onPressedDoneButton,
        pageButtonViewModel: PageButtonViewModel(
          //view Model
          activePageIndex: activePageIndex,
          totalPages: totalPages,
          slidePercent: doneButtonPersist ? 0.0 : slidePercent,
          slideDirection: slideDirection,
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _getSkipORBackButton() {
    if (activePageIndex <= totalPages &&
        activePageIndex >= 1 &&
        showBackButton) {
      return DefaultButton(
        child: backText,
        onTap: onPressedBackButton,
        pageButtonViewModel: PageButtonViewModel(
          //View Model
          activePageIndex: activePageIndex,
          totalPages: totalPages,
          slidePercent: slidePercent,
          slideDirection: slideDirection,
        ),
      );
    } else if ((activePageIndex < totalPages - 1 ||
            (activePageIndex == totalPages - 1 &&
                slideDirection == SlideDirection.leftToRight)) &&
        showSkipButton) {
      return DefaultButton(
        child: skipText,
        onTap: onPressedSkipButton,
        pageButtonViewModel: PageButtonViewModel(
          //View Model
          activePageIndex: activePageIndex,
          totalPages: totalPages,
          slidePercent: slidePercent,
          slideDirection: slideDirection,
        ),
      );
    } else {
      return Container();
    }
  }

  //Constructor
  PageIndicatorButtons(
      {required this.activePageIndex,
      required this.totalPages,
        required this.onPressedDoneButton,
        required this.slideDirection,
        required this.slidePercent,
        required  this.onPressedSkipButton,
        required  this.onPressedNextButton,
        required  this.onPressedBackButton,
        required  this.showSkipButton,
        required  this.skipText,
        required  this.nextText,
        required   this.doneText,
        required    this.textStyle,
        required   this.doneButtonPersist,
      this.showNextButton = true,
      this.showBackButton = true,
        required    this.backText});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0.0,
      right: 0.0,
      bottom: 0.0,
      child: DefaultTextStyle(
        style: textStyle,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: _getSkipORBackButton() //Row
                ), //Padding
            Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: _getDoneORNextButton() //Row
                )
          ],
        ),
      ),
    );
  }
}
