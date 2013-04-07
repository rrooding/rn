[![Build Status](https://travis-ci.org/rrooding/rn.png?branch=master)](https://travis-ci.org/rrooding/rn)
[![Code Climate](https://codeclimate.com/github/rrooding/rn.png)](https://codeclimate.com/github/rrooding/rn)

# Rn

This gem adds a validator for the Belgium government registration numbers (also known as *rijksregisternummer* or *RN* for short). You can use it to check if the registration number is a valid number, you can also optionally check against a users birthday.

## Installation

Add this line to your application's Gemfile:

    gem 'rn'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rn

## Usage

Using the RnValidator:

	class User < ActiveRecord::Base
		validates :number, rn: true
	end

This will only check if the number conforms to the rules specified by the Belgian government.

You can also validate against the users birthday:

	class User < ActiveRecord::Base
		validates :number, rn: { birthday: true }
	end

This will look for the users birthday in the `birthday` property which has to be a `Date`. If you want to use another method or column, you can do that as follows:

	class User < ActiveRecord::Base
		validates :number, rn: { birthday: true, birthday_column: :date_of_birth }
	end
	
## I18n

Add the following to your locale file:

	en:
		activemodel:
			errors:
				models:
					MODEL:
						attributes:
							ATTRIBUTE:
								invalid_registration_number: 'is not a valid registration number'
								no_matching_birthday: 'does not match birthday'

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
