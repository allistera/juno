# frozen_string_literal: true

json.array! @slack_settings, partial: 'slack_settings/slack_setting', as: :slack_setting
