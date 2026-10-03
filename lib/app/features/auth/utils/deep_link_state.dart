/// Tracks whether a deep link has taken over navigation away from the splash
/// screen.
///
/// This is deliberately process-global, because the deep-link listener is
/// installed in `main()` while the splash screen lives inside the widget tree,
/// so the two cannot share a scoped handle.
///
/// The contract callers must uphold:
///
/// * Set [handled] only when a deep link actually routed somewhere. Splash
///   stands down when this is true, so a false positive strands the user on the
///   splash screen permanently — there is no retry and no timeout.
/// * Call [reset] whenever a fresh splash screen starts routing, so a link
///   handled earlier in the process cannot wedge every later splash.
class DeepLinkState {
  static bool handled = false;

  /// Clears the flag so the next splash screen routes normally.
  static void reset() => handled = false;
}
