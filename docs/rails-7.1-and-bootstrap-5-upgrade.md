# Rails 7.1 and Bootstrap 5 Upgrade

This document will list the steps taken and lessons learned from doing these upgrades.

### Running Rails New to Create a Skeleton

In order to know what configuration changes are recommended for Rails 7.1, `rails new` will be run with all the flags that would be appropriate for this application:

```
    rails new                          \
      tepper-bennett-rails-7-skeleton  \
    --database=postgresql              \
    --javascript=webpack               \
    --skip-action-cable                \
    --skip-action-mailbox              \
    --skip-action-mailer               \
    --skip-action-text                 \
    --skip-active-job                  \
    --skip-active-storage              \
    --skip-asset-pipeline              \
    --skip-hotwire                     \
    --skip-jbuilder                    \
    --skip-test                        \
    --skip-turbolinks
```
