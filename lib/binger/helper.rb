module Binger
  module Helper
    class << self
      def prompt_for_password
        print 'Please enter your password: '
        password = STDIN.noecho(&:gets).chomp
        print "\n"

        password
      end

      def prompt_for_username
        print 'Please enter your login email address: '
        STDIN.gets.chomp
      end
    end
  end
end
