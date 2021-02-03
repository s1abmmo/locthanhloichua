import 'package:flutter/material.dart';

// public class SimpleSplashScreen implements SplashScreen {
//   @Override
//   @Nullable
//   public View createSplashView(
//       @NonNull Context context,
//       @Nullable Bundle savedInstanceState
//       ) {
//     // Return a new MySplashView without saving a reference, because it
//     // has no state that needs to be tracked or controlled.
//     return new MySplashView(context);
//   }
//
//   @Override
//   public void transitionToFlutter(@NonNull Runnable onTransitionComplete) {
//     // Immediately invoke onTransitionComplete because this SplashScreen
//     // doesn't display a transition animation.
//     //
//     // Every SplashScreen *MUST* invoke onTransitionComplete at some point
//     // for the splash system to work correctly.
//     onTransitionComplete.run();
//   }
// }
//
// public class SplashScreenWithTransition implements SplashScreen {
//   private MySplashView mySplashView;
//
//   @Override
//   @Nullable
//   public View createSplashView(
//       @NonNull Context context,
//       @Nullable Bundle savedInstanceState
//       ) {
//     // A reference to the MySplashView is retained so that it can be told
//     // to transition away at the appropriate time.
//     mySplashView = new MySplashView(context);
//     return mySplashView;
//   }
//
//   @Override
//   public void transitionToFlutter(@NonNull Runnable onTransitionComplete) {
//     // Instruct MySplashView to animate away in whatever manner it wants.
//     // The onTransitionComplete Runnable is passed to the MySplashView
//     // to be invoked when the transition animation is complete.
//     mySplashView.animateAway(onTransitionComplete);
//   }
// }
