# frozen_string_literal: true

module Binger
  class MobileBingBrowser < BingBrowser
    HOME_PAGE_SUBMIT_CRITERIA = { id: 'search_icon' }
    RESULTS_PAGE_SUBMIT_CRITERIA = { id: 'sb_form_go' }

    def send_search(options = {})
      if _browser.text_field(id: 'sb_form_q').present?
        patiently_select(:text_field, id: 'sb_form_q').yield_self do |search_bar|
          search_bar.set(options[:custom_search] || randomized_query)
        end
      else
        patiently_select(:textarea, id: 'sb_form_q').yield_self do |search_bar|
          search_bar.set(options[:custom_search] || randomized_query)
        end
      end

      sleep(options[:pause_before]) if options[:pause_before]

      if _browser.element(HOME_PAGE_SUBMIT_CRITERIA).present?
        patiently_select(:element, HOME_PAGE_SUBMIT_CRITERIA).click
      elsif _browser.element(RESULTS_PAGE_SUBMIT_CRITERIA).present?
        patiently_select(:element, RESULTS_PAGE_SUBMIT_CRITERIA).click
      else
        abort 'Submit button not found'
      end

      sleep(options[:pause_after]) if options[:pause_after]
    end

    private

    def to_sign_in(skip_close_warning = false)
      patiently_select(:element, { class: 'closeIcon rms_img' }).click unless skip_close_warning
      patiently_select(:element, id: 'mHamburger').click
      patiently_select(:element, id: 'hb_s').click
    end

    def new_browser
      driver = Webdriver::UserAgent.driver(browser: :chrome, agent: :iphone, orientation: :portrait)
      Watir::Browser.new(driver)
    end
  end
end
