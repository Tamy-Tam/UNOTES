class FavouriteNotesController < ApplicationController
skip_before_action :authenticate_user!, only: [:index, :show]
before_action :set_favouritenote, only: [:show, :edit, :update, :destroy]

  def index
    @favourite_notes = Favourite_note.all || "0"
    @current_user = current_user
    @ycourses_url = @ycourses.map do |ycourse|
      get_youtube_id(ycourse.url)
    end
    @fav_notes = Favourite_note.all || "0"

    if params[:search].present?
      @search_favourite_notes = FavouriteNote.where("content ILIKE ?", "%#{params[:search]}%")
      @search_ycourse = @search_favourite_notes.map do |ycourse|
        get_youtube_id(Ycourse.find(ycourse.ycourse_id).url)
      end
    else
      @search_favourite_notes = @favourite_note
    end
  end

  def show
    authorize @favourite_note
    @ycourse = Ycourse.find(params[:id]) || "0"
    @ycourseID = get_youtube_id(@ycourse.url)
  end

  def new
    @favourite_note = Favourite_note.new
    @ycourse = Ycourse.new
    @favourite_note.ycourse = @ycourse
    authorize @favourite_note
  end

  def create
    @favourite_note = Favourite_note.new(note_params)
    @notes = @favourite_note.note
    @favourite_note.user_id = current_user.id
    if @favourite_note.save
      redirect_to note_path(@favourite_note), notice: "A new Favourite Note has been created!"
    else
      render :new
    end
  end

  def edit
    authorize @favourite_note
  end

  def update
    authorize @favourite_note
    if @favourite_note.update(note_params)
      redirect_to @favourite_note, notice: 'Your Favourite Note was successfully updated'
    else
      render :edit
    end
  end

  def destroy
    authorize @favourite_note
    @favourite_note.destroy
    redirect_to notes_url, notice: 'Your FavouriteNote was successfully destroyed'
  end

  private

  def note_params
    params.require(:FavouriteNote).permit()
  end

  def set_favouritenote
    @favourite_note = Favourite_note.find(params[:id])
  end

  def get_youtube_id(url)
    url = url.gsub(/(>|<)/i, '').split(%r{(vi/|v=|/v/|youtu\.be/|/embed/)})
    return url if url[2].nil?

    id = url[2].split(/[^0-9a-z_\-]/i)
    id[0]
  end
end
