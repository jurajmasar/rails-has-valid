# rails-has-valid gem

Partial validation of ActiveRecord objects in Ruby on Rails 4+ made simple.

## Usage

* Add rails-has-valid to your Gemfile

```
	gem 'rails-has-valid'
```

* Run `bundle install`

* Define list of attributes you want to partially validate in your model

```
	# user.rb
	class User < ActiveRecord::Base
		# ...
			VALIDATE_ATTRIBUTES = {
				create: [:email, :subscribed],
				update: create.concat([:password])
			}
		# ...
	end
```

* Use the following methods on your models

```
	# users_controller.rb
	user = User.new

	#
	# validate given attributes only
	#
	user.has_valid?(User::VALIDATE_ATTRIBUTES[:create])
	# => true

	# 
	# save object if given parameters are valid
	# return false otherwise
	#
	user.save_if_has_valid(User::VALIDATE_ATTRIBUTES[:update])

	# 
	# save object if given parameters are valid
	# raise ActiveRecord::RecordInvalid exception otherwise
	#
	user.save_if_has_valid!(User::VALIDATE_ATTRIBUTES[:update])	

	#
	# update object attributes to given values if given attributes are valid
	# return false otherwise
	#
	user.update_attributes_if_has_valid( { email: 'new@email.com' }, User::VALIDATE_ATTRIBUTES[:update])

	#
	# update object attributes to given values if given attributes are valid
	# raise ActiveRecord::RecordInvalid exception otherwise
	#
	user.update_attributes_if_has_valid!( { email: 'new@email.com' }, User::VALIDATE_ATTRIBUTES[:update])	
```

It's been tested with Rails 4.1+ only but will most likely work with Rails 3+ as well.

## Contributing to rails-has-valid
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2014 Juraj Masar. See LICENSE.txt for
further details.

