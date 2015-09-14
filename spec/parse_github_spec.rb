require 'parse_github'

describe ParseGithub do
  describe '.with' do
    it 'receives payloads from GitHub' do
      expect(described_class).to respond_to(:with).with(1).argument
    end

    it 'extracts an issue number from a payload' do
      expect(described_class.with(example_issue_opening_payload)).to eq test_slack_overflow_issue_number
    end
  end

  private

  def example_issue_opening_payload
    {
      "action": "opened",
      "issue": {
        "url": "https://api.github.com/repos/makersacademy/slack-overflow/issues/#{test_slack_overflow_issue_number}",
        "labels_url": "https://api.github.com/repos/makersacademy/slack-overflow/issues/#{test_slack_overflow_issue_number}/labels{/name}",
        "comments_url": "https://api.github.com/repos/makersacademy/slack-overflow/issues/#{test_slack_overflow_issue_number}/comments",
        "events_url": "https://api.github.com/repos/makersacademy/slack-overflow/issues/#{test_slack_overflow_issue_number}/events",
        "html_url": "https://github.com/makersacademy/slack-overflow/issues/#{test_slack_overflow_issue_number}",
        "id": 73464126,
        "number": test_slack_overflow_issue_number,
        "title": "Spelling error in the README file",
        "user": {
          "login": "baxterthehacker",
          "id": 6752317,
          "avatar_url": "https://avatars.githubusercontent.com/u/6752317?v=3",
          "gravatar_id": "",
          "url": "https://api.github.com/users/sjmog",
          "html_url": "https://github.com/baxterthehacker",
          "followers_url": "https://api.github.com/users/sjmog/followers",
          "following_url": "https://api.github.com/users/sjmog/following{/other_user}",
          "gists_url": "https://api.github.com/users/sjmog/gists{/gist_id}",
          "starred_url": "https://api.github.com/users/sjmog/starred{/owner}{/repo}",
          "subscriptions_url": "https://api.github.com/users/sjmog/subscriptions",
          "organizations_url": "https://api.github.com/users/sjmog/orgs",
          "repos_url": "https://api.github.com/users/sjmog/repos",
          "events_url": "https://api.github.com/users/sjmog/events{/privacy}",
          "received_events_url": "https://api.github.com/users/sjmog/received_events",
          "type": "User",
          "site_admin": false
        },
        "labels": [
          {
            "url": "https://api.github.com/repos/makersacademy/slack-overflow/labels/bug",
            "name": "bug",
            "color": "fc2929"
          }
        ],
        "state": "open",
        "locked": false,
        "assignee": "null",
        "milestone": "null",
        "comments": 0,
        "created_at": "2015-05-05T23:40:28Z",
        "updated_at": "2015-05-05T23:40:28Z",
        "closed_at": "null",
        "body": "It looks like you accidently spelled 'commit' with two 't's."
      },
      "repository": {
        "id": 35129377,
        "name": "public-repo",
        "full_name": "makersacademy/slack-overflow",
        "owner": {
          "login": "baxterthehacker",
          "id": 6752317,
          "avatar_url": "https://avatars.githubusercontent.com/u/6752317?v=3",
          "gravatar_id": "",
          "url": "https://api.github.com/users/sjmog",
          "html_url": "https://github.com/baxterthehacker",
          "followers_url": "https://api.github.com/users/sjmog/followers",
          "following_url": "https://api.github.com/users/sjmog/following{/other_user}",
          "gists_url": "https://api.github.com/users/sjmog/gists{/gist_id}",
          "starred_url": "https://api.github.com/users/sjmog/starred{/owner}{/repo}",
          "subscriptions_url": "https://api.github.com/users/sjmog/subscriptions",
          "organizations_url": "https://api.github.com/users/sjmog/orgs",
          "repos_url": "https://api.github.com/users/sjmog/repos",
          "events_url": "https://api.github.com/users/sjmog/events{/privacy}",
          "received_events_url": "https://api.github.com/users/sjmog/received_events",
          "type": "User",
          "site_admin": false
        },
        "private": false,
        "html_url": "https://github.com/makersacademy/slack-overflow",
        "description": "",
        "fork": false,
        "url": "https://api.github.com/repos/makersacademy/slack-overflow",
        "forks_url": "https://api.github.com/repos/makersacademy/slack-overflow/forks",
        "keys_url": "https://api.github.com/repos/makersacademy/slack-overflow/keys{/key_id}",
        "collaborators_url": "https://api.github.com/repos/makersacademy/slack-overflow/collaborators{/collaborator}",
        "teams_url": "https://api.github.com/repos/makersacademy/slack-overflow/teams",
        "hooks_url": "https://api.github.com/repos/makersacademy/slack-overflow/hooks",
        "issue_events_url": "https://api.github.com/repos/makersacademy/slack-overflow/issues/events{/number}",
        "events_url": "https://api.github.com/repos/makersacademy/slack-overflow/events",
        "assignees_url": "https://api.github.com/repos/makersacademy/slack-overflow/assignees{/user}",
        "branches_url": "https://api.github.com/repos/makersacademy/slack-overflow/branches{/branch}",
        "tags_url": "https://api.github.com/repos/makersacademy/slack-overflow/tags",
        "blobs_url": "https://api.github.com/repos/makersacademy/slack-overflow/git/blobs{/sha}",
        "git_tags_url": "https://api.github.com/repos/makersacademy/slack-overflow/git/tags{/sha}",
        "git_refs_url": "https://api.github.com/repos/makersacademy/slack-overflow/git/refs{/sha}",
        "trees_url": "https://api.github.com/repos/makersacademy/slack-overflow/git/trees{/sha}",
        "statuses_url": "https://api.github.com/repos/makersacademy/slack-overflow/statuses/{sha}",
        "languages_url": "https://api.github.com/repos/makersacademy/slack-overflow/languages",
        "stargazers_url": "https://api.github.com/repos/makersacademy/slack-overflow/stargazers",
        "contributors_url": "https://api.github.com/repos/makersacademy/slack-overflow/contributors",
        "subscribers_url": "https://api.github.com/repos/makersacademy/slack-overflow/subscribers",
        "subscription_url": "https://api.github.com/repos/makersacademy/slack-overflow/subscription",
        "commits_url": "https://api.github.com/repos/makersacademy/slack-overflow/commits{/sha}",
        "git_commits_url": "https://api.github.com/repos/makersacademy/slack-overflow/git/commits{/sha}",
        "comments_url": "https://api.github.com/repos/makersacademy/slack-overflow/comments{/number}",
        "issue_comment_url": "https://api.github.com/repos/makersacademy/slack-overflow/issues/comments{/number}",
        "contents_url": "https://api.github.com/repos/makersacademy/slack-overflow/contents/{+path}",
        "compare_url": "https://api.github.com/repos/makersacademy/slack-overflow/compare/{base}...{head}",
        "merges_url": "https://api.github.com/repos/makersacademy/slack-overflow/merges",
        "archive_url": "https://api.github.com/repos/makersacademy/slack-overflow/{archive_format}{/ref}",
        "downloads_url": "https://api.github.com/repos/makersacademy/slack-overflow/downloads",
        "issues_url": "https://api.github.com/repos/makersacademy/slack-overflow/issues{/number}",
        "pulls_url": "https://api.github.com/repos/makersacademy/slack-overflow/pulls{/number}",
        "milestones_url": "https://api.github.com/repos/makersacademy/slack-overflow/milestones{/number}",
        "notifications_url": "https://api.github.com/repos/makersacademy/slack-overflow/notifications{?since,all,participating}",
        "labels_url": "https://api.github.com/repos/makersacademy/slack-overflow/labels{/name}",
        "releases_url": "https://api.github.com/repos/makersacademy/slack-overflow/releases{/id}",
        "created_at": "2015-05-05T23:40:12Z",
        "updated_at": "2015-05-05T23:40:12Z",
        "pushed_at": "2015-05-05T23:40:27Z",
        "git_url": "git://github.com/makersacademy/slack-overflow.git",
        "ssh_url": "git@github.com:makersacademy/slack-overflow.git",
        "clone_url": "https://github.com/makersacademy/slack-overflow.git",
        "svn_url": "https://github.com/makersacademy/slack-overflow",
        "homepage": "null",
        "size": 0,
        "stargazers_count": 0,
        "watchers_count": 0,
        "language": "null",
        "has_issues": true,
        "has_downloads": true,
        "has_wiki": true,
        "has_pages": true,
        "forks_count": 0,
        "mirror_url": "null",
        "open_issues_count": test_slack_overflow_issue_number,
        "forks": 0,
        "open_issues": test_slack_overflow_issue_number,
        "watchers": 0,
        "default_branch": "master"
      },
      "sender": {
        "login": "baxterthehacker",
        "id": 6752317,
        "avatar_url": "https://avatars.githubusercontent.com/u/6752317?v=3",
        "gravatar_id": "",
        "url": "https://api.github.com/users/sjmog",
        "html_url": "https://github.com/baxterthehacker",
        "followers_url": "https://api.github.com/users/sjmog/followers",
        "following_url": "https://api.github.com/users/sjmog/following{/other_user}",
        "gists_url": "https://api.github.com/users/sjmog/gists{/gist_id}",
        "starred_url": "https://api.github.com/users/sjmog/starred{/owner}{/repo}",
        "subscriptions_url": "https://api.github.com/users/sjmog/subscriptions",
        "organizations_url": "https://api.github.com/users/sjmog/orgs",
        "repos_url": "https://api.github.com/users/sjmog/repos",
        "events_url": "https://api.github.com/users/sjmog/events{/privacy}",
        "received_events_url": "https://api.github.com/users/sjmog/received_events",
        "type": "User",
        "site_admin": false
      }
    }.to_json
  end

  def test_slack_overflow_issue_number
    95
  end
end