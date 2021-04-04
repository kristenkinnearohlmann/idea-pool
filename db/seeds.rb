# Kristen records
kko = User.create(email: "kristenkinnearohlmann@gmail.com", password: "abc123", full_name: "Kristen Kinnear-Ohlmann")
kko.ideas << Idea.create(name: "Weather app", description: "Sources weather from NWS at the command line", is_private: false)
kko.projects << Project.create(name: "CLI Weather", description: "Ruby command line application that uses a geolocation API to load proper webpage for scraping and display", main_language: "Ruby", github_repo: "https://github.com/kristenkinnearohlmann/cli-weather", is_private: false)
i = Idea.find_by(name: "Weather app")
p = Project.find_by(name: "CLI Weather")
i.projects << p

kko.ideas << Idea.create(name: "GitHub repo reviewer", description: "Allows a user to check their repos on GitHub", is_private: false)
kko.projects << Project.create(name: "GitHub API Check Repos", description: "Accesses GitHub API and lists all of your repos", main_language: "Python", github_repo: "https://github.com/kristenkinnearohlmann/githubapi-checkrepos", is_private: false)
i = Idea.find_by(name: "GitHub repo reviewer")
p = Project.find_by(name: "GitHub API Check Repos")
i.projects << p

kko.ideas << Idea.create(name: "Open source ideas site", description: "Users can pool ideas for school and side-hustle projects", is_private: false)
kko.projects << Project.create(name: "Idea Pool", description: "Resource for ideas and projects", main_language: "Ruby", github_repo: "https://github.com/kristenkinnearohlmann/idea-pool", is_private: true)
i = Idea.find_by(name: "Open source ideas site")
p = Project.find_by(name: "Idea Pool")
i.projects << p

kko.ideas << Idea.create(name: "Cat fan club", description: "Some way for people to exchange info and pictures of their cats, like baseball cards", is_private: true)

# Kenneth Parcell records
kenneth = User.create(email: "kparcell@nbc.com", password: "mrjordan2012", full_name: "Kenneth Ellen Parcell")

kenneth.projects << Project.create(name: "Bird internet", description: "It will save the show", main_language: "Swift", github_repo: nil, is_private: true)
p = Project.find_by(name: "Bird internet")
i = Idea.find_by(name: "Open source ideas site")
i.projects << p

kenneth.projects << Project.create(name: "NBC Weather", description: "It tells you all about the weather", main_language: "Go", github_repo: nil, is_private: false)
p = Project.find_by(name: "NBC Weather")
i = Idea.find_by(name: "Weather app")
i.projects << p

# The Oatmeal records (Matthew Inman)
# - Joyful Fireflies - The Oatmeal - Web cartoonist Matthew Inman 
oatmeal = User.create(email: "oatmealsupport@gmail.com", password: "explodingkitten2020", full_name: "Matthew 'The Oatmeal' Inman")

oatmeal.ideas << Idea.create(name: "Joyful Fireflies", description: "Something uplifting of beauty", is_private: false)