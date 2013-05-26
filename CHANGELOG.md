# 0.7.0
* Added Bini::Extensions::Savable.  This can extend any hash into a savable one.
* Updated Sash to be built off Extensions::Savable.
* Added Bini.clear to reset defaults.  Refactored how defaults and attributes are generated.
* Added Bini.data_dir (default: ~/.local/share/#{long_name})
* Added some documentation for Sash.
* Added overrides:{} and options:{} to Sash.  This splits out the options from any k/v's you want to set initially.
* Added autoloads, from now on you just have to require 'bini' and use the modules as you see fit.
* Fixed bini.long_name by making them all procs. (github #6)

# 0.6.0
* renamed Bini.config to Bini::Config
* 100% test coverage.
* Documentation push.
* Dropped the daemonize code, will implement again later if I decide I need it.
* Dropped kruft like Bini#get_var
* Bini.version works as intended, providing a settable version to use in a given app.
* Options.parse! now takes an ARGV or falls back if nothing is provided.
