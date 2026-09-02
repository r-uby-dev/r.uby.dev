## Introduction

My name is Robert Gleeson.

I am a software engineer specializing in Ruby, AI infrastructure,
and systems programming. I have 15 years of professional
experience building production-grade software in Ruby, JavaScript,
TypeScript, and C. I have worked across the stack: from large Rails
monoliths to Ruby microservices to privacy-focused browser
extensions with more than 100,000 users.

---

## Open source

For three years I have worked on an advanced agentic AI
runtime known as <a href="https://github.com/r-uby-dev/llm#readme">llm.rb</a>
that is both open source and battle tested in production environments.
I am a long time open source contributor who is a former member of Pry's
core team and I have also made smaller contributions to mruby and other
projects in the Ruby ecosystem.

My open source contributions span 15 years and my most recent
contributions include commits to a fork of FreeBSD known as HardenedBSD
where I have been able to exercise my skills in languages such as C, Go
and POSIX shell.

---

## Websites

**[4.4bsd.dev](https://4.4bsd.dev)**

4.4bsd.dev provides a free service that is designed to help users learn
and troubleshoot FreeBSD. It can run commands like man(1), apropos(1)
and pkg-search(8) to find an answer to a user's question.

**[r.uby.dev](https://r.uby.dev)**

r.uby.dev provides a free service that is designed to help users learn
and trouble the llm.rb runtime that I authored. I created this website
so that new llm.rb users could learn how to use it quickly.

---

## Experience

### Oyster

**Senior Software Engineer:** 2022-2026

I was the most senior engineer on the 4-5 person AI team, outside the
team lead, and I led the initiative that replaced the company's Python
chatbot with a Ruby system built on
[llm.rb](https://github.com/r-uby-dev/llm) (the open source runtime
that I authored). The migration was my idea, and I supplied the runtime.
The replacement ran inside the Rails application instead of a separate
Python service.

- Cut responses from 15-20 seconds to 2-3 seconds.
- Cut operation costs by moving the chatbot inside a monolith Rails application.
- Enabled streaming and tool calls that the old system did not support.
- Enabled the chatbot to perform actions on the site through tool calls.
- Connected the chatbot to vector stores, internal APIs, and MCP servers.
- Made the chatbot embeddable by third parties on their own websites.
- The chatbot handled more than 7,000 conversations by the time I left.

### Hubstaff

**Senior Software Engineer:** 2019-2022

Backend engineer across Hubstaff's three Rails applications: the time
tracking monolith, Hubstaff Tasks (project management), and the OAuth SSO
application (also Rails) that joined the two.

- Built a Google Calendar-style scheduling system with recurring events and conflict detection.
- The calendar served thousands of users with data scoped per company.
- Maintained the high-traffic HTTP API used by the desktop time-tracking clients.
- Worked on time tracking, payroll reporting, billing, and team management in the monolith.
- Worked on Hubstaff Tasks, the project management tool.
- Maintained the OAuth SSO application shared by all three applications.
- Audited the OAuth SSO application for security issues.

### Private Internet Access

**Senior Software Engineer:** 2014-2019

Backend engineer at Private Internet Access, one of the most popular VPN
services at the time. I helped maintain the monolith Rails application
that served hundreds of thousands of users per month.

- Authored the Chrome extension that connected users to PIA's HTTPS proxy services.
- Ported the extension to Firefox.
- Built the extension entirely by myself; it served more than 100,000 users.
- Hardened browser features for security and privacy.
- Blocked camera and microphone access.
- Disabled third-party cookies before browsers made that the default.
- Worked on the desktop application, written in a mixture of Ruby, C, and node-webkit.
- Maintained the Rails application behind customer accounts, subscriptions, and payments.
- Translated the website into more than 14 languages.
- Performed SEO optimizations.

### General Assembly

**Software Engineer:** 2011-2014

Backend engineer on General Assembly's education platform, my first job.
It grew into a large Rails monolith, with microservices powered by
webmachine-ruby, an Erlang-inspired web toolkit.

- Built microservices with webmachine-ruby.
- Made small contributions to webmachine-ruby on General Assembly's behalf.
- Later became a member of the webmachine-ruby organization.
- Helped engineer the payment system for courses and workshops, online and offsite.
- Worked on the video platform that streamed courses.
- Built an anonymous student feedback and survey system.
- Upgraded the platform from Rails 2 to Rails 3 and Ruby 1.8 to Ruby 1.9.
- Attended engineering meetups at the NYC office.