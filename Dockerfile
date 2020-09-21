FROM elixir:1.10.4-alpine

ENV APP_HOME /app
RUN mkdir -p $APP_HOME

COPY config/ $APP_HOME/config
COPY lib/ $APP_HOME/lib
COPY priv/ $APP_HOME/priv
COPY *.exs mix.lock run_server.sh $APP_HOME/

WORKDIR ${APP_HOME}

RUN mix local.hex --force && mix local.rebar --force && mix deps.get && mix deps.compile

CMD ["./run_server.sh"]
