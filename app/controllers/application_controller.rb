class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

 helper_method :game_pic

 # respond_to :js, :json, :html

  def set_player
    @set_player1 = SteamWebApi::Player.new(params['steamidp1'])
  end

  def first_player
    # binding.pry()
   
      if @set_player1
        set_player
      else
        render text: "first player not setting right!"
    end
     render text: @set_player1
  end

  # def player2
    
  #   @player2 = SteamWebApi::Player.new(params['steamidp1'])
  #   #render text: @player.owned_games
  #   render text: @player2.owned_games if @player2
  #   # binding.pry()
  # end

  # def player
  #   SteamWebApi::Player.new(76561197999244486)
  # end

  def library
    library = @set_player1.owned_games(include_played_free_games: true, include_appinfo: true) if first_player

  end

  def library_names
    if library.games
      library.games.map {|game| game["name"] }
    end

  end

  def this_game
    # binding.pry
    if library.games
      library.games.select {|game| game["name"] == "Dota 2"}
    # library.games.first
    end
  end

  def fred
    render text: "fred was here"
  end

  def steam_fred
    # binding.pry
    return_value = player.summary.profile['personaname'] if @player
    render text: return_value
  end

  def game_name
    return_value = this_game.map { |stuff| stuff['name']}.pop if this_game
    render text: return_value
  end

  def game_appid
    if this_game
      this_game.map { |stuff| stuff['appid']}.pop
    end
  end

  def game_playtime
    return_value = ''
    if this_game
      game_playtime_minutes = this_game.map { |stuff| stuff['playtime_forever']}.pop
      game_playtime_hours = game_playtime_minutes.to_f/60
      return_value = game_playtime_hours.round(2)
    end
    render text: return_value
  end

  def game_pic_url
    if this_game
      this_game.map { |stuff| stuff['img_logo_url']}.pop
    end
  end

  def game_pic
    if this_game
      "http://media.steampowered.com/steamcommunity/public/images/apps/#{game_appid}/#{game_pic_url}.jpg"
    end
  end

  def game_picture
    render text: game_pic
  end

  def show_library
    render text: library_names if library
  end

  
end

