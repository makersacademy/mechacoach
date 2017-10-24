# Mechacoach

![Mechacoach as a Braintree entity](docs_images/mechacoach.gif)

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

1. Create a .txt file that lists all the people in the cohort.  One full name per line, no quotation marks.  One good source of this information is the GitHub [team](https://github.com/orgs/makersacademy/teams) for your cohort.  Check with onboarding that the list doesn't include any people who have dropped out of the pre course.

2. Generate a list of pair assignments using [Makers Toolbelt.](https://github.com/makersacademy/toolbelt) You can either follow the instructions on the Toolbelt repo [README](https://github.com/makersacademy/toolbelt/blob/master/README.md) or do the following:

```bash
$ gem install makers_toolbelt

$ makers generate_pairs [file] # [file] being the .txt file you made in step 1
```

3. Upload the pair assignments to Mechacoach.  Go to http://mechacoach.herokuapp.com/pairs/load and enter the cohort name **(must match the cohort Slack channel name)** and the pair assignments file (made in step 2) to upload.

4. Create a notification schedule in the [pair assignment Google Calendar](https://www.google.com/calendar/embed?src=makersacademy.com_evddbhj972183cdquke82v10o0%40group.calendar.google.com&ctz=Europe/London).  Use a recurring event(s) to generate the schedule (you can delete exceptions for bank holidays etc.).  The event summary must be the exact cohort Slack channel name.

Zapier tracks the Google Calendar.  Fifteen minutes before each calendar event, Zapier makes a POST request to `/pairs/release`.  This posts the next pair assignments in the sequence to the cohort Slack channel.

Once all of the pair assignments have been exhausted, Mechacoach will cycle back to the first.

##### Triggering pair posting manually

If for some reason you want to trigger a new, unscheduled pair assignment to post to slack, you can use the curl from the command line as follows (substitute cohort-slack-channel with the exact students slack channel):

```
curl -X POST -F 'cohort=cohort-slack-channel' http://mechacoach.herokuapp.com/pairs/release
```

##### Manually changing the pairs

If you want to change the pairs – for instance, if a student has asked not to work with another student – you will need to connect to Mechacoach's Redis data store via the command-line, copy the existing data, change it, and then re-submit it to Mechacoach via the [pair loader](http://mechacoach.herokuapp.com/pairs/load). Here are the instructions:

1. Install heroku-cli and use it to install heroku-redis, with `heroku plugins:install heroku-redis`.
2. Connect to Mechacoach Redis with `heroku redis-cli`. If you see an error due to a missing app name, add `--app mechacoach` to the command.
3. Redis will ask you to type `mechacoach` to be able to access the data. Do that.
4. Fetch the pairs from the Redis data store using the command `get "<cohort-slack-channel>_pairs"`. For instance, if the cohort Slack channel is `september2017`, then you would type `get "september2017_pairs"`.
5. Copy the output, which should be an array of arrays (of arrays), to a text editor.
6. Swap any pairs you see fit. **Avoid deleting pairs**, unless you have to for some reason.
7. Save the file with the suffix `.txt`, head to the [pair loader](http://mechacoach.herokuapp.com/pairs/load) and upload the file, with the cohort Slack channel, as you did before.
8. Verify the new pairs in the Redis CLI with the command `get "<cohort-slack-channel>_pairs"`. You should see your new pairs in the place of the old ones.
9. Exit the Redis CLI. You're done!

### Setting up Slack

Mechacoach requires an integrated webhook to be set up in slack, via the path https://[your-team].slack.com/apps => Browse Apps => Custom Integrations => Incoming WebHooks. Generate the webhook and copy the generated path into heroku config vars.

### Distributing Code Review Summaries

1. Create a Zap that links the google form responses sheet to Mechacoach web hook, e.g. https://zapier.com/app/editor-original/6284227
  - it helps to add dev@makersacademy.com as a collaborator to the spreadsheet so that it appears at the top of the list in the zap
  - don't forget to update the mechacoach URL
2. Update `config/submit_challenge_review.config` to include relevant document and sheet id from google form responses, and name of repo, e.g.

```
rps-challenge:
  document_id: 1iUOogNEaOrD1VjZd-1Zqf_xRDZtdIvYwez91eQKVRH0
  worksheet_id: 299100708
```

Ensure the sheet column headings for the meta information match:

```
whatistherevieweesgithubusername,
yourname,
whosechallengeareyoureviewing,
didyoufindthisformusefulincompletingthereview,
anyadditionalcommentsonthecodeyoureviewed,
timestamp,
features,
bonusfeatures,
adddetailsofyouralternateapproachtothereviewifyouskippedtherest
```

## Getting Set Up

- Fill a `.env` file with delicious credentials from LastPass, I guess. Mechacoach uses [Dotenv](https://github.com/bkeepers/dotenv) for secret stuff, like webhooks.
- If you want to test pairing functionality, make sure you've run `redis-server`.

## Extending Mechacoach

Do it, man. Just follow [this stuff](contributing.md) when doing so.

If you wanna write new Slack messages, you can use the formatting provided in the [slack-notifier readme](https://github.com/stevenosloan/slack-notifier).
