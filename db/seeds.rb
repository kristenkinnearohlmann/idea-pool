kko = User.create(email: "kristenkinnearohlmann@gmail.com", password: "abc123", full_name: "Kristen Kinnear-Ohlmann")
kko.ideas << Idea.create(name: "Weather app", description: "Sources weather from NWS at the command line", is_private: false)
# get idea object and set to i then...
i.projects << Project.create(name: "CLI Weather", description: "Ruby command line application that uses a geolocation API to load proper webpage for scraping and display", is_private: false)