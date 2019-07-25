# frozen_string_literal: true

module Binger
  class BingBrowser
    def initialize(type)
      @type = validated_type(type)
      @browser = nil
    end

    def browser
      @browser ||= new_browser
    end

    def new_browser
      Watir::Browser.new(:chrome)
    end

    def close
      browser.close
    end

    def login(username, password)
      to_main_page
      to_sign_in
      submit_credentials(username, password)
    end

    def submit_credentials(username, password)
      # Enter and confirm email address
      browser.element(name: 'loginfmt').set(username)
      browser.element(id: 'idSIButton9').click
      # Enter and confirm password
      browser.element(name: 'passwd').set(password)
      browser.element(id: 'idSIButton9').click
    end

    def to_main_page
      browser.goto('https://www.bing.com')
    end

    def send_search(options = {})
      browser.element(name: 'q').yield_self do |search_bar|
        search_bar.set(options[:custom_search] || randomized_query)
      end

      sleep(options[:pause_before]) if options[:pause_before]
      browser.element(name: 'go').click
      sleep(options[:pause_after]) if options[:pause_after]
    end

    def to_sign_in
      # Click sign-in button
      browser.element(id: 'id_l').click
    end

    private

    def validated_type(type)
      case type
      when :mobile
        :mobile
      when :desktop
        :desktop
      else
        raise "Invalid device type '#{type}' used"
      end
    end
  end
end
