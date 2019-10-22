# frozen_string_literal: true

module Binger
  class DesktopBingBrowser < BingBrowser
    def send_search(options = {})
      patiently_select(:text_field, name: 'q').yield_self do |search_bar|
        search_bar.set(options[:custom_search] || randomized_query)
      end

      sleep(options[:pause_before]) if options[:pause_before]
      patiently_select(:element, name: 'go').click
      sleep(options[:pause_after]) if options[:pause_after]
    end

    private

    def new_browser
      Watir::Browser.new(:chrome)
    end

    def to_sign_in
      patiently_select(:element, id: 'id_l').click
    end
  end
end
