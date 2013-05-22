require "bini/core"

module Bini
  autoload :Sash,                    'bini/sash'
  autoload :Options,                 'bini/optparser'
  autoload :Config,                  'bini/config'
  autoload :Backups,                 'bini/backups'
  autoload :OptionParser,            'bini/optparser'
  autoload :FileMagic,               'bini/filemagic'
  autoload :Prompts,                 'bini/prompts'
  autoload :VERSION,                 'bini/version'
end

module Bini
  module Extensions
    autoload :HashMetadata, 'bini/extensions/hash_metadata'
    autoload :Savable, 'bini/extensions/savable'
  end
end

