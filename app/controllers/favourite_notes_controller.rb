class FavouriteNotesController < ApplicationController
skip_before_action :authenticate_user!, only: [:index, :show]
before_action :set_favouritenote, only: [:show, :edit, :update, :destroy]

  def index
    @favourite_notes = Favourite_note.all || "0"
    @current_user = current_user
  end

  def show
  end

  def new
    @favourite_note = Favourite_note.new
    @note = @favourite_note.note
  end

  def create
    @favourite_note = Favourite_note.new(favourite_note_params)
    @notes = @favourite_note.note
    @favourite_note.user_id = current_user.id
    if @favourite_note.save
      redirect_to note_path(@note), notice: "A new Favourite Note has been created!"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @favourite_note.update(favourite_note_params)
      redirect_to @note, notice: 'Your Favourite Note was successfully updated'
    else
      render :edit
    end
  end

  def destroy
    @favourite_note.destroy
    redirect_to notes_url, notice: 'Your FavouriteNote was successfully destroyed'
  end

  private

  def favourite_note_params
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
