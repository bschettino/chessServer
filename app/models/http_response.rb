class HttpResponse

  CODE_SUCCESS = 0
  CODE_ERROR_MISSING_PARAMETER = 1
  CODE_UNKNOWN_ERROR = 2
  CODE_ALREADY_PLAYING = 3
  CODE_MAX_NUMBER_REACHED = 4
  CODE_GAME_NOT_FOUND = 5

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
    end

  end


end