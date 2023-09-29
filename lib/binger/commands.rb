# frozen_string_literal: true

module Binger
  # Holds the commands for the CLI interface of binger
  class Commands < Thor
    class_option :num_searches,
                 type: :numeric,
                 aliases: :n,
                 desc: 'Number of searches to be performed',
                 default: 30
    class_option :email,
                 type: :string,
                 aliases: :e,
                 desc: 'Email address for the Microsoft Rewards account',
                 default: nil
    class_option :password,
                 type: :string,
                 aliases: :p,
                 desc: 'Password for the Microsoft Rewards account',
                 default: nil
    class_option :pause_before,
                 type: :numeric,
                 aliases: :b,
                 desc: 'Seconds to pause for immediately before confirming a search',
                 default: 0
    class_option :pause_after,
                 type: :numeric,
                 aliases: :a,
                 desc: 'Seconds to pause for immediately before confirming a search',
                 default: 0.5
    class_option :custom_search,
                 type: :string,
                 aliases: :c,
                 desc: 'Overrides randomly generated search with a fixed string',
                 default: nil

    method_option :browser_type,
                  type: :string,
                  aliases: :t,
                  enum: %w[edge chrome],
                  desc: 'Determines the type of browser to use. Options: edge, chrome',
                  default: 'edge'
    desc 'desktop', 'Simulates desktop browser searches'
    def desktop
      username = options[:email] || Helper.prompt_for_username
      password = options[:password] || Helper.prompt_for_password

      bing_browser = DesktopBingBrowser.new(options[:browser_type])
      bing_browser.login(username, password)
      options[:num_searches].times do
        bing_browser.send_search(
          pause_before: options[:pause_before],
          pause_after: options[:pause_after],
          custom_search: options[:custom_search] || Helper.randomized_query
        )
      end

      bing_browser.close
    end

    method_option :skip_close_warning,
                 type: :boolean,
                 aliases: :w,
                 desc: 'Skips the attempt to close the warning on a mobile search',
                 default: false
    desc 'mobile', 'Simulates mobile browser searches'
    def mobile
      username = options[:email] || Helper.prompt_for_username
      password = options[:password] || Helper.prompt_for_password
      skip_close_warning = options[:skip_close_warning]

      bing_browser = MobileBingBrowser.new
      bing_browser.login(username, password, skip_close_warning)
      options[:num_searches].times do
        bing_browser.send_search(
          pause_before: options[:pause_before],
          pause_after: options[:pause_after],
          custom_search: options[:custom_search] || Helper.randomized_query
        )
      end

      bing_browser.close
    end

    method_option :desktop_browser_type,
                  type: :string,
                  aliases: :t,
                  enum: %w[edge chrome],
                  desc: 'Determines the type of browser to use. Options: edge, chrome',
                  default: 'edge'
    desc 'turbo_mode', 'Runs both desktop and mobile simulations'
    def turbo_mode
      username = options[:email] || Helper.prompt_for_username
      password = options[:password] || Helper.prompt_for_password

      bing_browser = DesktopBingBrowser.new(options[:desktop_browser_type])
      bing_browser.login(username, password)
      options[:num_searches].times do
        bing_browser.send_search(
          pause_before: options[:pause_before],
          pause_after: options[:pause_after],
          custom_search: options[:custom_search] || Helper.randomized_query
        )
      end
      bing_browser.close

      bing_browser = MobileBingBrowser.new
      bing_browser.login(username, password)
      options[:num_searches].times do
        bing_browser.send_search(
          pause_before: options[:pause_before],
          pause_after: options[:pause_after],
          custom_search: options[:custom_search] || Helper.randomized_query
        )
      end
      bing_browser.close

      # TODO: Re-organize and get rid of repeated code
    end
  end
end
