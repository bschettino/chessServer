class HttpResponse

  CODE_SUCCESS = 0
  CODE_ERROR_MISSING_PARAMETER = 1
  CODE_UNKNOWN_ERROR = 2
  CODE_ALREADY_PLAYING = 3
  CODE_MAX_NUMBER_REACHED = 4
  CODE_GAME_NOT_FOUND = 5
  CODE_GAME_PLAYER_NOT_FOUND = 6
  CODE_MOVE_NOT_FOUND = 7
  CODE_PLAYER_CANT_VALIDATE = 8
  CODE_LAST_MOVE_NOT_VALIDATED = 9
  CODE_LAST_MOVE_FROM_SAME_PLAYER = 10
  CODE_INVALID_BOOLEAN = 11
  CODE_PLAYER_ONE_SHOULD_START_GAME = 12
  CODE_WAITING_OTHER_PLAYER_VALIDATION = 13
  CODE_GAME_FINISHED = 14
  CODE_REQUEST_REFUSED = 15
  CODE_NO_MOVES_TO_VALIDATE = 16
  CODE_ALREADY_VALIDATED = 17
  CODE_GOR_NOT_FOUND = 18
  CODE_NO_GOR_TO_VALIDATE = 19
  CODE_INVALID_RESULT = 20
  CODE_INVALID_MOVE_TYPE = 21

  VALID_BOOLEAN_VALUES = ['true', 'false']

  RESULT_LOST = -1
  RESULT_DRAW = 0
  RESULT_WON = 1
  VALID_RESULT_VALUES = [RESULT_LOST, RESULT_DRAW, RESULT_WON]

  def self.code_msg(code)
    case(code)
      when CODE_SUCCESS
        I18n.t("messages.errors.http_response.success")
      when CODE_ERROR_MISSING_PARAMETER
        I18n.t("messages.errors.http_response.error_mis_param")
      when CODE_UNKNOWN_ERROR
        I18n.t("messages.errors.general.unknow_error")
      when CODE_ALREADY_PLAYING
        I18n.t("messages.errors.game.already_playing")
      when CODE_MAX_NUMBER_REACHED
        I18n.t("messages.errors.game.max_number_reached")
      when CODE_GAME_NOT_FOUND
        I18n.t("messages.errors.game.game_not_found")
      when CODE_GAME_PLAYER_NOT_FOUND
        I18n.t("messages.errors.game.game_player_not_found")
      when CODE_MOVE_NOT_FOUND
        I18n.t("messages.errors.move.move_not_found")
      when CODE_PLAYER_CANT_VALIDATE
        I18n.t("messages.errors.move.player_cant_validate")
      when CODE_LAST_MOVE_NOT_VALIDATED
        I18n.t("messages.errors.move.last_move_not_validated")
      when CODE_LAST_MOVE_FROM_SAME_PLAYER
        I18n.t("messages.errors.move.last_move_from_same_player")
      when CODE_INVALID_BOOLEAN
        I18n.t("messages.errors.http_response.invalid_boolean")
      when CODE_PLAYER_ONE_SHOULD_START_GAME
        I18n.t("messages.errors.move.player_one_should_start_game")
      when CODE_WAITING_OTHER_PLAYER_VALIDATION
        I18n.t("messages.errors.game_over_request.waiting_other_player_validation")
      when CODE_GAME_FINISHED
        I18n.t("messages.errors.game_over_request.game_finished")
      when CODE_REQUEST_REFUSED
        I18n.t("messages.errors.game_over_request.request_refused")
      when CODE_NO_MOVES_TO_VALIDATE
        I18n.t("messages.errors.move.no_moves_to_validate")
      when CODE_ALREADY_VALIDATED
        I18n.t("messages.errors.move.already_validated")
      when CODE_GOR_NOT_FOUND
        I18n.t("messages.errors.game_over_request.not_found")
      when CODE_NO_GOR_TO_VALIDATE
        I18n.t("messages.errors.game_over_request.no_gor_to_validate")
      when CODE_INVALID_RESULT
        I18n.t("messages.errors.game_over_request.invalid_result")
      when CODE_INVALID_MOVE_TYPE
        I18n.t("messages.errors.move.invalid_move_type")
    end

  end


end