# Content guide: modules, bindings and download

All pages are plain Markdown with YAML frontmatter. Layouts render the
structured fields, so page bodies stay short.

## Modules (`content/modules/<name>.md`)

```yaml
---
title: "GStreamer Base Plug-ins"
module: true          # include in the modules table
legacy: false         # true: listed on the Legacy modules page instead
weight: 2             # table order
blurb: "an essential exemplary set of elements"   # table description
repo_path: "gstreamer/-/tree/main/subprojects/gst-plugins-base"  # under gitlab.freedesktop.org/gstreamer/
maintainers: ["GStreamer Team"]    # list of names
stable: "release"     # "release", "orc", "git main" or free text (e.g. "obsolete", "N/A")
devel: "release"      # same values as stable
status: "active"      # free text shown in the table
---
Short description in Markdown.
```

`release` resolves to the versions in `site-data/release.yml`. `git main` links to
the repository.

## Bindings (`content/bindings/<name>.md`)

```yaml
---
title: "Bindings for Python"
binding: true         # include in the bindings table
legacy: false         # true: listed on the Legacy bindings page
weight: 1             # table order
name: "Python"        # language name shown in the table
status: "Released. See the [gst-python](/modules/gst-python.html) module."  # inline Markdown
contacts: [{"name": "Jane Doe", "email": "jane (at) example.org"}]  # optional
---
Body in Markdown (About, Links, ...).
```

## Download (`content/download/_index.md`)

The page is a `tabs` shortcode containing one `tab` per platform. The tab
bodies are normal Markdown (`{{% tab %}}` must use the `%` delimiters):

```
{{< tabs >}}
{{% tab id="windows" title="Windows" color="g" %}}
Markdown here.
{{% /tab %}}
{{< /tabs >}}
```

Versions come from `site-data/release.yml` through `{{% ver key %}}`, with keys
`bin`, `bin_branch`, `old_bin`, `old_bin_branch`, `stable`, `branch`, `devel`,
`devel_branch`, `orc_stable` and `orc_devel`. Example:
`[installer](/data/pkg/osx/{{% ver bin %}}/gstreamer-{{% ver bin %}}.pkg)`.
`tools/new-release.py X.Y.Z` (or `bin/new-release`) updates `site-data/release.yml`, the series page and the news for you. The binary installer versions (`bin:`) are edited by hand once the binaries are published.
