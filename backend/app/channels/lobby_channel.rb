class LobbyChannel < ApplicationCable::Channel
  def subscribed
    lobby_id = params[:lobby]
    stream_from "lobby_#{lobby_id}"
    nickname = params[:nickname]
    # 購読者リストを取得して更新
    players = Rails.cache.fetch("players_#{lobby_id}") { [] }
    players << { nickname: nickname, image: "https://placehold.jp/150x150.png" }
    Rails.cache.write("players_#{lobby_id}", players)
    Rails.logger.info "✅ Subscribed to lobby_#{lobby_id}"
    # ルームにいるプレイヤーリストを全員にブロードキャスト
    broadcast_players(lobby_id)
  end

  def unsubscribed
    hashed_lobby = params[:lobby]
    nickname = params[:nickname]

    # 購読者リストから削除
    players = Rails.cache.fetch("players_#{hashed_lobby}") { [] }
    players.reject! { |player| player[:nickname] == nickname }
    Rails.cache.write("players_#{hashed_lobby}", players)

    # 更新後のプレイヤーリストを全員にブロードキャスト
    broadcast_players(hashed_lobby)
  end

  def receive(data)
    hashed_lobby = params[:lobby]

    if data["type"] == "image" && data["data"].start_with?("data:image/")
      ActionCable.server.broadcast("lobby_#{hashed_lobby}", {
        type: "image",
        data: data["data"]
      })
    elsif data["text"].present?
      ActionCable.server.broadcast("lobby_#{hashed_lobby}", {
        type: "text",
        text: data["text"]
      })
    else
      Rails.logger.error "Invalid data received: #{data.inspect}"
    end
  end

  def start_game(data)
    ActionCable.server.broadcast("#{params[:lobby]}", {
      type: "text",
      data: {
        command: "start_game"
      }
    })
    TimerJob.start_countdown(params[:lobby], 60)
  end

  private

  def broadcast_players(lobby)
    players = Rails.cache.fetch("players_#{lobby}") { [] }
    ActionCable.server.broadcast("lobby_#{lobby}", {
      type: "text",
      data: {
        command: "get_players",
        players: players
      }
    })
  end
end
