[![License: CC0-1.0](https://img.shields.io/badge/License-CC0%201.0-lightgrey.svg)](http://creativecommons.org/publicdomain/zero/1.0/)

# Making-a-secure-web-app
The final project (undertaken during the last 2 weeks) of the Makers Academy course. The aim of this project was to gain an understanding in cyber security. A simple web app was developed (a basic twitter clone) with a test driven approach using few libraries and no frameworks. Employing a 'from the ground up' approach created various challenges which lead to the need for a custom-built HTML/Ruby templating-engine, ORM, http-server/middleware and hashing algorithm. This was to bypass the inherent security features implemented by well developed libraries/frameworks, allowing the app to be used as an environment to discover, exploit and document various security vulnerabilities. Subsequently this knowledge was used to develop suitable countermeasures.

---

### Prerequisites

- ruby v2.4.1

  get latest version here: https://www.ruby-lang.org/en/downloads/

- PostgreSQL v10.1

  get here: https://gist.github.com/sgnl/609557ebacd3378f3b72

- Mozilla Firefox (for capybara tests)

  get latest version here: https://www.mozilla.org/en-GB/firefox/new/

---

### Setup
Getting the repo:
```
$ git clone https://github.com/LarsFin/Making-a-secure-web-app.git
$ cd Making-a-secure-web-app
```

Configuring environment:
```
$ gem install bundler
$ ruby db-reset.rb
$ bundle install
```

Running app:
```
$ ruby server.db
```
-> then visit
```
https://localhost:3000
```

What you should see
![user_experience](/public/user_experience.gif?raw=true)

Links to flow diagrams:
[request/response cycle](/public/high_lvl_req_res_lifecycle.png),
[control flow diagram](/public/req_res_lifecycle_activity.png)

---

### Running the tests

Tested in rspec with capybara using selenium webdriver. 100% test coverage (evaluated by SimpleCov).

Test suite consists of:
- regression tests (for known vulnerabilities)
- unit tests
- feature tests

*all tests used to expose vulnerabilities do not run but are stored in spec/hacks folder.*

Running tests:
```
$ rspec
```

![test screenshot](/public/tests.png?raw=true)

---

#### Acknowledgements

A few sites that gave us insight into well-known hacking techniques.
- https://www.owasp.org/index.php/OWASP_Top_Ten_Cheat_Sheet
- https://arstechnica.com/tech-policy/2011/02/anonymous-speaks-the-inside-story-of-the-hbgary-hack/
- https://hackthissite.org
