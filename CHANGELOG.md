# (unreleased)
* Added some documentation for Sash
* Added overrides:{} and options:{} to Sash.  This splits out the options from any k/v's you want to set initially.
* Added autoloads!
* Fixed bini.long_name by making them all procs. (github #6)

# 0.6.0
* renamed Bini.config to Bini::Config
* 100% test coverage.
* Documentation push.
* Dropped the daemonize code, will implement again later if I decide I need it.
* Dropped kruft like Bini#get_var
* Bini.version works as intended, providing a settable version to use in a given app.
* Options.parse! now takes an ARGV or falls back if nothing is provided.
