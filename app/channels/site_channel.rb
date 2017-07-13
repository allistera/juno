class SiteChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'status'
  end
end
