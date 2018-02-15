# Making-a-secure-web-app
The final project (undertaken during the last 2 weeks) of the Makers Academy course.
The aim of this project is to gain insight and understanding in cyber security.
A simple web app was created (a basic twitter clone) without the use of frameworks and little use of libraries. This app was then used to exploit and document various security flaws and, importantly, their countermeasures.

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

![sign_in_page](/public/Sign_In.png?raw=true)

Check the posts

![posts_page](/public/Posts.png?raw=true)

---

### Running the tests

Tested in rspec with capybara using selenium webdriver. 100% test coverage evaluated by SimpleCov.

Test suite consists of:
- regression tests (for known vulnerabilities)
- unit tests
- feature tests

Running tests:
```
$ rspec
```

*all tests used to expose vulnerabilities do not run but are stored in hacks folder.*

---

#### Acknowledgements
- https://www.owasp.org/index.php/OWASP_Top_Ten_Cheat_Sheet
- https://arstechnica.com/tech-policy/2011/02/anonymous-speaks-the-inside-story-of-the-hbgary-hack/
- https://hackthissite.org
