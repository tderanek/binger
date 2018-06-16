module Binger
  class DesktopBingBrowser < BingBrowser
    def new_browser
      Selenium::WebDriver.for(:chrome)
    end

    def send_search(options = {})
      browser.find_displayed_element(name: 'q').yield_self do |search_bar|
        search_bar.clear
        search_bar.send_keys(options[:custom_search] || randomized_query)
      end
      sleep(options[:pause_before]) if options[:pause_before]

      browser.find_displayed_element(name: 'go').click
      sleep(options[:pause_after]) if options[:pause_after]
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

    def to_sign_in
      # Click sign-in button
      browser.find_displayed_element(id: 'id_l').click
    end

    def verify_type(type)
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
