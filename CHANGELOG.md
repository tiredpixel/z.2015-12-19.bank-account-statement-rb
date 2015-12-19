# Bank Account Statement Changelog


## 1.0.0

- [#2] add input format `HTML/CPBKGB22/Personal/CreditCard/V_2011_04_09`,
  parsing HTML The Co-operative Bank (GB) Personal Credit Card bank account
  statements downloaded from 2011-04-09 onwards [tiredpixel]

- [#2] add input format `HTML/CPBKGB22/Personal/CreditCard/V_2015_05_27`,
  parsing HTML The Co-operative Bank (GB) Personal Credit Card bank account
  statements downloaded from 2015-05-27 onwards [tiredpixel]

- [#2] extend output format `OFX/V_2_1_1` to support credit card statements
  [tiredpixel]

- [#7] fix `HTML/CPBKGB22/Personal` negative balances throughout [tiredpixel]

- [#5] add input format `TXT/CPBKGB22/Business/Current/V_2015_12_06`,
  parsing TXT The Co-operative Bank (GB) Business Current account statements
  downloaded from 2015-12-06 onwards [tiredpixel]

- [#4] add output format `CSV/Column_2`, generating '2-column' (separate
  withdrawals and deposits columns) CSV files [tiredpixel]

- first major release! :D supporting: The Co-operative Bank (GB) Personal
  account HTML input (2 Credit Card formats, 2 Current formats, 2 Savings
  formats); The Co-operative Bank (GB) Business account TXT input (1 Current
  format); OFX (Open Financial Exchange) 2.1.1 output; CSV output


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
