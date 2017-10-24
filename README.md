# Mechacoach

A Redis datastore with a Sinatra app. Takes pair files from [Makers Toolbelt](https://github.com/makersacademy/toolbelt) and posts them to a relevant cohort Slack channel.

You're probably here because you want to:

- [Set up pair posting for a new cohort](./INSTRUCTIONS.md#setting-up-automated-pair-assignment-postings)
- [Manually trigger pair posting](./INSTRUCTIONS.md#triggering-pair-posting-manually)
- [Update pairs for a cohort in-flight](./INSTRUCTIONS.md#manually-changing-the-pairs)
- [Distribute code review summaries](./INSTRUCTIONS.md#distributing-code-review-summaries)

If it's anything else, keep reading.

## Getting Set Up

- Fill a `.env` file with delicious credentials from LastPass, I guess. Mechacoach uses [Dotenv](https://github.com/bkeepers/dotenv) for secret stuff, like webhooks.
- If you want to test pairing functionality, make sure you've run `redis-server`.

## Setting up Slack

Mechacoach requires an integrated webhook to be set up in Slack, at the following address:

```
https://[your-team].slack.com/apps
=> Browse Apps
=> Custom Integrations
=> Incoming WebHooks
```

Generate the webhook and copy the generated path into the [Heroku config vars](https://dashboard.heroku.com/apps/mechacoach).

## Extending Mechacoach

Do it! Just follow [this stuff](contributing.md) when doing so.

If you want to write new Slack messages, you can use the formatting provided in the [slack-notifier readme](https://github.com/stevenosloan/slack-notifier).
