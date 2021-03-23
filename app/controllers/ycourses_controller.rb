class YcoursesController < ApplicationController
  before_action :set_ycourse, only: [:edit, :update, :destroy]

  def show
    authorize @ycourse
    @ycourse = Ycourse.find(params[:id]) || "0"
    @ycourseID = get_youtube_id(@ycourse.url)
  end

  def new
    url = params[:yt_url]
    @ycourse = Ycourse.new
    @ycourse.url = url ? url : nil
    authorize @ycourse
  end

  def create
    @ycourse = Ycourse.new(ycourse_params)
    @note = Note.new
    @note.ycourse = @ycourse
    @note.user = current_user
    authorize @ycourse
    if @ycourse.save && @note.save
      redirect_to note_path(@note), notice: "A new Youtube Course has been added!"
    else
      render :new
    end
  end

  def destroy
    authorize @ycourse
    @ycourse.destroy
    redirect_to "/", notice: 'Your Youtube Course was successfully deleted'
  end

  private

  def ycourse_params
    params.require(:ycourse).permit(:url)
  end

  def set_ycourse
    @ycourse = Ycourse.find(params[:id])
  end

  def get_youtube_id(url)
    url = url.gsub(/(>|<)/i, '').split(%r{(vi/|v=|/v/|youtu\.be/|/embed/)})
    return url if url[2].nil?

    id = url[2].split(/[^0-9a-z_\-]/i)
    id[0]
  end
end
