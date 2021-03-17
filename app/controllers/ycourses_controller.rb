class YcoursesController < ApplicationController
  before_action :set_ycourse, only: [:show, :edit, :update, :destroy]

  def show
    authorize @ycourse
  end

  def new
    @ycourse = Ycourse.new
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
    redirect_to home_url, notice: 'Your Youtube Course was successfully destroyed'
  end

  private

  def ycourse_params
    params.require(:ycourse).permit(:url)
  end

  def set_ycourse
    @ycourse = Ycourse.find(params[:id])
  end
end
