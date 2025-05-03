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

### Asset Precompilation

If there are any problems with assets such as images, try precompiling them again:

`bin/rails assets:precompile`

----

### Regenerating the Production Database

If the production data needs to be reseeded, run the following from the project root:

```bash
heroku config:set DISABLE_DATABASE_ENVIRONMENT_CHECK=1
heroku run rails db:seed:replant
heroku config:unset DISABLE_DATABASE_ENVIRONMENT_CHECK=1
```

----

### Sitemap Management

The sitemap is stored in the repository and should be updated when routes or content changes.
A `bin/regen-sitemap` script is provided to regenerate the sitemap. 
After running it, the public/sitemap* files need to be git added, committed, and pushed.

---

### Git Pre-commit Hook: Production Data File Freshness

This project includes a pre-commit git hook to ensure that the versioned production SQLite data file (`db/data.sqlite3`) is always up to date and included in your commits.

#### What the Hook Does
- Before every commit, the hook runs `rake db:check_production_data_file_stale` to check if `db/data.sqlite3` is missing or stale (i.e., if any migration, YAML, or `db/seeds.rb` file is newer).
- If the data file is missing or stale, the commit is blocked and you will see instructions to update the file.
- The hook also checks that the up-to-date data file is either already committed or staged for commit. If not, it will instruct you to add it.

#### How to Install the Hook

Run the following command:

```sh
bash scripts/git-hooks/install-hooks.sh
```

This will create a symlink from `.git/hooks/pre-commit` to `scripts/git-hooks/pre-commit` and ensure the hook is executable.

#### What to Do If the Commit Is Blocked

If you see a message like:

```
Pre-commit hook: db/data.sqlite3 is missing, stale, or an error occurred.
To resolve: run RAILS_ENV=production rails db:setup and commit the updated db/data.sqlite3 file.
```

Run:
   ```sh
   RAILS_ENV=production rails db:setup && git add db/data.sqlite3
   ```

...and then try your commit again.

This ensures your production data file is always in sync with your migrations and seed data.

---

### Old Note Re: Running Locally in Production Mode

This is an old note, may no longer be true:

* To run this in production locally, the environment variable RAILS_SERVE_STATIC_FILES must be set to true.
