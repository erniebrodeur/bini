# Bini

A toolbox to help me rapidly build/deploy a cli.  Filled with assumptions about how I think a CLI should behave.

#### Build Status
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

### API

Generated documentation is available via ```yard```.

Examples and wiki coming if they are ever needed.

## Testing

In theory, testing is complete, in practice it's a work in progress.


## Contributing

I don't have rules here, more guidelines.

* Try to make the branch name clear, words like feature/issue/bug help.
