# unreleased:
  * Added bini/subcommand for all your subcommand needs.

# 0.6.0
  * renamed Bini.config to Bini::Config
  * 100% test coverage.
  * Documentation push.
  * Dropped the daemonize code, will implement again later if I decide I need it.
  * Dropped kruft like Bini#get_var
  * Bini.version works as intended, providing a settable version to use in a given app.
  * Options.parse! now takes an ARGV or falls back if nothing is provided.
