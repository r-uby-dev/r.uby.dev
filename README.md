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

> A [r.uby.dev](https://r.uby.dev) project.

Welcome to the r.uby.dev website.

r.uby.dev is the home of the r.uby.dev chatbot. It is connected to the
[llm.rb](https://github.com/r-uby-dev/llm#readme),
[mruby-llm](https://github.com/r-uby-dev/mruby-llm#readme)
and [r.uby.dev (this repository)](https://github.com/r-uby-dev/r.uby.dev#readme)
repositories (via MCP). The chatbot is an [llm.rb](https://github.com/r-uby-dev/llm) agent. The agent
is backed by an ActiveRecord model that uses [`acts_as_agent`](https://r.uby.dev/api-docs/llm.rb/LLM/ActiveRecord/ActsAsAgent.html#acts_as_agent-instance_method)
under the hood. It also uses
[Roda (web toolkit)](https://github.com/jeremyevans/roda#readme),
[roda-sse (stream)](https://github.com/havenwood/roda-sse#readme),
and [Falcon (web server)](https://github.com/socketry/falcon#readme)

The [r.uby.dev website](https://r.uby.dev) website is designed to
be deployed on FreeBSD. It has a `Makefile` for this purpose, and
it also has an rc.d script that the `make install` target copies
into `/usr/local/etc/rc.d`. The rc.d script can be configured from
`/etc/rc.conf` and certain variables must be set before the web
application will be able to boot successfully.

The database is expected to be postgresql with `jsonb` support. It
can be configured from `config/database.yml`.

## License

This software is released under the terms of the MIT license. <br>
See [LICENSE](./LICENSE) for details.
