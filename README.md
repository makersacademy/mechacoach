# Mechacoach

Co-locating all the automated coach tasks. Want to automate a task? Extend Mechacoach!

## Why the thing

Mechacoach exists to reduce the time coaches spend doing all the little admin things. Mechacoach intends to save 17.8% of coach time, thus saving 17.8% of coaches. Mechacoach is after your job.

- Family-friendly
- Fully-automated
- Surprisingly tender
- Cool and approachable bedside manner

## What the thing

### Automated pair assignments notification

Mechacoach will automatically post pair assignments to the student cohort Slack channel.  To set this up for a cohort, please follow these steps:

1. Upload the pair assignments to Mechacoach.  Go to http://mechacoach.herokuapp.com/pairs/load and enter the cohort name (must match the cohort Slack channel name) and the pair assignments file to upload (this can be generated using the [Makers Toolbelt](https://github.com/makersacademy/toolbelt)).
2. Create a notification schedule in the [pair assignment Google Calendar](https://www.google.com/calendar/embed?src=makersacademy.com_evddbhj972183cdquke82v10o0%40group.calendar.google.com&ctz=Europe/London).  Use a recurring event(s) to generate the schedule (you can delete exceptions for bank holidays etc.).  The event summary must be the exact cohort Slack channel name.

Each Google Calendar occurrence will trigger a Slack notification of the next pair assignment in the sequence, at the event start time.  Once all of the pair assignments have been exhausted, Mechacoach will cycle back to the first.

### Distributing Code Review Summaries

1. Create a Zap that links a google form to Mechacoach web hook, e.g. https://zapier.com/app/editor-original/6284227
2. Update `config/submit_challenge_review.config` to include relevant document and sheet id from google form responses, and name of repo, e.g.

```
rps-challenge:
  document_id: 1iUOogNEaOrD1VjZd-1Zqf_xRDZtdIvYwez91eQKVRH0
  worksheet_id: 299100708
```

## Getting Started

- Fill a `.env` file with delicious credentials from LastPass, I guess. Mechacoach uses [Dotenv](https://github.com/bkeepers/dotenv) for secret stuff, like webhooks.
- If you want to test pairing functionality, make sure you've run `redis-server`.

## Extending Mechacoach

Do it, man. Just follow [this stuff](contributing.md) when doing so.

If you wanna write new Slack messages, you can use the formatting provided in the [slack-notifier readme](https://github.com/stevenosloan/slack-notifier).
