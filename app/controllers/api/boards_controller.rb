class Api::BoardsController < ApplicationController
  def index
    @boards = Board.all
    render :index
  end

  def create
    @board = Board.new(board_params)

    if @board.save
      render :create, status: :created
    else
      @error = @board.errors.full_messages.join(', ')
      render 'api/shared/error', status: :unprocessable_entity
    end
  rescue ActionController::ParameterMissing
    @error = 'Invalid board data provided'
    render 'api/shared/error', status: :unprocessable_entity
  end

  def show

    if Board.exists?(params[:id])
      @board = Board.find(params[:id])

      render :show
    else
      @error = 'Something went wrong'
      render 'api/shared/error', status: :unprocessable_entity
    end
  end

  private

  def board_params
    params.require(:board).permit(:title)
  end
end
