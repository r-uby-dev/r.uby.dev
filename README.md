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

Welcome to the r.uby.dev website. <br>
r.uby.dev is the home of the r.uby.dev chatbot. <br> It is connected to the
[llm.rb](https://github.com/r-uby-dev/llm#readme),
[mruby-llm](https://github.com/r-uby-dev/mruby-llm#readme)
and [r.uby.dev](https://github.com/r-uby-dev/r.uby.dev#readme)
repositories via GitHub's MCP server. <br> The chatbot can answer
any queries you might have related to any of those three projects.

## How does it work?

The chatbot is an [llm.rb](https://github.com/r-uby-dev/llm) agent. <br> The agent
is backed by an ActiveRecord model under the hood. <br> It also uses
[Roda (web toolkit)](https://github.com/jeremyevans/roda#readme),
[roda-sse (stream)](https://github.com/havenwood/roda-sse#readme),
and [Falcon (web server)](https://github.com/socketry/falcon#readme)

## FreeBSD

The [r.uby.dev website](https://r.uby.dev) website is designed to
be deployed on FreeBSD. It has a `Makefile` for this purpose, and
it also has an rc.d script that the `make install` target copies
into `/usr/local/etc/rc.d`. The rc.d script can be configured from
`/etc/rc.conf` and certain variables must be set before the web
application will be able to boot successfully.

The database is expected to be postgresql with `jsonb` support. <br>
It can be configured from `config/database.yml`.

## License

This software is released under the terms of the MIT license. <br>
See [LICENSE](./LICENSE) for details.
