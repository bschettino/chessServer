class Api::V1::MovesController < ApplicationController

  respond_to :json, :xml

  #params: move_from, move_to, game_id, player_key
  #response: :code, :message, :move_id
  def new_move
    respond_with({:code => HttpResponse::CODE_ERROR_MISSING_PARAMETER, :message => HttpResponse.code_msg(HttpResponse::CODE_ERROR_MISSING_PARAMETER)}) and return unless params[:player_key] && params[:game_id] && params[:move_from] && params[:move_to]
    begin
      game = Game.where(:id => params[:game_id]).last
      respond_with({:code => HttpResponse::CODE_GAME_NOT_FOUND, :message => HttpResponse.code_msg(HttpResponse::CODE_GAME_NOT_FOUND)}) and return unless game
      gp = game.game_players.where(:player_key => params[:player_key]).last
      respond_with({:code => HttpResponse::CODE_GAME_PLAYER_NOT_FOUND, :message => HttpResponse.code_msg(HttpResponse::CODE_GAME_PLAYER_NOT_FOUND)}) and return unless gp
      last_move = game.moves.last
      if last_move
        respond_with({:code => HttpResponse::CODE_LAST_MOVE_NOT_VALIDATED, :message => HttpResponse.code_msg(HttpResponse::CODE_LAST_MOVE_NOT_VALIDATED)}) and return if !last_move.validation_time
        if last_move.legal
          respond_with({:code => HttpResponse::CODE_LAST_MOVE_FROM_SAME_PLAYER, :message => HttpResponse.code_msg(HttpResponse::CODE_LAST_MOVE_FROM_SAME_PLAYER)}) and return if last_move.game_player == gp
        else
          respond_with({:code => HttpResponse::CODE_LAST_MOVE_FROM_SAME_PLAYER, :message => HttpResponse.code_msg(HttpResponse::CODE_LAST_MOVE_FROM_SAME_PLAYER)}) and return if last_move.game_player != gp
        end
      else
        respond_with({:code => HttpResponse::CODE_PLAYER_ONE_SHOULD_START_GAME, :message => HttpResponse.code_msg(HttpResponse::CODE_PLAYER_ONE_SHOULD_START_GAME)}) and return if game.players.first != gp.player

      end

      move = Move.create(:from => params[:move_from], :to => params[:move_to], :game_player_id => gp.id)
      respond_with({:code => HttpResponse::CODE_SUCCESS, :message => HttpResponse.code_msg(HttpResponse::CODE_SUCCESS),
                    :move_id => move.id})
    rescue Exception => e
      respond_with({:code => HttpResponse::CODE_UNKNOWN_ERROR,
                    :message => HttpResponse.code_msg(HttpResponse::CODE_UNKNOWN_ERROR) + e.message})
    end
  end

  #params: move_id, player_key, valid
  #response: :code, :message, :board
  def validate
    respond_with({:code => HttpResponse::CODE_ERROR_MISSING_PARAMETER, :message => HttpResponse.code_msg(HttpResponse::CODE_ERROR_MISSING_PARAMETER)}) and return unless params[:player_key] && params[:move_id] && params[:valid]
    begin
      respond_with({:code => HttpResponse::CODE_INVALID_BOOLEAN, :message => HttpResponse.code_msg(HttpResponse::CODE_INVALID_BOOLEAN)}) and return unless params[:valid].in?(HttpResponse::VALID_BOOLEAN_VALUES)
      move = Move.where(:id => params[:move_id]).last
      respond_with({:code => HttpResponse::CODE_MOVE_NOT_FOUND, :message => HttpResponse.code_msg(HttpResponse::CODE_MOVE_NOT_FOUND)}) and return unless move
      respond_with({:code => HttpResponse::CODE_ALREADY_VALIDATED, :message => HttpResponse.code_msg(HttpResponse::CODE_ALREADY_VALIDATED)}) and return if move.validation_time

      gp = GamePlayer.where(:player_key => params[:player_key]).last
      respond_with({:code => HttpResponse::CODE_GAME_PLAYER_NOT_FOUND, :message => HttpResponse.code_msg(HttpResponse::CODE_GAME_PLAYER_NOT_FOUND)}) and return unless gp
      respond_with({:code => HttpResponse::CODE_PLAYER_CANT_VALIDATE, :message => HttpResponse.code_msg(HttpResponse::CODE_PLAYER_CANT_VALIDATE)}) and return if move.game_player == gp
      game = gp.game
      move.player_validate(params[:valid])
      respond_with({:code => HttpResponse::CODE_SUCCESS, :message => HttpResponse.code_msg(HttpResponse::CODE_SUCCESS), :board => game.current_board})
    rescue Exception => e
      respond_with({:code => HttpResponse::CODE_UNKNOWN_ERROR,
                    :message => HttpResponse.code_msg(HttpResponse::CODE_UNKNOWN_ERROR) + e.message})
    end
  end

  #params: game_id
  #response: :code, :message, (:move_id || :board, :next_player)
  def waiting_validation
    respond_with({:code => HttpResponse::CODE_ERROR_MISSING_PARAMETER, :message => HttpResponse.code_msg(HttpResponse::CODE_ERROR_MISSING_PARAMETER)}) and return unless params[:game_id]
    begin
      game = Game.where(:id => params[:game_id]).last
      respond_with({:code => HttpResponse::CODE_GAME_NOT_FOUND, :message => HttpResponse.code_msg(HttpResponse::CODE_GAME_NOT_FOUND)}) and return unless game
      move = game.moves.where('validation_time IS NULL').last
      respond_with({:code => HttpResponse::CODE_SUCCESS, :message => HttpResponse.code_msg(HttpResponse::CODE_SUCCESS), :move_id => move.id}) and return if move

      next_player = game.next_player
      respond_with({:code => HttpResponse::CODE_SUCCESS, :message => HttpResponse.code_msg(HttpResponse::CODE_SUCCESS),
                    :board => game.current_board, :next_player => next_player.name})

    rescue Exception => e
      respond_with({:code => HttpResponse::CODE_UNKNOWN_ERROR,
                    :message => HttpResponse.code_msg(HttpResponse::CODE_UNKNOWN_ERROR) + e.message})
    end
  end

  #params: id
  #response: :code, :message, :move_from, :move_to
  def show
    respond_with({:code => HttpResponse::CODE_ERROR_MISSING_PARAMETER, :message => HttpResponse.code_msg(HttpResponse::CODE_ERROR_MISSING_PARAMETER)}) and return unless params[:id]
    begin
      move = Move.where(:id => params[:id]).last
      respond_with({:code => HttpResponse::CODE_MOVE_NOT_FOUND, :message => HttpResponse.code_msg(HttpResponse::CODE_MOVE_NOT_FOUND)}) and return unless move
      respond_with({:code => HttpResponse::CODE_SUCCESS, :message => HttpResponse.code_msg(HttpResponse::CODE_SUCCESS),
                    :move => {:from => move.from, :to => move.to, :legal => move.legal, :validation_time => move.validation_time}})
    rescue Exception => e
      respond_with({:code => HttpResponse::CODE_UNKNOWN_ERROR,
                    :message => HttpResponse.code_msg(HttpResponse::CODE_UNKNOWN_ERROR) + e.message})
    end
  end

end
