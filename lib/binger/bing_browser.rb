# frozen_string_literal: true

module Binger
  class BingBrowser
    def initialize
      raise 'BingBrowser is to be used as an abstract class!' if self.class == BingBrowser
      
      @browser = nil
    end

    def _browser
      @browser ||= new_browser
    end

    def close
      _browser.close
    end

    def login(username, password, skip_close_warning = false)
      to_main_page
      to_sign_in(skip_close_warning)
      submit_credentials(username, password)
    end

    def patiently_select(element_type, search, seconds = 10)
      element = _browser.send(element_type, search).wait_until(interval: 0.25, &:present?)
    end

    def to_main_page
      _browser.goto('https://www.bing.com')
    end

    private

    def submit_credentials(username, password)
      # Enter and confirm email address
      patiently_select(:text_field, type: 'email').set(username)
      patiently_select(:element, id: 'idSIButton9', type: 'submit').click
      # # Enter and confirm password
      patiently_select(:text_field, type: 'password').set(password)
      patiently_select(:element, id: 'idSIButton9', type: 'submit').click
    end
  end
end
