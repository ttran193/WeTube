class Api::VideosController < ApplicationController
  def index
    @videos = Video.all
    render :index
  end

  def show
    @video = Video.find(params[:id])
    render :show
  end

  def create
    @video = Video.new(video_params)

    if @video.save
      render :show
    else
      render json: @video.errors.full_messages, status: 422
    end
  end

  def update
    @video = Video.find_by(id: params[:id])

    if @video && current_user.id == @video.uploader_id
      render :show
    else
      render json: @video.errors.full_messages
    end
  end

  def destroy
    @video = Video.find_by(id: params[:id])
    debugger
    if @video && @video.uploader_id == current_user.id
      @video.delete
      render json: {message: "Sucess"}
    else
      render json: {message: "Failure"}
    end
  end
  
  private
  def video_params
    params.require(:video).permit(:title, :description, :submission)
  end
end
