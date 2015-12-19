# Bank Account Statement (Ruby)

[![Gem Version](https://badge.fury.io/rb/bank-account-statement.png)](http://badge.fury.io/rb/bank-account-statement)
[![Build Status](https://travis-ci.org/tiredpixel/bank-account-statement-rb.png?branch=master,release)](https://travis-ci.org/tiredpixel/bank-account-statement-rb)

Bank account statement format transformation (HTML to OFX).

Bank Account Statement is a program for transforming the format of bank account
statements. For some reason, many banks don't offer online bank statements in a
readily-consumable format (this seems to be especially true in the UK). For
example, despite it being possible to view bank statements online for UK bank
*The Co-operative Bank*, statements for personal current (checking) accounts
cannot be downloaded except in HTML. Business accounts often don't fare much
better.

Bank Account Statement mitigates this problem by providing input parsers and
output generators, with a simple executable. Unlike various other similar
programs, I **am** prepared to accept pull-requests for other banks and
output formats. (Please remember to sanitise any test fixtures! Tests for new
input formats are not necessarily expected, however, because I'm concerned
about copyright.)

More sleep lost by [tiredpixel](https://www.tiredpixel.com/).


## Installation

- [Ruby](https://www.ruby-lang.org/en/)
  
  The default version supported is defined in `.ruby-version`.
  Any other versions supported are defined in `.travis.yml`.

Install using [gem](https://rubygems.org/):

```shell
gem cert --add <(curl -Ls https://raw.github.com/tiredpixel/bank-account-statement-rb/master/certs/gem-public_cert-tiredpixel@posteo.de-2015-12-08.pem)
gem install bank-account-statement -P MediumSecurity
```


## Usage

Get help:

```shell
bank-account-statement --help
```

To convert all UK bank *The Co-operative Bank* HTML personal current account
pre-2015-03-03 statements to *OFX 2.1.1* (see other formats for later):

```shell
bank-account-statement \
    --in "IN_DIR/*.html" \
    --in-format HTML/CPBKGB22/Personal/Current/V_2011_05_07 \
    --out "OUT_DIR/" \
    --out-format OFX/V_2_1_1
```


## Input Formats

Input formats supported are:

```
HTML/CPBKGB22/Personal/CreditCard/V_2011_04_09
HTML/CPBKGB22/Personal/CreditCard/V_2015_05_27
HTML/CPBKGB22/Personal/Current/V_2011_05_07
HTML/CPBKGB22/Personal/Current/V_2015_03_03
HTML/CPBKGB22/Personal/Savings/V_2011_05_07
HTML/CPBKGB22/Personal/Savings/V_2015_03_03
TXT/CPBKGB22/Business/Current/V_2015_12_06
```

(Generated with `bank-account-statement --in-formats`.)

BIC      | Country | Name
---------|---------|-----
CPBKGB22 | GB      | The Co-operative Bank


## Output Formats

Output formats supported are:

```
CSV/Column_2
OFX/V_2_1_1
```

(Generated with `bank-account-statement --out-formats`.)


## Development

Run the tests, which use [MiniTest](https://github.com/seattlerb/minitest):

```shell
rake test
```

Unfortunately, many input formats have no tests committed, because I'm concerned
about copyright.


## Stay Tuned

You can become a
[watcher](https://github.com/tiredpixel/bank-account-statement-rb/watchers)
on GitHub. And you can become a
[stargazer](https://github.com/tiredpixel/bank-account-statement-rb/stargazers)
if you are so minded. :D


## Contributions

Contributions are embraced with much love and affection!
Please fork the repository and wizard your magic, ensuring that any tests are
not broken by the changes. :) Then send me a pull request.
If you'd like to discuss what you're doing or planning to do, or if you get
stuck on something, then just wave. :)

Do whatever makes you happy. We'll probably still like you. :)

Please remember to sanitise test fixtures!


## Blessing

May you find peace, and help others to do likewise.


## Licence

© [tiredpixel](https://www.tiredpixel.com/) 2015.
It is free software, released under the MIT License, and may be redistributed
under the terms specified in `LICENSE.txt`.
