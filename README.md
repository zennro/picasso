# About

Picasso is a bunch of tools glued together. Beware.

It is a sinatra app, feeding data through POSTs into a sqlite3 database, then
pulling them out into a single-page dashboard based on cubism.js.

There is a hidden assumption: all data sources have same step between data
points - 5 minutes by default, configurable. This might or might not be an
issue. In the worst case, multiple apps could be set up each with different
step. This would make the observation of the same effects across different time
scales easy.

## Install

Make sure you have a recent ruby installed. ```.ruby-version``` specifies ruby
2.1, but there is nothing funky in the code, so older rubies should work(TM). To
install dependencies, simply run

    $ bundle

## Usage

1. Check the ```config/settings.rb``` and add the ```['data source', 'variable name']```
pairs into the data_sources list. E.g. ```['server1', 'CPU']```. Please change
the user/pass for HTTP post updates.

2. Start the server:

    ```$ bundle exec puma config.ru```

3. Post some data:

    ```$ curl -u 'api:b7273d35bb1926e56a9671fca815c99b' -X POST "http://localhost:9292/data/server1/CPU/$(date +%s)000/$(awk -F' ' '{print $1 }' /proc/loadavg)"```

See API below for details.

4. Check the dashboard:

    ```$ firefox "http://localhost:9292"```

5. Profit

## Bugs & features

If you find a bug or would like to add a feature, please create a ticket on
github, I'll see what can be done about it.

Additionally, I'm really happy for any pull requests and this project is open
to changes. Send them in!

## License

Feel free to do whatever you want with it, just check the licenses of the tools
used. If you like the app, ping me on twitter (@balazs_kutil) with a link to
your project, so I can check what kind of cool metrics you track.

## API

### POST /data/:tag/:variable/:timestamp/:value

    tag       (string)    - an identifier (e.g. of a sensor/server), 255 chars limit in DB
    variable  (string)    - what we are measuring, 255 chars limit in DB
    timestamp (integer)   - unix timestamp in miliseconds (Javascript Date.now() equivalent)
    value     (float/int) - variable value

### GET /data/:tag/:variable/:from/:to/:step

    tag         - the identifier
    variable    - select values of this variable
    from, to    - integer timestamps (as returned by Date.now() in javascript)
    step        - data step between the samples

Returns JSON:

    [
      [t1, x1],
      [t2, x2],
      [t3, x3],
      ..
      [tn, xn], // Timestamp, value pairs corresponding to values of a variable in the from, to interval
    ]
