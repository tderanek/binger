# frozen_string_literal: true

require 'io/console'
require 'selenium-webdriver'
require 'thor'

require 'binger/bing_browser'
require 'binger/commands'
require 'binger/desktop_bing_browser'
require 'binger/helper'
require 'binger/mobile_bing_browser'
require 'binger/version'

require 'selenium/web_driver/driver'

# Container module for all binger functionality
module Binger
end
