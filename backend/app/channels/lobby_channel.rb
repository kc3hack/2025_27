class LobbyChannel < ApplicationCable::Channel
  def subscribed
    lobby_id = params[:room]
    stream_from "lobby_#{lobby_id}"
    nickname = params[:nickname]
    select_avatar = params[:select_avatar]

    # 購読者リストを取得して更新
    players = Rails.cache.fetch("players_#{lobby_id}") { [] }
    players << { nickname: nickname, image: select_avatar }
    Rails.cache.write("players_#{lobby_id}", players)
    Rails.logger.info "✅ Subscribed to lobby_#{lobby_id}"

    # ルームにいるプレイヤーリストを全員にブロードキャスト
    broadcast_players(lobby_id)
  end

  def unsubscribed
    lobby_id = params[:room]
    nickname = params[:nickname]
    select_avatar = params[:select_avatar]

    # 購読者リストから削除
    players = Rails.cache.fetch("players_#{lobby_id}") { [] }
    players.reject! { |player| player[:nickname] == nickname }
    Rails.cache.write("players_#{lobby_id}", players)

    # 更新後のプレイヤーリストを全員にブロードキャスト
    broadcast_players(lobby_id)
  end

  def receive(data)
    lobby_id = params[:room]

    if data["type"] == "image" && data["data"].start_with?("data:image/")
      ActionCable.server.broadcast("lobby_#{lobby_id}", {
        type: "image",
        data: data["data"]
      })
    elsif data["text"].present?
      ActionCable.server.broadcast("lobby_#{lobby_id}", {
        type: "text",
        text: data["text"]
      })
    else
      Rails.logger.error "Invalid data received: #{data.inspect}"
    end
  end

  def start_game(data)
    ActionCable.server.broadcast("lobby_#{params[:room]}", {
      type: "text",
      data: {
        command: "start_game",
        game_master: data["nickname"]
      }
    })
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
