# README

# Deployment Notes

### Moving Away From Webpacker
Now that @marcoroth has moved the application away from webpacker, the deployment approach and instructions have changed. 

Here are Marco's words:

----

Hey @keithrbennett, this pull request removes webpacker and replaces it with esbuild, dartsass and the asset pipeline.

* esbuild via jsbundling-rails handles the JavaScript
* dartsass-rails handles the scss compilation
* and the asset pipeline handles the images

When you pull down this branch, make sure to yarn install and bundle install . Going forward you'd want to run your application using bin/dev instead of rails s and bin/webpack-dev-server. The Procfile.dev file defines all the proccess the app needs to run. By running bin/dev it will launch all these processes for you!

It seems that everything is working as before, but in case it's not, let me know! I hope this helps!

----

Of course, if the data base is not set up, that will need to be done as well.

----

If there are any problems with assets such as images, try precompiling them again:

`bin/rails assets:precompile`
ß
----

### Sitemap Management

The sitemap is stored in the repository and should be updated when routes or content changes.
A `bin/regen-sitemap` script is provided to regenerate the sitemap. 
After running it, the public/sitemap* files need to be git added, committed, and pushed.

### Old Note Re: Running Locally in Production Mode

This is an old note, may no longer be true:

* To run this in production locally, the environment variable RAILS_SERVE_STATIC_FILES must be set to true.
