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

    desc 'desktop', 'Sends 30 desktop searches in quick succession'
    def desktop
      username = options[:email] || Helper.prompt_for_username
      password = options[:password] || Helper.prompt_for_password

      bing_browser = DesktopBingBrowser.new
      bing_browser.login(username, password)
      options[:num_searches].times do
        bing_browser.send_search(
          pause_before: options[:pause_before],
          pause_after: options[:pause_after],
          custom_search: options[:custom_search]
        )
      end

      bing_browser.close
    end

    desc 'mobile', 'BROKEN! DO NOT USE'
    def mobile
      username = options[:email] || Helper.prompt_for_username
      password = options[:password] || Helper.prompt_for_password

      bing_browser = MobileBingBrowser.new
      bing_browser.login(username, password)
      options[:num_searches].times do
        bing_browser.send_search(
          pause_before: options[:pause_before],
          pause_after: options[:pause_after],
          custom_search: options[:custom_search]
        )
      end

      bing_browser.close
    end
  end
end
