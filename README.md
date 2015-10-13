# Mechacoach

Co-locating all the automated coach tasks. Want to automate a task? Extend Mechacoach!

### Why the thing

Mechacoach exists to reduce the time coaches spend doing all the little admin things. Mechacoach intends to save 17.8% of coach time, thus saving 17.8% of coaches. Mechacoach is after your job.

- Family-friendly
- Fully-automated
- Surprisingly tender
- Cool and approachable bedside manner

### Getting Started

- Fill a `.env` file with delicious credentials from LastPass, I guess. Mechacoach uses [Dotenv](https://github.com/bkeepers/dotenv) for secret stuff, like webhooks.
- If you want to test pairing functionality, make sure you've run `redis-server`.

### Extending Mechacoach

Do it, man. Just follow [this stuff](contributing.md) when doing so.

If you wanna write new Slack messages, you can use the formatting provided in the [slack-notifier readme](https://github.com/stevenosloan/slack-notifier).
