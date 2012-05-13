# Description
This is a collection of snippets that help me in my daily workflow, but don't warrant entire gems/packages.

Consider it a library of useful utilities.

# Directory structure:

* bin
 * This directory contains all the scripts themselves.  This is just so README.md and other files don't show up in PATH.

* lib
 * Our supporting members go here, nothing fancy just grouped together in modules based on intended usage.

# Gemfile:

The Gemfile here isn't split up per package, it is just a home for the various components so I can run bundle on new hosts and get what I need.

# Binaries

* rcat: Color output via coderay, not that sophisticated yet, can't pipe with it.
* jsbeautify: run a json blob through yajl to pretty it up and check for syntax, supports piping.
* cower_glob: download a bunch of stuff from AUR based on a glob string.

# Library notes

* app.rb: Gives some basic application support, and some universal namespacing.  all other components depend on this being loaded first.

* cli.rb: Add option parsing and some support to break in via pry into any app.
* couch.rb: mixin support for couchdb'ing on the localhost, including a few basic model's I use all the time.

# Couch model types:

* file: This provides basic stats about a file as well as the md5sum of the file, really just to extend in other apps.
