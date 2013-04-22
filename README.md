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

## Sash

Sash is a savable hash.  It saves the key/value pairs from the hash into a
YAML file that can be loaded later.  It manages permissions (optionally), can
create a backup/save file, automatically save on changes, as well as
automatically load on startup. It can be configured before use, as well as
reconfigured during use.

### Configuration

Configuration can be either at initialization or after.  The one drawback is
you cannot (currently) feed it a new hash to set the initial values.

The five main settings are:

* file:     Filename to save the hash to.
* backup:   Boolean, whether to produce a backup or not.
* mode:     FixNum: mode to store it as: 0600, 0755, 0644 and so on.
* autosave: Boolean: Automatically save on changes.
* autoload: Boolean: Automatically load on init.

The values for these do not get stored in the YAML file.  Only the k/v pairs you
set do.

### Examples

Configuration:

    s = Bini::Sash.new file:'filename', auto_save:true

Or after creation:

    s.auto_save = true
    s.auto_load = false
    s.backup = true

If backup or mode are set, they will update at the next time you save.

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
