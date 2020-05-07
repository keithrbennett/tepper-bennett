## Ubuntu 18.10 Setup

### NodeJS Version Errors

To install a nodejs version recent enough to work you may need to follow the instructinos at [https://linuxize.com/post/how-to-install-node-js-on-ubuntu-18.04/](https://linuxize.com/post/how-to-install-node-js-on-ubuntu-18.04/).


### Creating the Postgres Role

Even though the data base is not used at this time, a dummy connection is created and used, so you will need to do a `rails db:setup`, possibly preceded by `rails db:migrate`. When you do, if you get an error like this:

`PG::ConnectionBad: FATAL:  role "kbennett" does not exist`

Do this:

`sudo -u postgres psql -c "create user kbennett with createdb"`


### Removing tzinfo Warnings

`bundle config [--local] disable_platform_warnings true`

See [https://maxwellholder.com/2019/01/04/tzinfo-data-warning.html](https://maxwellholder.com/2019/01/04/tzinfo-data-warning.html).


### Install Heroku CLI

* Ubuntu - `sudo snap install --classic heroku`
* Mac OS - `brew install heroku`


### Setting the Heroku CLI Default Application

Do this to eliminate the need to specify the app on the `heroku` command line:

```
git remote add heroku git@heroku.com:tepper-bennett.git
git config heroku.remote heroku
```


### Set the Custom Domains

```
heroku domains:add tepper-bennett.com 
heroku domains:add www.tepper-bennett.com
heroku domains:add heroku.tepper-bennett.com
```

### Bootstrap Installation & Configuration

This is the best of many articles about this:

[https://gorails.com/episodes/how-to-use-bootstrap-with-webpack-and-rails](https://gorails.com/episodes/how-to-use-bootstrap-with-webpack-and-rails)


### Eliminating Ruby Warnings

`export RUBYOPT=-W:no-deprecated`


### Mysterious Web Browser Behavior

Firefox on the Mac was not successfully displaying this web site, instead showing a Heroku error page saying that the app did not exist. This was left over from a previous error that was since fixed. The solution was to delete all Cloudflare cookies.


### SSL/TLS

It is important _not_ to set config.force_ssl to true in production.rb because Cloudflare accesses the
Heroku app without SSL and does the https conversion before serving to the user. (TODO: check this)

On the Cloudflare dashboard, go to SSL/TLS, then Edge Certificates. Set Always Use HTTPS to on.


### Cloudflare "Development Mode"

This mode disables any cache on the Cloudflare servers so that the Heroku servers are contacted
for every request and any changes to the app are available as soon as the Heroku app is built.
Remember to turn this mode off when the app is no longer being changed frequently.

Since Cloudflare is doing the caching, disabling the cache may result in much more traffic to Heroku.

This setting is on the "Overview" panel of the Cloudflare dashboard.
