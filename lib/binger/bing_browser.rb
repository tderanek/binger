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

    def close
      browser.close
    end

    def login(username, password)
      to_main_page
      to_sign_in
      submit_credentials(username, password)
    end

    def new_browser
      case @type
      when :desktop
        Watir::Browser.new(:chrome)
      when :mobile
        driver = Webdriver::UserAgent.driver(browser: :chrome, agent: :iphone, orientation: :landscape)
        Watir::Browser.new(driver)
      else
        raise 'Error! Invalid type!'
      end
    end

    def patiently_select(element_type, search)
      browser.send(element_type, search).wait_until(interval: 0.5, &:present?)
    end

    def send_search(options = {})
      patiently_select(:text_field, name: 'q').yield_self do |search_bar|
        search_bar.set(options[:custom_search] || randomized_query)
      end

      sleep(options[:pause_before]) if options[:pause_before]
      patiently_select(:element, name: 'go').click
      sleep(options[:pause_after]) if options[:pause_after]
    end

    def to_main_page
      browser.goto('https://www.bing.com')
    end

    def to_sign_in
      # Click sign-in button
      patiently_select(:element, id: 'id_l').click
    end

    private

    def submit_credentials(username, password)
      # Enter and confirm email address
      patiently_select(:text_field, name: 'loginfmt').set(username)
      patiently_select(:element, id: 'idSIButton9').click
      # Enter and confirm password
      patiently_select(:text_field, name: 'passwd').set(password)
      patiently_select(:element, id: 'idSIButton9').click
    end

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
