#!/usr/bin/env python3
"""Remove dev-only plugin registrations from the generated Android registrant.

Why this exists
---------------
`flutter pub get` writes
`android/app/src/main/java/io/flutter/plugins/GeneratedPluginRegistrant.java`
with an entry for every resolved plugin, *including* `dev_dependencies` such as
`patrol` and `integration_test`. Those two have no native code in a release
build, so Gradle then fails the release compile with:

    error: package dev.flutter.plugins.integration_test does not exist
    error: package pl.leancode.patrol does not exist

`.flutter-plugins-dependencies` does mark them `dev_dependency: true`, but the
registrant written into the source tree is not filtered, and the Gradle task
compiles that file as-is. The file is generated and gitignored, so the bad state
survives across builds and only shows up when you next build a release bundle.

This strips the offending `try { ... } catch (Exception e) { ... }` blocks (and
any matching imports) so the release build compiles. Safe to run repeatedly: if
there is nothing to strip, it is a no-op.

Run automatically by android/deploy_internal_minor.sh before the release build.
"""

import pathlib
import re
import sys

DEV_PLUGINS = ("integration_test", "patrol")

RELATIVE_PATH = pathlib.Path(
    "android/app/src/main/java/io/flutter/plugins/GeneratedPluginRegistrant.java"
)

# A plugin registration block looks like:
#     try {
#       flutterEngine.getPlugins().add(new some.Plugin());
#     } catch (Exception e) {
#       Log.e(TAG, "...", e);
#     }
REGISTRATION_BLOCK = re.compile(
    r"[ \t]*try \{\s*\n"
    r"(?:(?![ \t]*\}).*\n)*?"
    r"[ \t]*flutterEngine\.getPlugins\(\)\.add\(new [^\n]*\);\s*\n"
    r"[ \t]*\} catch \(Exception e\) \{\s*\n"
    r"(?:(?![ \t]*\}).*\n)*?"
    r"[ \t]*\}\s*\n"
)


def main() -> int:
    root = pathlib.Path(__file__).resolve().parent.parent
    path = root / RELATIVE_PATH

    if not path.exists():
        # Nothing generated yet; the build will produce a clean file.
        return 0

    original = path.read_text()

    pieces = []
    cursor = 0
    removed = 0
    for match in REGISTRATION_BLOCK.finditer(original):
        text = match.group(0)
        pieces.append(original[cursor : match.start()])
        if any(plugin in text for plugin in DEV_PLUGINS):
            removed += 1
        else:
            pieces.append(text)
        cursor = match.end()
    pieces.append(original[cursor:])
    result = "".join(pieces)

    for plugin in DEV_PLUGINS:
        result = re.sub(
            rf"^import [^\n]*{plugin}[^\n]*\n", "", result, flags=re.MULTILINE
        )

    if result == original:
        print("strip_dev_plugins: nothing to strip")
        return 0

    if result.count("{") != result.count("}"):
        print("strip_dev_plugins: refusing to write, braces unbalanced")
        return 1

    path.write_text(result)
    print(
        f"strip_dev_plugins: removed {removed} dev-only plugin registration(s) "
        f"from {RELATIVE_PATH}"
    )
    return 0


if __name__ == "__main__":
    sys.exit(main())