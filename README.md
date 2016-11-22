![](https://travis-ci.org/enzosterro/bscm.svg?branch=master)
[![Twitter](https://img.shields.io/badge/twitter-%40enzo__sterro-blue.svg)](https://twitter.com/enzo_sterro)

# BackstopJS Scenarios Constructor
BackstopJS Scenarios Constructor is a small tool for macOS to help you make a configuration file from `sitemap.xml` for [BackstopJS](https://github.com/garris/BackstopJS) regression testing.

# Constructor workflow

1. Build a project in xCode or use a compiled application.
2. Generate the `sitemap.xml` file in any convenient way. For example, through [XML-Sitemaps Online](https://www.xml-sitemaps.com).
3. Place this `sitemap.xml` anywhere on the web.
4. Enter URL where your sitemap.xml file placed.
5. Fill other fields if needed.
6. Make scenarios.
7. Move the `backstop.json` to your project derictory near `node_modules`.

# Knowing Issues

1. `Backstop.json` isn't a pretty printed due an asynchronous data generating.

2. Generated XML should contain the root tag `urlset`, then the child `url`. If your XML doesn't match this pattern you should make a changes here:
```swift
for elem in xml["urlset"]["url"] {
let currentUrl = elem["loc"].element!.text! }
```

BackstopJS Scenarios Constructor uses SWXMLHash from [drmohundro repository](https://github.com/drmohundro/SWXMLHash).

# Screenshots
![alt text](https://raw.githubusercontent.com/enzosterro/bscm/master/Images/backstopjssc.jpg "Constructor Screenshot")
