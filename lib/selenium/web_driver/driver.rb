module Selenium::WebDriver
  class Driver
    # Finds element and returns it after it is displayed
    #
    # search: Hash, the search hash for the element. Corresponds to FINDERS docs here: https://tinyurl.com/y7qdfkdl
    # timeout: Integer, The number of seconds to wait before timing out
    #
    # Returns: Selenium::WebDriver::Element Instance, The element from the given search
    def find_displayed_element(search, timeout = 5)
      wait = Selenium::WebDriver::Wait.new(timeout: timeout)

      wait.until do
        element = find_element(search)
        element if element.displayed?
      end
    end
  end
end
