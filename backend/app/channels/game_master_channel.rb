class GameMasterChannel < ApplicationCable::Channel
  def subscribed
    stream_from "game_master_#{params[:room]}_channel"
  end

  def unsubscribed
  end

  def receive(data)
  end
end
