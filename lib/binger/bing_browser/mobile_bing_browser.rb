# frozen_string_literal: true

module Binger
  class MobileBingBrowser < BingBrowser
    def send_search(options = {})
      patiently_select(:text_field, name: 'q').yield_self do |search_bar|
        search_bar.set(options[:custom_search] || randomized_query)
      end

      sleep(options[:pause_before]) if options[:pause_before]
      if browser.element(id: 'sbBtn').present?
        patiently_select(:element, id: 'sbBtn').click
      else
        patiently_select(:element, id: 'sb_form_go').click
      end
      sleep(options[:pause_after]) if options[:pause_after]
    end

    private

    def to_sign_in
      patiently_select(:element, class: %w[closeIcon rms_img]).click
      patiently_select(:element, id: 'mHamburger').click
      patiently_select(:element, id: 'hb_s').click
    end

    def new_browser
      driver = Webdriver::UserAgent.driver(browser: :chrome, agent: :iphone, orientation: :portrait)
      Watir::Browser.new(driver)
    end
  end
end
