<p align="center">
  <a href="https://r.uby.dev">
    <img
      src="public/images/rubydev-workmark.svg"
      width="400"
      height="200"
      border="0"
      alt="a r.uby.dev project"
     >
  </a>
</p>

> [r.uby.dev](https://r.uby.dev) project.

Welcome to the r.uby.dev website.

The site runs a chatbot that is an [llm.rb](https://github.com/r-uby-dev/llm#readme)
agent connected to the llm.rb, mruby-llm and r.uby.dev GitHub repositories.
It answers questions about those projects, and its answers are grounded in
their source code (and documentation).

The site is a small Roda application. It uses roda-sse to stream the
chatbot's responses, ActiveRecord with a single jsonb column for each
session, and Falcon as the web server. It is designed to be deployed on
FreeBSD. The Makefile and rc.d script handle the install and deploy, and
the database can be configured from `config/database.yml`.

