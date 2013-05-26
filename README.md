# Bini

A toolbox to help me rapidly build/deploy a cli.  Filled with assumptions about how I think a CLI should behave.

## Build Status
<table border="0">
  <tr>
    <td>master</td>
    <td><a href=http://travis-ci.org/erniebrodeur/bini?branch=master><img src="https://secure.travis-ci.org/erniebrodeur/bini.png?branch=master"/></h> </td>
  </tr>
  <tr>
    <td>development</td>
    <td><a href=http://travis-ci.org/erniebrodeur/bini?branch=development><img src="https://secure.travis-ci.org/erniebrodeur/bini.png?branch=development"/></h> </td>
  </tr>
</table>

## Installation

To install:

		% gem install bini

To use inside of an application, add this to the your gemfile:

		% gem 'bini'

and run bundle to make it available:

		% bundle

## Usage

Bini is broken up into a few pieces, always include this first:

```ruby
require 'bini'
```

Optional components can be loaded like this:

```ruby
require 'bini/config'
require 'bini/optparser'
require 'bini/log'
```
## Extensions
### Savable

Make any hash savable.  It saves the key/value pairs from the hash into a
YAML file that can be loaded later.  It manages permissions (optionally), can
create a backup/save file, automatically save on changes.

To use it just ```include Bini::Extensions::Savable``` in the top of your class

```ruby
class NewClass < Hash
  include Bini::Exetensions::Savable
end
```

Now when you create the new object, it will have access to a few addtional
methods.

    % obj.save
    % obj.load

Are the main two, the other methods can be used but are typically called through
those two.  These secondary methods are:

    % obj.backup
    % obj.set_mode

Backup will create a backup file on the spot.  This won't save the current hash,
just copy the save file.

Set mode will set the mode stored in ```obj.options[:mode]``` on the file.

You can check if the obj needs to be saved with ```is_dirty?```.  This will
return ```true``` if you need to save and false if you do not.

To configure savable you create k/v pairs in it's options.

    % obj.options[:backup] = true

Options is just anothr hash to contain the various settings cleanly.

  * file:     Filename to save the hash to.
  * backup:   Boolean, whether to produce a backup or not.
  * mode:     FixNum: mode to store it as: 0600, 0755, 0644 and so on.
  * autosave: Boolean: Automatically save on changes.

## Helpers
### Sash

Sash is a class extended from hash with savable and a few extra features.  You can add
overrides (load values into the hash on creation), options at creation and autoload.

Overrides are just a way to set values on creation.

### Additional Options

  * autoload:  Boolean: set to true to load the value of the config right on creation

### API

Generated documentation is available via ```yard```.

Examples and wiki coming if they are ever needed.

## Design philosophy

If such a thing can be said.

* Whenever possible, sane defaults will be supplied.
* A minimum amount of configuration before execution.
* If it requires a large chunk of requires, put it in a sub gem.
* Speed is of the utmost importance.
* Whenever possible, use stuff out of the stdlib.

## Contributing

I don't have rules here, more guidelines.

* Try to make the branch name clear, words like feature/issue/bug help.
* Tests.
