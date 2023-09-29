# frozen_string_literal: true

module Binger
  class DesktopBingBrowser < BingBrowser
    SUPPORTED_BROWSER_TYPES = %i[edge chrome]

    def initialize(browser_type = 'edge')
      @browser_type = sanitize_browser_type(browser_type)
    end

    def send_search(options = {})
      # if _browser.textarea(name: 'q').present?
      patiently_select(:textarea, name: 'q').yield_self do |search_bar|
        search_bar.set(options[:custom_search] || randomized_query)
      end
      # else
        # patiently_select(:input, name: 'q').yield_self do |search_bar|
          # search_bar.set(options[:custom_search] || randomized_query)
        # end
      # end

      sleep(options[:pause_before]) if options[:pause_before]
      if _browser.form(id: 'sb_form').present?
        patiently_select(:form, id: 'sb_form').submit
      else
        patiently_select(:element, id: 'sb_form_go').click
      end
      sleep(options[:pause_after]) if options[:pause_after]
    end

    private

    def new_browser
      Watir::Browser.new(@browser_type)
    end

    def sanitize_browser_type(browser_type)
      provided_browser = browser_type.downcase.to_sym

      unless SUPPORTED_BROWSER_TYPES.include?(provided_browser)
        raise "Unsupported browser type provided (#{browser_type}). Supported browser types: #{supported_browser_types_string}"
      end

      provided_browser
    end

    def submit_credentials(username, password)
      # Enter and confirm email address
      patiently_select(:text_field, type: 'email').set(username)
      patiently_select(:element, id: 'idSIButton9', type: 'submit').click
      # # Enter and confirm password
      patiently_select(:text_field, type: 'password').set(password)
      patiently_select(:element, id: 'idSIButton9', type: 'submit').click
      # Check for "Stay signed in?" Dialogue Box
      sleep(1)
      if _browser.input(type: 'submit', value: 'Yes').present?
        patiently_select(:element, id: 'idSIButton9', type: 'submit').click
      end
    end

    def supported_browser_types_string
      SUPPORTED_BROWSER_TYPES.join(', ')
    end

    def to_sign_in(_skip_close_warning)
      sleep(2)
      patiently_select(:element, id: 'id_l').click
    end
  end
end
