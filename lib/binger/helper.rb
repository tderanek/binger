# frozen_string_literal: true

module Binger
  module Helper
    class << self
      def randomized_query(size = 50)
        number_generator = Random.new(Time.now.to_i)
        charset = [('a'..'z'), ('A'..'Z'), (0..9)].map(&:to_a).flatten
        (0...size).map { charset[number_generator.rand(charset.length)] }.join
      end

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
