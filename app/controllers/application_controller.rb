class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

 helper_method :game_pic


  # def player
  #   if "steamidp1" == nil
  #   else
  #     player = SteamWebApi::Player.new(params['steamidp1']) 
  #   end
  #   # binding.pry
  # end

  def player
    player = SteamWebApi::Player.new(76561197999244486)
  end

  def library
    @player = player
    library = @player.owned_games(include_played_free_games: true, include_appinfo: true)

  end

  def library_names
    if library.games == nil
    else
      library.games.map {|game| game["name"] }
    end

  end

  def this_game
    if library.games == nil
    else
      library.games.select {|game| game["name"] == "Dota 2"}
    # library.games.first
    end
  end

  def fred
    render text: "fred was here"
  end

  def steam_fred
    render text: player.summary.profile['personaname']
  end

  def game_name
    render text: this_game.map { |stuff| stuff['name']}.pop
  end

  def game_appid
    if this_game == nil
    else
      this_game.map { |stuff| stuff['appid']}.pop
    end
  end

  def game_playtime
    game_playtime_minutes = this_game.map { |stuff| stuff['playtime_forever']}.pop
    game_playtime_hours = game_playtime_minutes.to_f/60
    render text: game_playtime_hours.round(2)
  end

  def game_pic_url
    if this_game == nil
    else
      this_game.map { |stuff| stuff['img_logo_url']}.pop
    end
  end

  def game_pic
    if this_game == nil
    else 
      "http://media.steampowered.com/steamcommunity/public/images/apps/#{game_appid}/#{game_pic_url}.jpg"
    end
  end

  def show_library
    
    render text: library_names
  end

  
end

