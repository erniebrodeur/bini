# This is originally from: https://gist.github.com/2040373

module Bini
  # A few prompts I may need in making CLI's.
  module Prompts
    extend self
    def ask(*params)
      params = params[0] if params[0]
      raise RuntimeError, 'No interactive terminal present.' unless $stdin.tty?
      if params[:prompt]
        $stderr.print params[:prompt]
        $stderr.flush
      end
      if params[:password]
        raise RuntimeError 'Could not disable echo to ask for password security' unless system 'stty -echo -icanon'
      end
      output = $stdin.gets
      output.chomp! if output
      #unmuck the prompt.
      `stty echo icanon`
      output
    end
  end
end

