---
title: "Download archive"
---

Downloads that are no longer part of the main [download](/download/) page.

## Universal Windows Platform

Binary releases built to target the Universal Windows Platform (UWP). Used for
shipping apps on the Windows Store, such as for an Xbox, HoloLens 2, etc.

* UWP Universal (ARM64, X86, X86_64) (VS 2019, Release CRT) (ancient stable)
  - [1.20.7 runtime + development tarball](/data/pkg/windows/1.20.7/uwp/gstreamer-1.0-uwp-universal-1.20.7.tar.xz)
* UWP Universal (ARM64, X86, X86_64) (VS 2019, Debug CRT) (ancient stable)
  - [1.20.7 runtime + development tarball](/data/pkg/windows/1.20.7/uwp/gstreamer-1.0-uwp+debug-universal-1.20.7.tar.xz)

UWP apps cannot use plugins that use dependencies built with MinGW because of
forbidden APIs. Hence, these plugins are omitted from the binaries.

UWP has been abandoned by Microsoft, and as such is no longer supported by the
GStreamer project. This section will be removed in the future.

## iOS legacy framework

The legacy framework only supports iOS and an iOS Simulator on an Intel Mac.

* **iOS Universal [{{% ver bin %}} legacy framework](/data/pkg/ios/{{% ver bin %}}/gstreamer-1.0-devel-{{% ver bin %}}-ios-universal.pkg) (current stable version)**
* iOS Universal [{{% ver old_bin %}} legacy framework](/data/pkg/ios/{{% ver old_bin %}}/gstreamer-1.0-devel-{{% ver old_bin %}}-ios-universal.pkg) (old stable version)

The legacy framework will be removed in a future GStreamer release.
