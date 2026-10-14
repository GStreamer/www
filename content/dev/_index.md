---
title: "Developer Information"
---
Much documentation and some introductory slides are to be found on the
[Documentation page](/documentation/). We suggest to read
the manual and the slides to get a general overview and to get you started.

New developers are welcome to:

* Contribute to the core library.
* Write plugins for GStreamer.
* Write applications using GStreamer.
* Write a lot of [language bindings](/bindings/).
* Contribute to the documentation.
* Build test cases.

The developers tend to live on Matrix in
[`#gstreamer:gstreamer.org`](https://matrix.to/#/#gstreamer:gstreamer.org)
and the other chat rooms of the
[`#community:gstreamer.org`GStreamer space](https://matrix.to/#/#community:gstreamer.org).

# Git access

## Modules

The repository is split in several [modules](/modules/).

## Anonymous Git Access

This project is hosted on the [freedesktop.org
GitLab](https://gitlab.freedesktop.org/gstreamer/). The Git repositories can be checked out through anonymous
Git with the following instructions. The module you wish to check out
must be specified as the modulename. To determine the names of the
modules created by this project, you may examine their Git repository
via the [GitLab
interface](https://gitlab.freedesktop.org/gstreamer/).

```
git clone https://gitlab.freedesktop.org/gstreamer/modulename.git
```

## Contributing to GStreamer

You do not need a developer account in order to work on GStreamer. Anonymous git
access should be sufficient for that, and it's easy to maintain personal git
branches by [forking](https://docs.gitlab.com/ee/gitlab-basics/fork-project.html)
the repository in your GitLab user space. Patches can then be submitted as [Merge
Requests](https://gitlab.freedesktop.org/help/user/project/merge_requests/index.md) against the appropriate module.

Developers will be added to the project for write access as necessary.  For all
other changes, please submit patches via Merge Requests as mentioned above.

# Continuous integration: Build bots and validation

Git branches and merge requests are verified by our GitLab CI setup.

By default the full build and test suite will only be run once a merge request
is assigned to be merged, but it's also possible to trigger it manually by
pressing the 'Play' button on the pipeline or manifest job for a branch or
merge request.

# Language Bindings

The GStreamer API can be accessed from [various programming languages](../bindings) in addition to the native C API.
