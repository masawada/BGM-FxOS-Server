# BGM FxOS Server

## deploy to Heroku
```
heroku create <APP_NAME>
heroku config:add BUILDPACK_URL=git://github.com/ddollar/heroku-buildpack-multi.git
git push heroku master
heroku ps:scale web=1
```
