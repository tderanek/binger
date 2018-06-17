module Binger
  class BingBrowser    
    def initialize
      raise 'BingBrowser is to be used as an abstract class!' if self.class == BingBrowser

      @browser = nil
    end

    def browser
      @browser ||= new_browser
    end

    def close
      browser.quit
    end

    def find_displayed_element
      browser.find_displayed_element
    end

    def login(username, password)
      to_main_page
      to_sign_in
      submit_credentials(username, password)
    end

    def randomized_query(size = 50)
      number_generator = Random.new(Time.now.to_i)
      charset = [('a'..'z'), ('A'..'Z'), (0..9)].map(&:to_a).flatten
      (0...size).map { charset[number_generator.rand(charset.length)] }.join
    end

    def to_main_page
      browser.get('https://www.bing.com')
    end
  end
end
