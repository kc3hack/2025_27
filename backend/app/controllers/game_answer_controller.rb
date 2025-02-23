class GameAnswerController < ApplicationController
  def create
    image_data = params[:image]
    lobby_id = params[:lobby_id]

    ActionCable.server.broadcast("game_#{lobby_id}", {
      type: "text",
      data: {
        command: "answering"
      }
    })

    ActionCable.server.broadcast("game_#{lobby_id}", {
      type: "text",
      data: {
        command: "receive_image",
        image: image_data,
        answer_nickname: params[:nickname],
        answer_select_avatar: params[:select_avatar]
      }
    })

    render json: {
      message: "Game answer created"
    }
  end
end
