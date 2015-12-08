# Bank Account Statement Changelog


## 0.1.1

- update packaging; new version so tags match built packages

## 0.1.0

- first release! :D MIT Licence

- support Ruby 2.2.3 only

- `bank-account-statement` executable: `--in`, `--in-format`, `--out`,
  `--out-format`, `--in-formats`, `--out-formats`, `--help`, `--version`
  [tiredpixel]

- add input format `HTML/CPBKGB22/Personal/Current/V_2011_05_07`, parsing
  HTML The Co-operative Bank (GB) Personal Current account pre-2015-03-03
  statements [tiredpixel]

- [#1] add input format `HTML/CPBKGB22/Personal/Current/V_2015_03_03`, parsing
  HTML The Co-operative Bank (GB) Personal Current account 2015-03-03 onwards
  statements [tiredpixel]

- [#3] add input format `HTML/CPBKGB22/Personal/Savings/V_2011_05_07`, similar
  to `HTML/CPBKGB22/Personal/Current/V_2011_05_07` [tiredpixel]

- [#3] add input format `HTML/CPBKGB22/Personal/Savings/V_2015_03_03`, similar
  to `HTML/CPBKGB22/Personal/Current/V_2015_03_03` [tiredpixel]

- add output format `OFX/V_2_1_1`, generating OFX (Open Financial Exchange)
  2.1.1 [tiredpixel]
