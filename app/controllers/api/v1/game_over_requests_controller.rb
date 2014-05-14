class Api::V1::GameOverRequestsController < ApplicationController

  respond_to :json, :xml

  #params: game_id, player_key
  #response: :code, :message, :game_over_request_id
  def won
    respond_with({:code => HttpResponse::CODE_ERROR_MISSING_PARAMETER, :message => HttpResponse.code_msg(HttpResponse::CODE_ERROR_MISSING_PARAMETER)}) and return unless params[:player_key] && params[:game_id]
    begin
      game = Game.where(:id => params[:game_id]).last
      respond_with({:code => HttpResponse::CODE_GAME_NOT_FOUND, :message => HttpResponse.code_msg(HttpResponse::CODE_GAME_NOT_FOUND)}) and return unless game
      gp = game.game_players.where(:player_key => params[:player_key]).last
      respond_with({:code => HttpResponse::CODE_GAME_PLAYER_NOT_FOUND, :message => HttpResponse.code_msg(HttpResponse::CODE_GAME_PLAYER_NOT_FOUND)}) and return unless gp
      gor = game.game_over_requests.where('validation_time is NULL').last
      if gor
        respond_with({:code => HttpResponse::CODE_WAITING_OTHER_PLAYER_VALIDATION, :message => HttpResponse.code_msg(HttpResponse::CODE_WAITING_OTHER_PLAYER_VALIDATION)}) and return if gor.requestor == gp
        legal = (gor.winner == gp.player)
        gor.player_validate(legal)
        respond_with({:code => HttpResponse::CODE_GAME_FINISHED, :message => HttpResponse.code_msg(HttpResponse::CODE_GAME_FINISHED)}) and return if legal
        respond_with({:code => HttpResponse::CODE_REQUEST_REFUSED, :message => HttpResponse.code_msg(HttpResponse::CODE_REQUEST_REFUSED)})
      else
        gor = GameOverRequest.create(:game_id => params[:game_id], :winner_id => gp.player_id, :requestor_id => gp.id)
        respond_with({:code => HttpResponse::CODE_SUCCESS, :message => HttpResponse.code_msg(HttpResponse::CODE_SUCCESS),
                      :game_over_request_id => gor.id})
      end
    rescue Exception => e
      respond_with({:code => HttpResponse::CODE_UNKNOWN_ERROR,
                    :message => HttpResponse.code_msg(HttpResponse::CODE_UNKNOWN_ERROR) + e.message})
    end
  end

  #params: game_id, player_key
  #response: :code, :message, :game_over_request_id
  def lost
    respond_with({:code => HttpResponse::CODE_ERROR_MISSING_PARAMETER, :message => HttpResponse.code_msg(HttpResponse::CODE_ERROR_MISSING_PARAMETER)}) and return unless params[:player_key] && params[:game_id]
    begin
      game = Game.where(:id => params[:game_id]).last
      respond_with({:code => HttpResponse::CODE_GAME_NOT_FOUND, :message => HttpResponse.code_msg(HttpResponse::CODE_GAME_NOT_FOUND)}) and return unless game
      gp = game.game_players.where(:player_key => params[:player_key]).last
      respond_with({:code => HttpResponse::CODE_GAME_PLAYER_NOT_FOUND, :message => HttpResponse.code_msg(HttpResponse::CODE_GAME_PLAYER_NOT_FOUND)}) and return unless gp
      gor = game.game_over_requests.where('validation_time is NULL').last
      if gor
        respond_with({:code => HttpResponse::CODE_WAITING_OTHER_PLAYER_VALIDATION, :message => HttpResponse.code_msg(HttpResponse::CODE_WAITING_OTHER_PLAYER_VALIDATION)}) and return if gor.requestor == gp
        legal = (gor.winner != gp.player)
        gor.player_validate(legal)
        respond_with({:code => HttpResponse::CODE_GAME_FINISHED, :message => HttpResponse.code_msg(HttpResponse::CODE_GAME_FINISHED)}) and return if legal
        respond_with({:code => HttpResponse::CODE_REQUEST_REFUSED, :message => HttpResponse.code_msg(HttpResponse::CODE_REQUEST_REFUSED)})
      else
        winner = game.players - [gp.player]
        winner = winner.last
        gor = GameOverRequest.create(:game_id => params[:game_id], :winner_id => winner.id, :requestor_id => gp.id)
        respond_with({:code => HttpResponse::CODE_SUCCESS, :message => HttpResponse.code_msg(HttpResponse::CODE_SUCCESS),
                      :game_over_request_id => gor.id})
      end
    rescue Exception => e
      respond_with({:code => HttpResponse::CODE_UNKNOWN_ERROR,
                    :message => HttpResponse.code_msg(HttpResponse::CODE_UNKNOWN_ERROR) + e.message})
    end
  end

  #params: game_id
  #response: :code, :message, (:game_over_request_id || :board)
  def waiting_validation
    respond_with({:code => HttpResponse::CODE_ERROR_MISSING_PARAMETER, :message => HttpResponse.code_msg(HttpResponse::CODE_ERROR_MISSING_PARAMETER)}) and return unless params[:game_id]
    begin
      game = Game.where(:id => params[:game_id]).last
      respond_with({:code => HttpResponse::CODE_GAME_NOT_FOUND, :message => HttpResponse.code_msg(HttpResponse::CODE_GAME_NOT_FOUND)}) and return unless game
      gor = game.game_over_requests.where('validation_time IS NULL').last
      respond_with({:code => HttpResponse::CODE_SUCCESS, :message => HttpResponse.code_msg(HttpResponse::CODE_SUCCESS),
                    :board => game.current_board}) and return unless gor
      respond_with({:code => HttpResponse::CODE_SUCCESS, :message => HttpResponse.code_msg(HttpResponse::CODE_SUCCESS), :game_over_request_id => gor.id})
    rescue Exception => e
      respond_with({:code => HttpResponse::CODE_UNKNOWN_ERROR,
                    :message => HttpResponse.code_msg(HttpResponse::CODE_UNKNOWN_ERROR) + e.message})
    end
  end

  #params: id
  #response: :code, :message, :game_over_request
  def show
    respond_with({:code => HttpResponse::CODE_ERROR_MISSING_PARAMETER, :message => HttpResponse.code_msg(HttpResponse::CODE_ERROR_MISSING_PARAMETER)}) and return unless params[:id]
    begin
      gor = GameOverRequest.where(:id => params[:id]).last
      respond_with({:code => HttpResponse::CODE_MOVE_NOT_FOUND, :message => HttpResponse.code_msg(HttpResponse::CODE_MOVE_NOT_FOUND)}) and return unless gor
      respond_with({:code => HttpResponse::CODE_SUCCESS, :message => HttpResponse.code_msg(HttpResponse::CODE_SUCCESS),
                    :game_over_request => {:game_id => gor.game_id, :winner => gor.winner.try(:name),
                                           :requestor => gor.requestor.try(:player).try(:name), :legal => gor.legal,
                                           :validation_time => gor.validation_time}})
    rescue Exception => e
      respond_with({:code => HttpResponse::CODE_UNKNOWN_ERROR,
                    :message => HttpResponse.code_msg(HttpResponse::CODE_UNKNOWN_ERROR) + e.message})
    end
  end

end
