# binger (VERY MUCH A WORK IN PROGRESS)

Pronounced "bing-er". Will automate daily searches for Microsoft Rewards


## Installation

The gem is not yet uploaded to rubygems. To install this gem you will have to clone this repo and navigate to its directory. Then run the
following commands:

```
bundle install
gem build binger.gemspec
gem install binger-0.1.0.gem
```

Additionally, this gem requires the aid of the Chrome Web Driver. You will need to download the chrome web driver and place it in a
directory in your path. Here is a link to where you can download that: [link](http://chromedriver.chromium.org/downloads). If you're not
sure which directories are in your path. Open up an IRB session and run the following command:

```
# The nil at the end isn't necessary. It's just to avoid the entire array being printed again
`echo $PATH`.split(':').each { |dir| puts dir } ; nil
```

Unzip the Chrome Web Driver when you download it and place its executable (it should be called `chromedriver`) in one of those directories

Oh, you'll also need ruby installed. I'm developing using version 2.5.1, so that's the version I recommend using. If you haven't yet 
installed ruby on your system, I recommend using [RVM](https://rvm.io/rvm/install) to do so.

## Usage

To see usage details for the gem once it is installed, run the following command:

```
binger help
```

Know that only the desktop command actually works... Its also not super error tolerant. Sometimes it messes up the login... I'm working
on it, okay?

TODO: Write better usage section

## Development

I am yet to write a single test for this project and half of it is not functional, so I don't recommend jumping on board with this
project just yet. If its mildly useful for your daily desktop bing searches though, have at it!

TODO: Write better developer instructions

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tderanek/binger. This project is intended to be a safe,
welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Binger project’s codebase and issue trackers is expected to follow the [code of conduct](https://github.com/tderanek/binger/blob/master/CODE_OF_CONDUCT.md).
