# BGM FxOS Server

## deploy to Heroku
[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy?template=https://github.com/masawada/bgm-fxos-server)

or execute these commands:

```
heroku create <APP_NAME>
heroku config:add BUILDPACK_URL=git://github.com/ddollar/heroku-buildpack-multi.git
git push heroku master
heroku ps:scale web=1
```
