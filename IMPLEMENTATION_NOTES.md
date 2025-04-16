# Rails 8 Upgrade Guide

This application has been upgraded from Rails 7 to Rails 8. Here are the key changes:

1. Updated Rails version in Gemfile to use `rails ~> 8.0.2`
2. Updated configuration to use Rails 8.0 defaults
3. Updated JS dependencies to be compatible with Rails 8

To run the application after pulling the latest changes:

```bash
bundle install
yarn install
bin/rails db:migrate
bin/dev
```

If you encounter any issues with the upgrade, please check the [Rails 8.0 Release Notes](https://guides.rubyonrails.org/8_0_release_notes.html) for more details.
