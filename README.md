[![Code Climate](https://codeclimate.com/github/LukeWinikates/lmk.png)](https://codeclimate.com/github/LukeWinikates/lmk)
[![Build Status](https://travis-ci.org/LukeWinikates/lmk.png?branch=master)](https://travis-ci.org/LukeWinikates/lmk)
LMK
===========

Don't sit around waiting for rake/make/tests/etc to finish. Let the machine tell you when it's done.

## USAGE:
`$ lmk exec [command]`

executes [command], sending a digest of the result as an SMS to the specified phone number and creating a private, anonymous gist with the full command output.

For example:
`$ lmk exec bundle install`


## PREREQUISITES:
You need a twilio account, including API Key and Account SID for sending [SMSes](http://www.twilio.com/sms).

## INSTALLATION/CONFIGURATION:
LMK requires a ~/.lmkrc file in order to run. The .lmkrc is a simple YAML file with four required values: 
- phone_number: The number at which you want to receive a message when the command has finished running.
- from: a number associated with your Twilio account & set up for SMS sending
- account_sid: from your Twilio Account
- auth_token: from your Twilio Account

You can validate your .lmkrc at any time by running LMK's `config` command:

`$ lmk config`

## LICENSE:
MIT Licensed. See LICENSE file.
