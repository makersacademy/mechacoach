# Mechacoach Instructions

### Setting up automated pair assignment postings

Mechacoach will automatically post pair assignments to student cohort Slack channels.  To set this up for a cohort, follow these steps:

1. Create a .txt file that lists all the people, by their formatted slack IDs (eg: `<@U0AHW79T3>`) , one per line, no quotation marks. Use the [Slack ID view](https://airtable.com/tblaz3KrnKt9qQM8I/viwBk9LJ5OAdJqul8?blocks=hide) on the students table in airtable. Mechacoach uses [slack-notifier](https://github.com/stevenosloan/slack-notifier) to post data to the [slack API](https://api.slack.com/reference/surfaces/formatting#advanced).  Double check with admissions that the list doesn't include any people who have dropped out of the pre course.

2. Generate a list of pair assignments using [Makers Toolbelt.](https://github.com/makersacademy/toolbelt) You can either follow the instructions on the Toolbelt repo [README](https://github.com/makersacademy/toolbelt/blob/master/README.md) or do the following:

```bash
$ gem install makers_toolbelt

$ makers generate_pairs [file] # [file] being the .txt file you made in step 1
```

3. Upload the pair assignments to Mechacoach.  Go to http://mechacoach.herokuapp.com/pairs/load
    1. enter the cohort name **(must match the cohort Slack channel name)** 
    2. select the Slack team
    3. upload the pair assignments file (made in step 2). (You should see confirmation or a hopefully helpful error message)

4. Create a notification schedule in the [pair assignment Google Calendar](https://www.google.com/calendar/embed?src=makersacademy.com_evddbhj972183cdquke82v10o0%40group.calendar.google.com&ctz=Europe/London).  Use a recurring event(s) to generate the schedule (you can delete exceptions for bank holidays etc.).  
    - **IMPORTANT**
      - The event summary must be the exact cohort Slack channel name.
      - The event description must be the exact Slack team name.

Zapier looks at the Google Calendar every 5mins.  Roughly fifteen minutes before each calendar event, Zapier makes a POST request to `/pairs/release` with parameters taken from the event summary & description. This posts the next pair assignments in the sequence to the cohort Slack channel.

Once all of the pair assignments have been exhausted, Mechacoach will cycle back to the first.

### Triggering pair posting manually

If for some reason you want to trigger a new, unscheduled pair assignment to post to slack, you can use curl from the command line, making the two following substitutions:

* `<cohort-slack-channel>` should be replaced with the exact students slack channel
* `<slack-team>` should be replaced with `makersstudents` for academy, or `makersapprenticeships` for apprenticeships.

```
curl -X POST -F 'cohort=<cohort-slack-channel>' -F 'team=<slack-team>' http://mechacoach.herokuapp.com/pairs/release
```

Example:

```
curl -X POST -F 'cohort=july2019' -F 'team=makersstudents' http://mechacoach.herokuapp.com/pairs/release
```

### Manually changing the pairs

If you want to change the pairs – for instance, if a student has asked not to work with another student – you will need to connect to Mechacoach's Redis data store via the command-line, copy the existing data, change it, and then re-submit it to Mechacoach via the [pair loader](http://mechacoach.herokuapp.com/pairs/load). Here are the instructions:

1. Install heroku-cli and use it to install heroku-redis, with `heroku plugins:install heroku-redis`.
2. Connect to Mechacoach Redis with `heroku redis:cli`. If you see an error due to a missing app name, add `--app mechacoach` to the command.
3. Redis will ask you to type `mechacoach` to be able to access the data. Do that.
4. Fetch the pairs from the Redis data store using the command `get "<cohort-slack-channel>_pairs"`. For instance, if the cohort Slack channel is `september2017`, then you would type `get "september2017_pairs"`.
5. Copy the output, which should be an array of arrays (of arrays), to a text editor.
6. Swap any pairs you see fit. **Avoid deleting pairs**, unless you have to for some reason.
7. Save the file with the suffix `.txt`, head to the [pair loader](http://mechacoach.herokuapp.com/pairs/load) and upload the file, with the cohort Slack channel, as you did before.
8. Verify the new pairs in the Redis CLI with the command `get "<cohort-slack-channel>_pairs"`. You should see your new pairs in the place of the old ones.
9. Exit the Redis CLI. You're done!

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
