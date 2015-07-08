class Api::V1::PlayersController < Api::ApiController

  def index
    @players = Player.all
    respond_to do |format|
      format.json { render json: @players }
      format.xml { render xml: @players }
    end
  end

  def show
    @player = Player.find_by(id: params[:id])

    if @player.nil?
      respond_to do |format|
        format.json { render json: "Player not found", status: :not_found }
        format.xml { render xml: ["Player not found"], status: :not_found }
      end
    else
      respond_to do |format|
        format.json { render json: @player }
        format.xml { render xml: @player }
      end
    end
  end

  def create
    @player = Player.new(player_params)

    if @player.save
      render json: @player, status: :created
    else
      render json: @player.errors.full_messages, status: :unprocessable_entity
    end
  end


  private


  def player_params
    params.require(:player).permit(:name, :country, :number)
  end

end
