# Bank Account Statement (Ruby)

[![Gem Version](https://badge.fury.io/rb/bank-account-statement.png)](http://badge.fury.io/rb/bank-account-statement)
[![Build Status](https://travis-ci.org/tiredpixel/bank-account-statement-rb.png?branch=master,release)](https://travis-ci.org/tiredpixel/bank-account-statement-rb)

Bank account statement format transformation (HTML to OFX).

Bank Account Statement is a program for transforming the format of bank account
statements. For some reason, many banks don't offer online bank statements in a
readily-consumable format (this seems to be especially true in the UK). For
example, despite it being possible to view bank statements online for UK bank
*The co-operative bank*, statements for personal current (checking) accounts
cannot be downloaded except in HTML. Business accounts often don't fare much
better.

Bank Account Statement mitigates this problem by providing input parsers and
output generators, with a simple executable. Currently, the only input formatter
is UK bank *The co-operative bank* HTML personal current account
pre-2015-03-03 (approx.). Other *The co-operative bank* input formatters are
planned. The only output formatter is *OFX (Open Financial Exchange) 2.1.1*,
which should be compatible with most financial programs. Unlike various other
similar programs, I **am** prepared to accept tested pull-requests for other
banks and output formats. (Please remember to sanitise test fixtures!)

*Bank Account Statement is currently pre-release! It is not yet available as
a gem.*

More sleep lost by [tiredpixel](https://www.tiredpixel.com/).


## Installation

- [Ruby](https://www.ruby-lang.org/en/)
  
  The default version supported is defined in `.ruby-version`.
  Any other versions supported are defined in `.travis.yml`.

Install using [gem](https://rubygems.org/):

    gem install bank-account-statement


## Usage

Get help:

    bank-account-statement --help

To convert all UK bank *The co-operative bank* HTML personal current account
pre-2015-03-03 statements to *OFX 2.1.1*:

    bank-account-statement \
        --in "IN_DIR/*.html" \
	--in-format HTML/CPBKGB22/CHECKING/V_2011_05_07 \
	--out "OUT_DIR/" \
	--out-format OFX/V_2_1_1


## Development

Run the tests, which use [MiniTest](https://github.com/seattlerb/minitest):

    rake test


## Stay Tuned

You can become a
[watcher](https://github.com/tiredpixel/bank-account-statement/watchers)
on GitHub. And you can become a
[stargazer](https://github.com/tiredpixel/bank-account-statement/stargazers)
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
