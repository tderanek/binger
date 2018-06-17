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

    def find_displayed_element(search, timeout = 5)
      browser.find_displayed_element(search, timeout)
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

    def submit_credentials(username, password)
      # Enter and confirm email address
      browser.find_displayed_element(name: 'loginfmt').send_keys(username)
      browser.find_displayed_element(id: 'idSIButton9').click
      # Enter and confirm password
      browser.find_displayed_element(name: 'passwd').send_keys(password)
      browser.find_displayed_element(id: 'idSIButton9').click
    end

    def to_main_page
      browser.get('https://www.bing.com')
    end
  end
end
