# frozen_string_literal: true

require 'io/console'
require 'thor'
require 'watir'
require 'webdriver-user-agent'

require_relative 'binger/bing_browser'
require_relative 'binger/bing_browser/desktop_bing_browser'
require_relative 'binger/bing_browser/mobile_bing_browser'
require_relative 'binger/commands'
require_relative 'binger/helper'
require_relative 'binger/version'

# Container module for all binger functionality
module Binger
end
