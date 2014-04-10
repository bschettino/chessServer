class Api::V1::GamesController < ApplicationController

  respond_to :json, :xml

  #params: player_name
  #response: :code, :message, :game_id || :code, :message
  def new
    respond_with({:code => HttpResponse::CODE_ERROR_MISSING_PARAMETER, :message => HttpResponse.code_msg(HttpResponse::CODE_ERROR_MISSING_PARAMETER)}) and return unless params[:player_name]

    begin
      player = Player.where(:name => params[:player_name]).last || Player.create(:name => params[:player_name])
      game = Game.create_game

      game.add_player(player)
      respond_with({:code => HttpResponse::CODE_SUCCESS, :message => HttpResponse.code_msg(HttpResponse::CODE_SUCCESS),
                    :game_id => game.id})
    rescue Exception => e
      respond_with({:code => HttpResponse::CODE_UNKNOWN_ERROR,
                    :message => HttpResponse.code_msg(HttpResponse::CODE_UNKNOWN_ERROR) + e.message})
    end
  end

  #params: player_name, game_id
  #response: :code, :message, :board
  def join
    respond_with({:code => HttpResponse::CODE_ERROR_MISSING_PARAMETER, :message => HttpResponse.code_msg(HttpResponse::CODE_ERROR_MISSING_PARAMETER)}) and return unless params[:player_name] && params[:game_id]

    #begin
      player = Player.where(:name => params[:player_name]).last || Player.create(:name => params[:player_name])
      game = Game.where(:id => params[:game_id]).last
      respond_with({:code => HttpResponse::CODE_GAME_NOT_FOUND, :message => HttpResponse.code_msg(HttpResponse::CODE_GAME_NOT_FOUND)}) and return unless game

      add_return = game.add_player(player)

      if add_return.is_a? Hash
        respond_with({:code => add_return[:code], :message => add_return[:message]})
      else
        respond_with({:code => HttpResponse::CODE_SUCCESS, :message => HttpResponse.code_msg(HttpResponse::CODE_SUCCESS),
                      :board => game.current_board})
      end

    #rescue Exception => e
    #  respond_with({:code => HttpResponse::CODE_UNKNOWN_ERROR,
    #                :message => HttpResponse.code_msg(HttpResponse::CODE_UNKNOWN_ERROR) + e.message})
    #end
  end

  def play

  end

  def show

  end

  def index

  end
end
