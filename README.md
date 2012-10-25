# Gumby::Rails

A rails gem for http://gumbyframework.com/ assets.

## Installation

Add this line to your application's Gemfile:

    gem 'gumby-rails'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gumby-rails

## Usage

Require gumby on your asset manifests.

CSS:

    /*
     * app/assets/stylesheets/application.css
     *
     * Any of gumby12, gumby16 or gumby-hybrid can be imported.
     * The example below imports gumby12
     *
     *= require gumby12
     *
     *= require_self
     *= require_tree .
     */

JavaScript:

    // app/assets/javascripts/application.js
    //
    //= require gumby
    //= require_tree .

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
