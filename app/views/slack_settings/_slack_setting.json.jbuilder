json.extract! slack_setting, :id, :webhook_url, :channel, :username, :project_id, :created_at, :updated_at
json.url slack_setting_url(slack_setting, format: :json)
