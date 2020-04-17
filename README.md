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

**Important:** We're currently using a **legacy** slack integration - which they still support for now.
https://api.slack.com/custom-integrations/incoming-webhooks

Currently the Apprenticeships legacy integration configuration is here: https://makersapprenticeships.slack.com/services/BD4KBU4AG

To test the Apprenticeships slack team webhook:

```bash
<<<<<<< HEAD
curl -X POST -H 'Content-type: application/json' --data '{"channel":"#testing", "text":"mwahahahahahahaha :blue_heart:", "icon_emoji":":ghost:", "username":"edbot"}' [SLACK WEBHOOK -> check lastpass]
=======
curl -X POST -H 'Content-type: application/json' --data '{"channel":"#testing", "text":"mwahahahahahahaha :blue_heart:", "icon_emoji":":ghost:", "username":"edbot"}' https://hooks.slack.com/services/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
>>>>>>> 2d92d72d586e76553677b9ea25ccbc8f58282b70
```

#### New Webhooks
Mechacoach requires an integrated webhook to be set up in Slack, at the following address:

```
https://[your-team].slack.com/apps
=> Browse Apps
=> Custom Integrations # legacy, they encourage using slack apps. Slack app webhooks unfortunately seem to have no channel override functionality...
=> Incoming WebHooks
```

Generate the webhook and copy the generated path into the [Heroku config vars](https://dashboard.heroku.com/apps/mechacoach).

## Extending Mechacoach

Do it! Just follow [this stuff](contributing.md) when doing so.

If you want to write new Slack messages, you can use the formatting provided in the [slack-notifier readme](https://github.com/stevenosloan/slack-notifier).
