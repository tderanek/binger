module Binger
  class MobileBingBrowser < BingBrowser
    def new_browser
      options = Selenium::WebDriver::Chrome::Options.new
      options.add_emulation(device_name: 'iPhone 6')
      Selenium::WebDriver.for(:chrome, options: options)
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

    def to_sign_in
      # class: 'closeIcon rms_img'
      # id: 'mHamburger'
      # id: 'hb_s'
      # sleep(1000)
      browser.find_displayed_element(class: 'closeIcon').click
      browser.find_displayed_element(id: 'mHamburger').click
      browser.find_displayed_element(id: 'hb_s').click
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
