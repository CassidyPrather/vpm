# Cassidy's VPM Listing

VRChat Creator Companion listing, published to <https://wirenook.net/vpm/listing.json>.

Edit `source.json` to add packages.

```sh
python3 build-listing.py
```

The listing rebuilds on a push to `source.json`, by hand from the Actions tab,
and whenever a listed repository publishes a release. Each package repository
sends that last trigger itself, which needs a `VPM_DISPATCH_TOKEN` secret in
that repository: a fine-grained token with **Contents: read and write** on
`CassidyPrather/vpm` only. Without the secret, releases still publish but skip
the rebuild.

## Legal

Copyright 2026 Cassidy Prather <cassidy@wirenook.net>

Everything in this repository henceforth is licensed under [GPLv3](https://www.gnu.org/licenses/gpl-3.0.html) (See `COPYING`) unless otherwise specified.

## Credits

Descended from https://github.com/vrchat-community/template-package-listing ([VRCHAT DISTRO LICENSE FILE](https://github.com/vrchat-community/template-package/blob/d9cf13fe9f56867cbf7315a4dbbf1901bc1537ec/Packages/com.vrchat.core.bootstrap/License.md))
