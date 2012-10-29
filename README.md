# Description
This is a collection of snippets that help me in my daily workflow, but don't warrant entire gems/packages.

Consider it a library of useful utilities.

# Directory structure:

* bin
 * This directory contains all the scripts themselves.  This is to limit $PATH polution and make it installable as a gem.

* lib
 * Our supporting members go here, nothing fancy just grouped together in modules based on intended usage.

# Gemfile:

The Gemfile here isn't split up per package, it is just a home for the various components so I can run bundle on new hosts and get what I need.

# Binaries

## Beta:
* jsbeautify: run a json blob through yajl to pretty it up and check for syntax, supports piping.
* cower_glob: download a bunch of stuff from AUR based on a glob string.
* next_background: Indexes directories into couch, then can change links and reset xfce4 backgrounds.

## Alpha:
* dedup: Useful for deduplicating data.
* makepkg_concurrent: go into the ~/cower dir and make everything, all at once, horribly noisy.  Currently isn't concurrent.

# Library notes

* app: Gives some basic application support, and some universal namespacing.  all other components depend on this being loaded first.
* cli: Add option parsing and some support to break in via pry into any app.
* config: Used for config file loading and saving in ~/.config/bini
* couch: mixin support for couchdb'ing on the localhost, including a few basic model's I use all the time.
* filemagic: File detection based on the unix 'file' command to do magic detection.  Currently only returns mime_type.

# Couch model types:

* file: This provides basic stats about a file as well as the md5sum of the file, really just to extend in other apps.
* image: A child of file, this will store the file and some addtional image information into a database.  This comes with two helper methods, image_info which uses identify to detect image types and is_image? which uses the filemagic library to check mime_type.
