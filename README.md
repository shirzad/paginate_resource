# PaginateResource

paginate_resource is a simple ruby gem which allows a Rails application to easily
provide pagination functionality beginning with a given resource. Normally you would use gems
like will_paginate or kaminari to paginate your collection on a listing page.
Once the user selects a resource from the list and enters the view for the selected resource you
need a way to jump to the next resource starting from that very resource.

paginate_resource provides two helper methods to jump to the next resource
or the previous resource in the list taking care of the order and any arel conditions.

## Compatibility

Tested with Ruby 2.1.5 and Rails 4.1.8

## Installation

Add this line to your application's Gemfile:

    gem 'paginate_resource'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install paginate_resource

## Usage

To include the pagination add the following to your controller:

    paginate_resource
    
It will provide two helper methods:

    next_resource
    prev_resource
    
next_resource also accepts a boolean parameter. If true it rotates back to the first
resource after reaching the last element in the list.

    next_resource(true)
    
This gem does not need any additional configuration if used with inherited_resources.
If inherited_resources is not in use then the controller must provide the "resource" method.

    class UsersController < ApplicationController
        paginate_resource
        
        def resource
            User.where(id: params[:id]).first
        end
    end
    
The above example will paginate User model starting at params[:id]. 
The gem uses the collection method to infer the model to be paginated.
By overriding the collection method you can provide additional arel conditions or order.

    def collection
        User.confirmed.order("name ASC")
    end
    
Now by viewing a specific user the next_resource method will return the next confirmed user
ordered by name asc. The default order is by primary key.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/paginate_resource/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
